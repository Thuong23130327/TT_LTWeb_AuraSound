package controller;

import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.IconLogin.VnPayConfig;
import model.entity.Order;
import model.entity.User;
import model.entity.Cart;
import service.OrderService;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "OrderServlet", value = "/order")
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setStatus(405);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("auth") : null;

        if (auth == null) {
            response.setStatus(401);
            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"Vui lòng đăng nhập để đặt hàng\"}"
            );
            return;
        }

        List<Integer> selectedIds = (List<Integer>) session.getAttribute("checkoutSelectedIds");

        String fullName      = request.getParameter("fullName");
        String phone         = request.getParameter("phone");
        String city          = request.getParameter("city");
        String ward          = request.getParameter("ward");
        String address       = request.getParameter("address");
        String notes         = request.getParameter("notes");
        String voucherCode   = request.getParameter("voucherCode");
        String paymentMethod = request.getParameter("paymentMethod");

        String provinceIdStr = request.getParameter("provinceId");
        String districtIdStr = request.getParameter("districtId");
        String wardCodeStr   = request.getParameter("wardCode");
        String addressIdStr  = request.getParameter("addressId");
        String shippingFeeStr = request.getParameter("shippingFee");

        int provinceId = 0;
        if (provinceIdStr != null && !provinceIdStr.trim().isEmpty()) {
            try {
                provinceId = Integer.parseInt(provinceIdStr.trim());
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        int districtId = 0;
        if (districtIdStr != null && !districtIdStr.trim().isEmpty()) {
            try {
                districtId = Integer.parseInt(districtIdStr.trim());
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        int addressId = 0;
        if (addressIdStr != null && !addressIdStr.trim().isEmpty()) {
            try {
                addressId = Integer.parseInt(addressIdStr.trim());
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        // Nhận phí ship tự động
        double shippingFee = 30000;
        if (shippingFeeStr != null && !shippingFeeStr.trim().isEmpty()) {
            try {
                shippingFee = Double.parseDouble(shippingFeeStr.trim());
            } catch (NumberFormatException e) {
                // ignore
            }
        }

        if (isBlank(fullName) || isBlank(phone) || isBlank(city) || isBlank(ward) || isBlank(address)) {
            response.setStatus(400);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Vui lòng điền đầy đủ thông tin bắt buộc\"}");
            return;
        }

        if (!phone.trim().matches("^[0-9]{10}$")) {
            response.setStatus(400);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Số điện thoại phải gồm đúng 10 chữ số\"}");
            return;
        }

        try {
            int orderId = OrderService.placeOrder(
                    auth.getId(),
                    addressId,
                    fullName.trim(),
                    phone.trim(),
                    city.trim(),
                    ward.trim(),
                    address.trim(),
                    provinceId,
                    districtId,
                    wardCodeStr != null ? wardCodeStr.trim() : "",
                    notes != null ? notes.trim() : "",
                    voucherCode,
                    selectedIds,
                    shippingFee
            );

            if (orderId > 0) {
                session.removeAttribute("checkoutSelectedIds");

                // XỬ LÝ THANH TOÁN VNPAY
                if ("vnpay".equals(paymentMethod)) {
                    OrderDAO orderDAO = new OrderDAO();
                    Order order = orderDAO.getOrderById(String.valueOf(orderId));

                    long amount = order.getFinalAmount().longValue() * 100;

                    Map<String, String> vnp_Params = new TreeMap<>();
                    vnp_Params.put("vnp_Version", "2.1.0");
                    vnp_Params.put("vnp_Command", "pay");
                    vnp_Params.put("vnp_TmnCode", VnPayConfig.vnp_TmnCode);
                    vnp_Params.put("vnp_Amount", String.valueOf(amount));
                    vnp_Params.put("vnp_CurrCode", "VND");
                    vnp_Params.put("vnp_TxnRef", orderId + "_" + System.currentTimeMillis());
                    vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang " + orderId);
                    vnp_Params.put("vnp_OrderType", "other");
                    vnp_Params.put("vnp_Locale", "vn");
                    
                    String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
                    vnp_Params.put("vnp_ReturnUrl", baseUrl + "/vnpay_return");
                    
                    vnp_Params.put("vnp_IpAddr", request.getRemoteAddr());

                    Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                    String vnp_CreateDate = formatter.format(cld.getTime());
                    vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                    cld.add(Calendar.MINUTE, 15);
                    String vnp_ExpireDate = formatter.format(cld.getTime());
                    vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);


                    StringBuilder hashData = new StringBuilder();
                    StringBuilder query = new StringBuilder();
                    boolean firstEntry = true;

                    for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
                        String fieldName  = entry.getKey();
                        String fieldValue = entry.getValue();
                        if (fieldValue != null && !fieldValue.isEmpty()) {
                            if (!firstEntry) {
                                hashData.append('&');
                                query.append('&');
                            }
                            hashData.append(fieldName)
                                    .append('=')
                                    .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                            query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()))
                                    .append('=')
                                    .append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));

                            firstEntry = false;
                        }
                    }

                    String vnp_SecureHash = VnPayConfig.hmacSHA512(VnPayConfig.vnp_HashSecret, hashData.toString());
                    String paymentUrl = VnPayConfig.vnp_PayUrl + "?" + query + "&vnp_SecureHash=" + vnp_SecureHash;

                    response.setStatus(200);
                    response.getWriter().write("{\"status\":\"redirect\",\"url\":\"" + paymentUrl + "\"}");
                    return;
                }

                // XỬ LÝ ĐẶT HÀNG COD THƯỜNG
                Cart cart = service.CartService.getOrCreateCartByUserId(auth.getId());
                if (selectedIds != null) {
                    for (Integer variantId : selectedIds) {
                        service.CartService.deleteItem(cart.getId(), variantId);
                    }
                }

                int currentQty = service.CartService.getListItems(cart.getId()).size();
                session.setAttribute("cartQty", currentQty);

                response.setStatus(200);
                response.getWriter().write("{\"status\":\"success\",\"orderId\":" + orderId + "}");
            } else {
                response.setStatus(500);
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Đặt hàng thất bại, vui lòng thử lại\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Lỗi hệ thống trong quá trình tạo đơn\"}");
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}