package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.User;
import model.enums.Role;
import service.UserService;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserService();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        request.setAttribute("registerMessage", null);
        request.setAttribute("registerError", null);

        User user = null;
        user = userService.login(email, password);
        if (user != null) {
            //Check bị khóa ko
            if (user.isLocked()) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa");
                request.setAttribute("loginEmail", email);
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);

                return;
            }

            // đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("auth", user);

            //phân quyền điều hướng
            if (user.getERole() == Role.ADMIN) {
                session.setAttribute("author", user);
                //qua AMDashboardServlet
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect("home");
            }
        } else {
            if (!userService.checkExistMail(email)) {
                request.setAttribute("regEmail", email);
                request.setAttribute("error", "Email chưa có tài khoản, vui lòng chọn Đăng kí");
            } else {
                request.setAttribute("loginEmail", email);
                request.setAttribute("error", "Đăng nhập không thành công. Vui lòng kiểm tra tên đăng nhập và mật khẩu");
            }
        }
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
}
