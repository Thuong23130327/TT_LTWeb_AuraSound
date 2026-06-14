package controller.admin;

import dao.AdminDAO.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.entity.User;
import service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserAdminController", value = "/admin/user-manager")
public class AmUserServlet extends HttpServlet {
    private UserService userService = new UserService();
    private UserDAO userDAO = new UserDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("author");
        if (currentUser == null || !currentUser.hasPermission("USER_VIEW")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập");
            return;
        }

        String action = request.getParameter("action");

        if ("checkCount".equals(action)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try {
                int totalCount = userService.getAllUsers().size();
                response.getWriter().write("{\"totalCount\":" + totalCount + "}");
            } catch (Exception e) {
                response.getWriter().write("{\"totalCount\": 0, \"error\":\"" + e.getMessage() + "\"}");
            }
            return;
        }

        try {
            List<User> userList = userService.getAllUsers();
            request.setAttribute("userList", userList);
            request.setAttribute("pageTitle", "Quản lý Tài Khoản - AuraSound Admin");
            request.setAttribute("activePage", "acc"); // Giữ cho menu sáng lên
        } catch (Exception e) {
            request.setAttribute("errorMsg", "Không thể tải danh sách người dùng: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        User currentUser = (User) request.getSession().getAttribute("author");
        if (currentUser == null || !currentUser.hasPermission("USER_VIEW")) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Bạn không đủ thẩm quyền thực hiện thao tác này.\"}");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("toggleLock".equals(action)) {
                String email = request.getParameter("email");
                boolean isLocked = Boolean.parseBoolean(request.getParameter("isLocked"));

                if (isLocked) {
                    userDAO.unlockAccount(email);
                } else {
                    userDAO.lockAccount(email);
                }
                response.getWriter().write("{\"status\":\"success\"}");

            } else if ("changeRole".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                int roleId = Integer.parseInt(request.getParameter("roleId"));

                boolean success = userDAO.updateUserRole(userId, roleId);
                if (success) {
                    response.getWriter().write("{\"status\":\"success\"}");
                } else {
                    response.getWriter().write("{\"status\":\"error\"}");
                }
            }
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        }
    }
}