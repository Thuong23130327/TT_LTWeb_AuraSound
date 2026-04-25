package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.UserService;
import util.EmailUtility;
import util.RedisUtility;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "SendMagicLinkServlet", value = "/send-magic-link")
public class SendMagicLinkServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        System.setProperty("java.net.preferIPv4Stack", "true");

        try {
            String email = request.getParameter("email");
            if (email == null || email.isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Email không được trống!\"}");
                return;
            }

            UserService userService = new UserService();
            if (userService.checkExistMail(email)) {
                response.getWriter().write("{\"success\": false, \"message\": \"Email này đã được đăng ký. Vui lòng đăng nhập hoặc dùng email khác!\"}");
                return;
            }

            String token = UUID.randomUUID().toString();
            RedisUtility.saveToken(token, email, 900);

            String verifyLink = "http://localhost:8080/AuraSound/verify-email?token=" + token;
            EmailUtility.sendMagicLink(email, verifyLink);

            response.getWriter().write("{\"success\": true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Lỗi Server: " + e.getMessage() + "\"}");
        }
    }
}