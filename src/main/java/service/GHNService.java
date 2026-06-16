package service;

import model.entity.Order;
import model.entity.OrderItem;

import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Properties;

public class GHNService {

    private static String TOKEN;
    private static String SHOP_ID;
    private static final String BASE_URL = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2";


    static {
        try (InputStream input = GHNService.class.getClassLoader().getResourceAsStream("ghn.properties")) {
            Properties prop = new Properties();
            if (input == null) {
                System.err.println("Cảnh báo: Không tìm thấy file ghn.properties trong thư mục resources!");
            } else {
                prop.load(input);
                TOKEN = prop.getProperty("ghn.api.token");
                SHOP_ID = prop.getProperty("ghn.shop.id");
            }
        } catch (Exception ex) {
            System.err.println("Lỗi khi đọc file ghn.properties: " + ex.getMessage());
        }
    }

    // đồng bộ thông tin đơn hàng sang GHN
    public static String createShippingOrder(Order order, String recipientName, String phone, String address, String city, String wardCode, int districtId) throws Exception {
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
                if (i < order.getItems().size() - 1) {
                    itemsJson.append(",");
                }
            }
        } else {
            itemsJson.append("{\"name\":\"Thiet bi am thanh AuraSound\",\"quantity\":1}");
        }
        itemsJson.append("]");

        String cleanWardCode = (wardCode == null || wardCode.trim().isEmpty()) ? "20314" : wardCode;
        int cleanDistrictId = (districtId <= 0) ? 1444 : districtId;

        String jsonPayload = "{"
                + "\"payment_type_id\": 2,"
                + "\"required_note\": \"KHONGCHOXEMHANG\","
                + "\"to_name\": \"" + recipientName.replace("\"", "\\\"") + "\","
                + "\"to_phone\": \"" + phone + "\","
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

        HttpClient client = HttpClient.newHttpClient();
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

   // cập nhật trạng thái
    public static String getOrderLogProgress(String shippingOrderCode) throws Exception {
        String endpoint = BASE_URL + "/shipping-order/detail";
        String jsonPayload = "{\"order_code\": \"" + shippingOrderCode + "\"}";

        HttpClient client = HttpClient.newHttpClient();
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