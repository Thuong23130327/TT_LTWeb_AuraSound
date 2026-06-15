package service;

import model.entity.Order;
import model.entity.OrderItem;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class GHNService {

    private static final String TOKEN = "dffec2e1-6725-11f1-a973-aee5264794df";
    private static final String SHOP_ID = "200679";
    private static final String BASE_URL = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2";

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
                + "\"payment_type_id\": 1,"
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

    //tính phí ship
    public static int calculateShippingFee(int toDistrictId, String toWardCode, int weightInGrams) throws Exception {
        String endpoint = "https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee";

        String json = "{"
                + "\"from_district_id\": 1442,"
                + "\"to_district_id\": " + toDistrictId + ","
                + "\"to_ward_code\": \"" + toWardCode + "\","
                + "\"weight\": " + weightInGrams + ","
                + "\"service_type_id\": 2"
                + "}";

        java.net.http.HttpClient client = java.net.http.HttpClient.newHttpClient();
        java.net.http.HttpRequest request = java.net.http.HttpRequest.newBuilder()
                .uri(java.net.URI.create(endpoint))
                .header("Content-Type", "application/json")
                .header("Token", "dffec2e1-6725-11f1-a973-aee5264794df") // Token của bạn
                .POST(java.net.http.HttpRequest.BodyPublishers.ofString(json))
                .build();

        java.net.http.HttpResponse<String> response = client.send(request, java.net.http.HttpResponse.BodyHandlers.ofString());

        com.google.gson.JsonObject jsonObject = com.google.gson.JsonParser.parseString(response.body()).getAsJsonObject();
        if (jsonObject.get("code").getAsInt() == 200) {
            return jsonObject.getAsJsonObject("data").get("total").getAsInt();
        }
        return 30000;
    }
}