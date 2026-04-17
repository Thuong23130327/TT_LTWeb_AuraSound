package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.dto.LoginResult;
import model.entity.User;
import model.enums.Role;
import service.UserService;
import model.IconLogin.GoogleLogin;
import model.entity.GoogleAccount;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserService();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");

        if (code != null && !code.isEmpty()) {
            try {
                GoogleLogin gg = new GoogleLogin();
                String access = gg.getToken(code);
                GoogleAccount acc = gg.getUserInfo(access);
                UserService userService = new UserService();
                User user = userService.getUserByEmail(acc.getEmail());
                //Kiểm tra tài khoản tồn tại chưa
                if (user == null) {
                    String randomPassword = java.util.UUID.randomUUID().toString().substring(0, 8);
                    String fullName = acc.getName() != null ? acc.getName() : acc.getEmail().split("@")[0];
                    int registerStatus = userService.register(acc.getEmail(), randomPassword, fullName);
                    if (registerStatus == 1) {
                        user = userService.getUserByEmail(acc.getEmail());
                    } else {
                        request.setAttribute("error", "Có lỗi xảy ra khi tạo tài khoản từ Google.");
                        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                        return;
                    }
                }
                //Mail đã được dùng
                // Kiểm tra trạng thái tài khoản
                if (user.isLocked()) {
                    request.setAttribute("error", "Tài khoản của bạn đã bị khóa");
                    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                    return;
                }
                HttpSession session = request.getSession();
                session.setAttribute("auth", user);
//                if (user.getERole() == Role.ADMIN) {
//                    session.setAttribute("author", user);
//                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
//                    return;
//                } else {
//                    response.sendRedirect("home");
//                    return;
//                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Đăng nhập Google thất bại! Vui lòng thử lại.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LoginResult result = userService.checkLogin(email, password);

        if (result.getUser() != null) {
            //TH1: login thành công
            User user = result.getUser();
            HttpSession session = request.getSession();

            session.setAttribute("auth", user);
            response.sendRedirect("home");

        } else {
            //TH2 : login thất bại
            request.setAttribute("loginEmail", email);
            request.setAttribute("error", result.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}
