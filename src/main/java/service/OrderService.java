package service;

import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.OrderShippingDAO;
import model.dto.CartItemDTO;
import model.entity.Cart;
import model.entity.Order;
import model.entity.OrderItem;

import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;
import java.util.logging.Logger;
import java.util.logging.Level;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class OrderService {

    private static final Logger LOGGER = Logger.getLogger(OrderService.class.getName());

    private static final OrderDAO         orderDAO         = new OrderDAO();
    private static final OrderItemDAO     orderItemDAO     = new OrderItemDAO();
    private static final OrderShippingDAO orderShippingDAO = new OrderShippingDAO();

    public static int placeOrder(int    userId,
                                 int    addressId,
                                 String recipientName,
                                 String phone,
                                 String city,
                                 String ward,
                                 String address,
                                 int provinceId,
                                 int districtId,
                                 String wardCode,
                                 String notes,
                                 String voucherCode,
                                 List<Integer> selectedVariantIds) {
        try {
            Cart cart = CartService.getOrCreateCartByUserId(userId);
            int cartId = cart.getId();

            List<CartItemDTO> allItems = CartService.getListItems(cartId);
            if (allItems == null || allItems.isEmpty()) {
                return -1;
            }

            List<CartItemDTO> itemsToOrder;
            if (selectedVariantIds != null && !selectedVariantIds.isEmpty()) {
                itemsToOrder = allItems.stream()
                        .filter(item -> selectedVariantIds.contains(item.getProductVariantId()))
                        .collect(Collectors.toList());
            } else {
                itemsToOrder = allItems;
            }

            if (itemsToOrder.isEmpty()) {
                return -1;
            }

            double totalProductsPrice = itemsToOrder.stream()
                    .mapToDouble(CartItemDTO::getTotalItemPrice)
                    .sum();
            double shippingFee        = 30000;
            double discountAmount     = 0;
            Integer vouchersId        = null;

            if (voucherCode != null && !voucherCode.isBlank()) {
                LOGGER.log(Level.INFO, "Using voucher code: {0}", voucherCode);
            }

            double finalAmount = totalProductsPrice + shippingFee - discountAmount;

            int orderId = orderDAO.createOrder(
                    userId, vouchersId,
                    totalProductsPrice, shippingFee,
                    discountAmount, finalAmount
            );
            if (orderId <= 0) {
                return -1;
            }

            for (CartItemDTO item : itemsToOrder) {
                orderItemDAO.insertOrderItem(
                        orderId,
                        item.getProductVariantId(),
                        item.getQuantity(),
                        item.getPrice()
                );
            }

            int userAddressId = addressId;
            String fullAddress = address + ", " + ward + ", " + city;
            if (userAddressId <= 0) {
                userAddressId = orderShippingDAO.insertUserAddress(
                        userId, recipientName, phone, city, fullAddress, provinceId, districtId, wardCode
                );
            }

            String shippingOrderCode = "";
            try {
                Order mockOrder = new Order();
                mockOrder.setFinalAmount(java.math.BigDecimal.valueOf(finalAmount));

                List<OrderItem> mockItems = new ArrayList<>();
                for (CartItemDTO item : itemsToOrder) {
                    OrderItem oi = new OrderItem();

                    String productNameTmp = "AuraSound Equipment";
                    if (item.getName() != null && !item.getName().trim().isEmpty()) {
                        productNameTmp = item.getName();
                    }

                    oi.setProductName(productNameTmp);
                    oi.setQuantity(item.getQuantity());
                    mockItems.add(oi);
                }
                mockOrder.setItems(mockItems);

                String ghnResponse = GHNService.createShippingOrder(
                        mockOrder, recipientName, phone, fullAddress, city, wardCode, districtId
                );

                if (ghnResponse != null && ghnResponse.trim().startsWith("{")) {
                    Gson gson = new Gson();
                    JsonObject jsonObj = gson.fromJson(ghnResponse, JsonObject.class);

                    int ghnCode = jsonObj.has("code") ? jsonObj.get("code").getAsInt() : 0;

                    if (ghnCode == 200 && jsonObj.has("data") && !jsonObj.get("data").isJsonNull()) {
                        JsonObject dataObj = jsonObj.getAsJsonObject("data");
                        if (dataObj.has("order_code") && !dataObj.get("order_code").isJsonNull()) {
                            shippingOrderCode = dataObj.get("order_code").getAsString();
                        }
                    } else {
                        String errorMsg = jsonObj.has("message") ? jsonObj.get("message").getAsString() : "Unknown business error";
                        LOGGER.log(Level.WARNING, "GHN API Business Refusal (Code {0}): {1}", new Object[]{ghnCode, errorMsg});
                    }
                } else {
                    LOGGER.log(Level.SEVERE, "GHN API Endpoint error or invalid response format. Raw Response: {0}", ghnResponse);
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Exception occurred during GHNService communication layer", e);
            }

            orderShippingDAO.insertOrderShipping(orderId, userAddressId, notes);

            if (shippingOrderCode != null && !shippingOrderCode.trim().isEmpty()) {
                orderDAO.updateShippingOrderCode(orderId, shippingOrderCode);
                LOGGER.info("GHN integration completed successfully. Order code: " + shippingOrderCode);
            } else {
                LOGGER.warning("Internal order created successfully, but syncing with GHN failed.");
            }

            return orderId;

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Critical exception caught in placeOrder logic flow", e);
            return -1;
        }
    }
}