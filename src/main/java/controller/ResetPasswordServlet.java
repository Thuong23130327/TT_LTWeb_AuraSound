package controller;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.PasswordService;

import java.io.IOException;

@WebServlet(name = "ResetPasswordServlet", value = "/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private PasswordService pwdService = new PasswordService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");

        // Ktra token khi ngdung click link
        if (!pwdService.isTokenValid(token)) {
            // Nếu token sai/hết hạn đưa về login
            request.setAttribute("error", "Đường link đã hết hạn hoặc không hợp lệ!");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }

        // Hợp lệ, nhúng token vào input hidden của form
        request.setAttribute("token", token);
        request.getRequestDispatcher("/WEB-INF/views/reset_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String token = request.getParameter("token");
        String password = request.getParameter("password");

        boolean success = pwdService.resetPassword(token, password);

        JsonObject json = new JsonObject();
        json.addProperty("success", success);
        if (!success) json.addProperty("error", "Đổi mật khẩu thất bại, token có thể đã hết hạn.");
        response.getWriter().write(json.toString());
    }
}