package controller;

import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.IconLogin.VnPayConfig;
import model.entity.Cart;
import model.entity.Order;
import model.entity.OrderItem;
import service.CartService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.*;

@WebServlet(name = "VnPayReturnServlet", urlPatterns = {"/vnpay_return"})
public class VnPayReturnServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        Map<String, String> fields = new TreeMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String paramName = params.nextElement();
            if (paramName.startsWith("vnp_")
                    && !paramName.equals("vnp_SecureHash")
                    && !paramName.equals("vnp_SecureHashType")) {
                fields.put(paramName, request.getParameter(paramName));
            }
        }

        StringBuilder hashData = new StringBuilder();
        boolean first = true;
        for (Map.Entry<String, String> entry : fields.entrySet()) {
            if (entry.getValue() != null && !entry.getValue().isEmpty()) {
                if (!first) hashData.append('&');
                hashData.append(entry.getKey())
                        .append('=')
                        .append(URLEncoder.encode(entry.getValue(),
                                StandardCharsets.UTF_8.toString()));
                first = false;
            }
        }

        String signValue = VnPayConfig.hmacSHA512(VnPayConfig.vnp_HashSecret, hashData.toString());

        String txnRef = request.getParameter("vnp_TxnRef");
        String orderIdStr = (txnRef != null && txnRef.contains("_")) ? txnRef.split("_")[0] : txnRef;
        int orderId = Integer.parseInt(orderIdStr);
        OrderDAO orderDAO = new OrderDAO();

        if (signValue.equalsIgnoreCase(vnp_SecureHash)) {
            if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                orderDAO.updatePaymentStatus(orderId, 1);

                Order order = orderDAO.getOrderById(orderIdStr);
                List<OrderItem> orderItems = orderDAO.getAllOrdersItem(orderIdStr);

                HttpSession session = request.getSession(false);
                model.entity.User auth = (session != null)
                        ? (model.entity.User) session.getAttribute("auth")
                        : null;

                if (auth == null) {
                    response.sendRedirect(request.getContextPath() + "/login");
                    return;
                }

                int userId = auth.getId();
                Cart cart = CartService.getOrCreateCartByUserId(order.getUserId());

                System.out.println("=== VNPAY CART CLEAR DEBUG ===");
                System.out.println("OrderId: " + orderId);
                System.out.println("UserId: " + order.getUserId());
                System.out.println("CartId: " + cart.getId());
                System.out.println("OrderItems count: " + orderItems.size());
                for (OrderItem item : orderItems) {
                    System.out.println("  Item productVariant: " + (item.getProductVariant() != null ? item.getProductVariant().getId() : "NULL!"));
                }
                for (OrderItem item : orderItems) {
                    CartService.deleteItem(cart.getId(), item.getProductVariant().getId());
                }

                int currentQty = CartService.getListItems(cart.getId()).size();
                request.getSession().setAttribute("cartQty", currentQty);

                service.NotificationService.addNotification("ORDER", "Vừa có đơn đặt hàng mới chờ bạn xác nhận!");

                response.sendRedirect(request.getContextPath() + "/checkout?vnpay=success&orderId=" + orderId);
                //Hủy or ck thất bại
            } else {
                orderDAO.updateOrderStatus(orderId, 3);
                response.sendRedirect(request.getContextPath() + "/checkout?vnpay=cancel");
            }
        } else {
            System.out.println("=== VNPAY HASH MISMATCH ===");
            System.out.println("Expected: " + signValue);
            System.out.println("Received: " + vnp_SecureHash);
            System.out.println("HashData: " + hashData);
            response.sendRedirect(request.getContextPath() + "/checkout?vnpay=invalid_hash");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}