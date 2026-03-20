package controller.profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.UserService;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        request.setAttribute("fullname", fullname);
        request.setAttribute("regEmail", email);

        //kiểm tra trùng password và repass
        if (password == null || !password.equals(repassword)) {
            request.setAttribute("registerError", "Mật khẩu không trùng khớp!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        int result = userService.register(email, password, fullname);

        if (result == 1) {
            request.setAttribute("registerMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
        } else if (result == 0) {
            request.setAttribute("registerError", "Email đã được sử dụng, vui lòng chọn email khác.");
        } else {
            request.setAttribute("registerError", "Có lỗi xảy ra, vui lòng thử lại.");
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
