package service;

import model.entity.Order;
import model.entity.OrderItem;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Properties;

public class GHNService {

    private static final String BASE_URL = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2";
    private static final int    FROM_DISTRICT_ID = 1444;  // Linh Xuân, Thủ Đức, TP.HCM
    private static final String FROM_WARD_CODE = "20314"; // Mã phường Linh Xuân, Thủ Đức khớp với quận 1444

    // Hardcode fallback — đảm bảo không bao giờ null dù properties không load được
    private static String TOKEN   = "dffec2e1-6725-11f1-a973-aee5264794df";
    private static String SHOP_ID = "200679";

    static {
        try (InputStream input = GHNService.class.getClassLoader().getResourceAsStream("ghn.properties")) {
            if (input != null) {
                Properties prop = new Properties();
                prop.load(input);
                String t = prop.getProperty("ghn.api.token");
                String s = prop.getProperty("ghn.shop.id");
                if (t != null && !t.isBlank()) TOKEN   = t;
                if (s != null && !s.isBlank()) SHOP_ID = s;
                System.out.println("[GHN] Loaded from properties: shopId=" + SHOP_ID);
            } else {
                System.out.println("[GHN] ghn.properties không tìm thấy, dùng hardcode.");
            }
        } catch (Exception ex) {
            System.err.println("[GHN] Lỗi đọc ghn.properties: " + ex.getMessage() + " -> dùng hardcode.");
        }
    }

