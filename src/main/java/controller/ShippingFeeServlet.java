package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.GHNService;
import java.io.IOException;

@WebServlet("/api/calculate-shipping")
public class ShippingFeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try {
            int districtId = Integer.parseInt(request.getParameter("districtId"));
            String wardCode = request.getParameter("wardCode");

            int fee = GHNService.calculateShippingFee(districtId, wardCode, 500);

            response.getWriter().write("{\"status\":\"success\", \"fee\":" + fee + "}");
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\", \"fee\":30000}");
        }
    }
}