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
        Map<String, String> fields = new HashMap<>();
        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
            String fieldName = URLEncoder.encode(params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) fields.remove("vnp_SecureHashType");
        if (fields.containsKey("vnp_SecureHash")) fields.remove("vnp_SecureHash");

        List<String> fieldNames = new ArrayList<>(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        Iterator<String> itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = itr.next();
            String fieldValue = fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                hashData.append(fieldName).append("=").append(fieldValue);
                if (itr.hasNext()) hashData.append("&");
            }
        }

        String signValue = VnPayConfig.hmacSHA512(VnPayConfig.vnp_HashSecret, hashData.toString());

        String orderIdStr = request.getParameter("vnp_TxnRef");
        int orderId = Integer.parseInt(orderIdStr);
        OrderDAO orderDAO = new OrderDAO();

        if (signValue.equals(vnp_SecureHash)) {
            if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                orderDAO.updatePaymentStatus(orderId, 1);

                Order order = orderDAO.getOrderById(orderIdStr);
                List<OrderItem> orderItems = orderDAO.getAllOrdersItem(orderIdStr);
                Cart cart = CartService.getOrCreateCartByUserId(order.getUserId());
                for (OrderItem item : orderItems) {
                    CartService.deleteItem(cart.getId(), item.getProductVariant().getId());
                }

                response.sendRedirect(request.getContextPath() + "/checkout?vnpay=success&orderId=" + orderId);
            } else {
                //hủy or ck thất bại
                orderDAO.updateOrderStatus(orderId, 3); // 3: CANCELLED
                response.sendRedirect(request.getContextPath() + "/checkout?vnpay=cancel");
            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}