// service/OrderService.java
package service;

import dao.CartDAO;
import dao.OrderDAO;
import dao.OrderItemDAO;
import dao.OrderShippingDAO;
import model.dto.CartItemDTO;
import model.entity.Cart;
import model.entity.Order;
import model.entity.OrderItem;

import java.util.List;
import java.util.stream.Collectors;

public class OrderService {

    private static final OrderDAO         orderDAO         = new OrderDAO();
    private static final OrderItemDAO     orderItemDAO     = new OrderItemDAO();
    private static final OrderShippingDAO orderShippingDAO = new OrderShippingDAO();


    public static int placeOrder(int    userId,
                                 String recipientName,
                                 String phone,
                                 String city,
                                 String ward,
                                 String address,
                                 String notes,
                                 String voucherCode,
                                 List<Integer> selectedVariantIds) {
        try {
            //Lấy ttin cart
            Cart cart = CartService.getOrCreateCartByUserId(userId);
            int  cartId = cart.getId();

            List<CartItemDTO> allItems = CartService.getListItems(cartId);
            if (allItems == null || allItems.isEmpty()) return -1;

            //Lọc sp theo id đc chọn
            List<CartItemDTO> itemsToOrder;
            if (selectedVariantIds != null && !selectedVariantIds.isEmpty()) {
                itemsToOrder = allItems.stream()
                        .filter(item -> selectedVariantIds.contains(item.getProductVariantId()))
                        .collect(Collectors.toList());
            } else {
                itemsToOrder = allItems; // fallback
            }

            if (itemsToOrder.isEmpty()) return -1;

            //Tính tiền
            double totalProductsPrice = itemsToOrder.stream()
                    .mapToDouble(CartItemDTO::getTotalItemPrice)
                    .sum();
            double shippingFee        = 30_000;
            double discountAmount     = 0;
            Integer vouchersId        = null;

            if (voucherCode != null && !voucherCode.trim().isEmpty()) {
                service.VoucherService voucherService = new service.VoucherService();
                try {
                    model.entity.Voucher voucher = voucherService.validateVoucher(voucherCode, totalProductsPrice);
                    if (voucher != null) {
                        vouchersId = voucher.getId();
                        discountAmount = voucher.getDiscountAmount();
                    }
                } catch (Exception e) {
                    System.out.println("Voucher không hợp lệ lúc tạo đơn: " + e.getMessage());
                }
            }
            double finalAmount = totalProductsPrice + shippingFee - discountAmount;

            if (finalAmount < 0) {
                finalAmount = 0;
            }

            //Tạo đơn mới
            int orderId = orderDAO.createOrder(
                    userId, vouchersId,
                    totalProductsPrice, shippingFee,
                    discountAmount, finalAmount
            );
            if (orderId <= 0) return -1;

            //Lưu sp
            for (CartItemDTO item : itemsToOrder) {
                orderItemDAO.insertOrderItem(
                        orderId,
                        item.getProductVariantId(),
                        item.getQuantity(),
                        item.getPrice()
                );
            }

            // Lưu địa chỉ
            String fullAddress = address + ", " + ward + ", " + city;

            int userAddressId = orderShippingDAO.insertUserAddress(
                    userId, recipientName, phone, city, fullAddress
            );

            orderShippingDAO.insertOrderShipping(orderId, userAddressId, notes);

//            // Xóa giỏ sau khi mua
//            for (CartItemDTO item : itemsToOrder) {
//                CartService.deleteItem(cartId, item.getProductVariantId());
//            }

            return orderId;

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    public Order getAdminOrderDetailById(String id) {
        return orderDAO.getAdminOrderDetailById(id);
    }

    public List<OrderItem> getAdminOrderItemsByOrderId(String orderId) {
        return orderDAO.getAdminOrderItemsByOrderId(orderId);
    }
}