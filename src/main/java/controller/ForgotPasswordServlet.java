package controller;

import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.PasswordService;

import java.io.IOException;

@WebServlet(name = "ForgotPasswordServlet", value = "/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private PasswordService pwdService = new PasswordService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        String email = request.getParameter("email");
        String resetUrl = request.getRequestURL().toString().replace("forgot-password", "reset-password");

        boolean success = pwdService.processForgotPassword(email, resetUrl);

        JsonObject json = new JsonObject();
        json.addProperty("success", success);
        json.addProperty(success ? "message" : "error", success ? "Vui lòng kiểm tra email!" : "Lỗi hệ thống hoặc email không tồn tại.");
        response.getWriter().write(json.toString());
    }
}