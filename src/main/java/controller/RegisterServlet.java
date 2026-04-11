package controller;

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
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        boolean hasError = false;
        // Check thông tin bỏ trống
        if (fullname == null || fullname.trim().isEmpty()) {
            request.setAttribute("errorFullname", "Họ và tên không được bỏ trống!");
            hasError = true;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorEmail", "Email không được bỏ trống!");
            hasError = true;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorPassword", "Mật khẩu không được bỏ trống!");
            hasError = true;
        //Check validpass
        } else if (!password.matches(passwordPattern)) {
            request.setAttribute("errorPassword", "Mật khẩu không đủ mạnh (Cần ít nhất 8 kí tự, 1 hoa, 1 số, 1 kí tự đặc biệt)!");
            hasError = true;
        }
        // Check repass
        if (repassword == null || repassword.trim().isEmpty()) {
            request.setAttribute("errorRepassword", "Vui lòng nhập lại mật khẩu!");
            hasError = true;
        } else if (password != null && !password.equals(repassword)) {
            request.setAttribute("errorRepassword", "Mật khẩu nhập lại không trùng khớp!");
            hasError = true;
        }
        if (hasError) {
            forwardWithData(request, response, fullname, email);
            return; // Quan trọng: Dừng code tại đây, không cho chạy xuống UserService
        }
        //Đăng kí
        int result = userService.register(email, password, fullname);

        if (result == 1) {
            request.setAttribute("registerMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } else if (result == 0) {
            request.setAttribute("errorEmail", "Email đã được sử dụng, vui lòng chọn email khác.");
            forwardWithData(request, response, fullname, email);
        } else {
            request.setAttribute("registerError", "Có lỗi hệ thống xảy ra, vui lòng thử lại sau.");
            forwardWithData(request, response, fullname, email);
        }

    }
    private void forwardWithData(HttpServletRequest request, HttpServletResponse response, String fullname, String email) throws ServletException, IOException {
        request.setAttribute("fullname", fullname);
        request.setAttribute("regEmail", email);
        request.setAttribute("hasRegisterError", true); // Cờ báo hiệu có lỗi
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
}
