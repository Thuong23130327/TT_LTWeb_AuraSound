package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.entity.User;
import service.OrderService;

import java.io.IOException;
import java.util.List;

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

        // Ktra đăng nhập
        HttpSession session = request.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("auth") : null;

        if (auth == null) {
            response.setStatus(401);
            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"Vui lòng đăng nhập để đặt hàng\"}"
            );
            return;
        }

        @SuppressWarnings("unchecked")
        List<Integer> selectedIds =
                (List<Integer>) session.getAttribute("checkoutSelectedIds");

        String fullName    = request.getParameter("fullName");
        String phone       = request.getParameter("phone");
        String city        = request.getParameter("city");
        String ward        = request.getParameter("ward");
        String address     = request.getParameter("address");
        String notes       = request.getParameter("notes");
        String voucherCode = request.getParameter("voucherCode");

        String provinceIdStr = request.getParameter("provinceId");
        String districtIdStr = request.getParameter("districtId");
        String wardCodeStr   = request.getParameter("wardCode");

        int provinceId = 0, districtId = 0;
        try {
            if (provinceIdStr != null && !provinceIdStr.isEmpty()) provinceId = Integer.parseInt(provinceIdStr);
            if (districtIdStr != null && !districtIdStr.isEmpty()) districtId = Integer.parseInt(districtIdStr);
        } catch (Exception e) {}

        if (isBlank(fullName) || isBlank(phone) ||
                isBlank(city)     || isBlank(ward)  || isBlank(address)) {

            response.setStatus(400);
            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"Vui lòng điền đầy đủ thông tin bắt buộc\"}"
            );
            return;
        }

        if (!phone.trim().matches("^[0-9]{10}$")) {
            response.setStatus(400);
            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"Số điện thoại phải gồm đúng 10 chữ số\"}"
            );
            return;
        }

        try {
            int orderId = OrderService.placeOrder(
                    auth.getId(),
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
                    selectedIds
            );

            if (orderId > 0) {
                session.removeAttribute("checkoutSelectedIds");

                response.setStatus(200);
                response.getWriter().write(
                        "{\"status\":\"success\",\"orderId\":" + orderId + "}"
                );
            } else {
                response.setStatus(500);
                response.getWriter().write(
                        "{\"status\":\"error\",\"message\":\"Đặt hàng thất bại, vui lòng thử lại\"}"
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"Lỗi hệ thống\"}"
            );
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}