    // -------------------------------------------------------------------------
    // Lấy service_id — SỬA ĐÚNG KEY THEO TÀI LIỆU GHN API V2
    // -------------------------------------------------------------------------
    public static int getServiceId(int toDistrictId) throws Exception {
        String endpoint = BASE_URL + "/shipping-order/available-services";

        int shopIdInt = Integer.parseInt(SHOP_ID.trim());

        // GHN v2 yêu cầu chính xác: "shop_id", "from_district", "to_district" (chữ thường)
        String json = "{"
                + "\"shop_id\": "       + shopIdInt        + ","
                + "\"from_district\": " + FROM_DISTRICT_ID + ","
                + "\"to_district\": "   + toDistrictId
                + "}";

        System.out.println("[GHN services] request body: " + json);

        HttpClient client   = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint))
                .header("Content-Type", "application/json")
                .header("Token", TOKEN)
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        System.out.println("[GHN services] response: " + response.body());

        JsonObject root = JsonParser.parseString(response.body()).getAsJsonObject();
        if (root.get("code").getAsInt() == 200) {
            JsonArray services = root.getAsJsonArray("data");
            // Ưu tiên gói dịch vụ Chuẩn (loại 2 = Hàng nhẹ / E-commerce)
            for (int i = 0; i < services.size(); i++) {
                JsonObject svc = services.get(i).getAsJsonObject();
                if (svc.has("service_type_id") && svc.get("service_type_id").getAsInt() == 2) {
                    int id = svc.get("service_id").getAsInt();
                    System.out.println("[GHN services] Chọn service_id=" + id + " (type 2)");
                    return id;
                }
            }
            if (services.size() > 0) {
                int id = services.get(0).getAsJsonObject().get("service_id").getAsInt();
                System.out.println("[GHN services] Không có type 2, dùng service_id=" + id);
                return id;
            }
        }
        System.err.println("[GHN services] Không lấy được service_id: " + response.body());
        return -1;
    }

    // -------------------------------------------------------------------------
    // Tính phí vận chuyển
    // -------------------------------------------------------------------------
    public static int calculateShippingFee(int toDistrictId, String toWardCode, int weightInGrams) throws Exception {
        String endpoint = BASE_URL + "/shipping-order/fee";

        String json = "{"
                + "\"from_district_id\": " + FROM_DISTRICT_ID + ","
                + "\"to_district_id\": "   + toDistrictId + ","
                + "\"to_ward_code\": \""   + toWardCode + "\","
                + "\"weight\": "           + weightInGrams + ","
                + "\"service_type_id\": 2"
                + "}";

        HttpClient client   = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint))
                .header("Content-Type", "application/json")
                .header("Token", TOKEN)
                .header("ShopId", SHOP_ID)
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        System.out.println("[GHN fee] response: " + response.body());

        JsonObject root = JsonParser.parseString(response.body()).getAsJsonObject();
        if (root.get("code").getAsInt() == 200) {
            return root.getAsJsonObject("data").get("total").getAsInt();
        }
        System.err.println("[GHN fee] Lỗi: code=" + root.get("code") + " msg=" + root.get("message"));
        return -1;
    }

    // -------------------------------------------------------------------------
    // Thời gian giao hàng dự kiến
    // -------------------------------------------------------------------------
    public static long getExpectedDeliveryDate(int toDistrictId, String toWardCode) throws Exception {
        String endpoint = BASE_URL + "/shipping-order/leadtime";

        int serviceId = getServiceId(toDistrictId);
        if (serviceId <= 0) {
            System.err.println("[GHN leadtime] Không lấy được service_id hợp lệ, trả -1");
            return -1;
        }

        // Đã thay hardcode "20308" thành biến tĩnh FROM_WARD_CODE ("20314") cho đồng bộ
        String json = "{"
                + "\"from_district_id\": " + FROM_DISTRICT_ID + ","
                + "\"from_ward_code\": \"" + FROM_WARD_CODE + "\","
                + "\"to_district_id\": "   + toDistrictId + ","
                + "\"to_ward_code\": \""   + toWardCode + "\","
                + "\"service_id\": "       + serviceId
                + "}";

        System.out.println("[GHN leadtime] request body: " + json);

        HttpClient client   = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint))
                .header("Content-Type", "application/json")
                .header("Token", TOKEN)
                .header("ShopId", SHOP_ID)
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        System.out.println("[GHN leadtime] response: " + response.body());

        JsonObject root = JsonParser.parseString(response.body()).getAsJsonObject();
        if (root.get("code").getAsInt() == 200) {
            long leadtime = root.getAsJsonObject("data").get("leadtime").getAsLong();
            if (leadtime > 0) {
                System.out.println("[GHN leadtime] leadtime=" + leadtime);
                return leadtime;
            }
        }
        System.err.println("[GHN leadtime] Lỗi hoặc leadtime=0: " + response.body());
        return -1;
    }

    // -------------------------------------------------------------------------
    // Tạo đơn giao hàng trên GHN
    // -------------------------------------------------------------------------
    public static String createShippingOrder(Order order, String recipientName, String phone,
                                             String address, String city, String wardCode, int districtId) throws Exception {
        String endpoint = BASE_URL + "/shipping-order/create";

        StringBuilder itemsJson = new StringBuilder("[");
        if (order.getItems() != null && !order.getItems().isEmpty()) {
            for (int i = 0; i < order.getItems().size(); i++) {
                OrderItem item = order.getItems().get(i);
                String pName = item.getProductName();
                if (pName == null || pName.trim().isEmpty()) {
                    pName = "Thiet bi am thanh AuraSound";
                }
                pName = pName.replace("\"", "\\\"");
                itemsJson.append(String.format("{\"name\":\"%s\",\"quantity\":%d}", pName, item.getQuantity()));
                if (i < order.getItems().size() - 1) itemsJson.append(",");
            }
        } else {
            itemsJson.append("{\"name\":\"Thiet bi am thanh AuraSound\",\"quantity\":1}");
        }
        itemsJson.append("]");

        String cleanWardCode   = (wardCode == null || wardCode.trim().isEmpty()) ? FROM_WARD_CODE : wardCode;
        int    cleanDistrictId = (districtId <= 0) ? FROM_DISTRICT_ID : districtId;

        String jsonPayload = "{"
                + "\"payment_type_id\": 1,"
                + "\"required_note\": \"KHONGCHOXEMHANG\","
                + "\"to_name\": \""    + recipientName.replace("\"", "\\\"") + "\","
                + "\"to_phone\": \""   + phone + "\","
                + "\"to_address\": \"" + address.replace("\"", "\\\"") + "\","
                + "\"to_ward_code\": \"" + cleanWardCode + "\","
                + "\"to_district_id\": " + cleanDistrictId + ","
                + "\"weight\": 200,"
                + "\"length\": 10,"
                + "\"width\": 10,"
                + "\"height\": 10,"
                + "\"service_type_id\": 2,"
                + "\"cod_amount\": " + order.getFinalAmount().intValue() + ","
                + "\"items\": " + itemsJson.toString()
                + "}";

        HttpClient client   = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint))
                .header("Content-Type", "application/json")
                .header("Token", TOKEN)
                .header("ShopId", SHOP_ID)
                .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        return response.body();
    }

    // -------------------------------------------------------------------------
    // Tra cứu trạng thái đơn giao hàng
    // -------------------------------------------------------------------------
    public static String getOrderLogProgress(String shippingOrderCode) throws Exception {
        String endpoint    = BASE_URL + "/shipping-order/detail";
        String jsonPayload = "{\"order_code\": \"" + shippingOrderCode + "\"}";

        HttpClient client   = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(endpoint))
                .header("Content-Type", "application/json")
                .header("Token", TOKEN)
                .header("ShopId", SHOP_ID)
                .POST(HttpRequest.BodyPublishers.ofString(jsonPayload))
                .build();

        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
        return response.body();
    }
}