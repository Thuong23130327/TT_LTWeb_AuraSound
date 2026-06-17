package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.GHNService;

import java.io.IOException;

@WebServlet("/api/calculate-shipping")
public class ShippingFeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        String districtIdStr = request.getParameter("districtId");
        String wardCode      = request.getParameter("wardCode");

        if (districtIdStr == null || districtIdStr.isBlank()
                || wardCode == null || wardCode.isBlank()) {
            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"Thiếu districtId hoặc wardCode\",\"fee\":-1,\"leadtime\":-1}"
            );
            return;
        }

        int districtId;
        try {
            districtId = Integer.parseInt(districtIdStr.trim());
        } catch (NumberFormatException e) {
            response.getWriter().write(
                    "{\"status\":\"error\",\"message\":\"districtId không hợp lệ\",\"fee\":-1,\"leadtime\":-1}"
            );
            return;
        }

        // --- Tính phí ship ---
        int fee = -1;
        String feeError = null;
        try {
            fee = GHNService.calculateShippingFee(districtId, wardCode, 500);
        } catch (Exception e) {
            feeError = e.getMessage();
            System.err.println("[ShippingFeeServlet] Lỗi calculateShippingFee: " + e.getMessage());
        }

        // --- Lấy thời gian dự kiến ---
        long leadtime = -1;
        String leadtimeError = null;
        try {
            leadtime = GHNService.getExpectedDeliveryDate(districtId, wardCode);
        } catch (Exception e) {
            leadtimeError = e.getMessage();
            System.err.println("[ShippingFeeServlet] Lỗi getExpectedDeliveryDate: " + e.getMessage());
        }

        // --- Trả kết quả ---
        // fee=-1 hoặc leadtime=-1 nghĩa là GHN trả lỗi, FE sẽ hiển thị thông báo phù hợp
        String json = String.format(
                "{\"status\":\"success\",\"fee\":%d,\"leadtime\":%d,\"feeError\":%s,\"leadtimeError\":%s}",
                fee,
                leadtime,
                feeError      != null ? "\"" + feeError.replace("\"", "'")      + "\"" : "null",
                leadtimeError != null ? "\"" + leadtimeError.replace("\"", "'") + "\"" : "null"
        );

        response.getWriter().write(json);
    }
}
