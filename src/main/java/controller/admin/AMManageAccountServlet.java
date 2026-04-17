package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.User;
import service.UserService;


import java.io.IOException;
import java.util.List;

@WebServlet(name = "AMManageAccountServlet", value = "/admin/user-manager")
public class AMManageAccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("author");

        if (currentUser == null || !currentUser.isAdminOrStaff() || !currentUser.hasPermission("USER_VIEW")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
            return;
        }
        UserService userService = new UserService();
        List<User> userList = userService.getAllUsers();
        request.setAttribute("userList", userList);
        request.setAttribute("pageTitle", "Quản lý Tài Khoản- AuraSound");
        request.setAttribute("activePage", "acc");
        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);

    }
}
