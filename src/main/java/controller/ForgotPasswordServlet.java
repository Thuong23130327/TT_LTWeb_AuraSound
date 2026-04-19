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
        response.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String resetUrl = request.getRequestURL().toString().replace("forgot-password", "reset-password");

        JsonObject json = new JsonObject();
        //  Kiểm tra mail tồn tại không
        if (!dao.AdminDAO.UserDAO.checkExistMail(email)) {
            json.addProperty("success", false);
            json.addProperty("error", "Email không tồn tại trong hệ thống.");
        } else {
            // Nếu mail tồn tại, chạy logic sinh token
            boolean success = pwdService.processForgotPassword(email, resetUrl);
            json.addProperty("success", success);

            if (success) {
                json.addProperty("message", "Vui lòng kiểm tra email để đặt lại mật khẩu!");
            } else {
                json.addProperty("error", "Hệ thống đang bận hoặc lỗi gửi mail. Vui lòng thử lại sau.");
            }
        }
        response.getWriter().write(json.toString());
    }
}