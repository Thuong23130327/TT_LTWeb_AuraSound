package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.GHNService;
import java.io.IOException;

@WebServlet("/api/calculate-shipping")
public class ShippingFeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        try {
            int districtId = Integer.parseInt(request.getParameter("districtId"));
            String wardCode = request.getParameter("wardCode");

            // tính phí ship (giả định cân nặng gói hàng cố định là 500g)
            int fee = GHNService.calculateShippingFee(districtId, wardCode, 500);

            // dự đoán thời gian nhận hàng
            long leadtime = GHNService.getExpectedDeliveryDate(districtId, wardCode);

            String jsonOutput = String.format(
                    "{\"status\":\"success\", \"fee\":%d, \"leadtime\":%d}",
                    fee, leadtime
            );

            response.getWriter().write(jsonOutput);

        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\", \"fee\":30000, \"leadtime\":0}");
        }
    }
}