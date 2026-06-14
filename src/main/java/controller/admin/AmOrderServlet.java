package controller.admin;

import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.entity.Order;
import model.entity.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "AmOrderServlet", value = "/admin/manage-order")
public class AmOrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User currentUser = (User) request.getSession().getAttribute("author");
        if (currentUser == null || !currentUser.isAdminOrStaff()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("checkCount".equals(action)) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            try {
                int totalCount = orderDAO.getTotalOrderCount();
                out.print("{\"totalCount\": " + totalCount + "}");
            } catch (Exception e) {
                out.print("{\"totalCount\": -1}");
            }
            out.flush();
            return;
        }

        List<Order> orderList = orderDAO.getAll();
        request.setAttribute("orderList", orderList);
        request.setAttribute("activePage", "order");
        request.setAttribute("pageTitle", "Quản lý Đơn hàng | AuraSound Admin");
        request.getRequestDispatcher("/WEB-INF/views/admin/manageOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if ("updateStatus".equals(action)) {
            try {
                int orderId = Integer.parseInt(request.getParameter("orderId"));
                int newStatus = Integer.parseInt(request.getParameter("status"));

                orderDAO.updateOrderStatus(orderId, newStatus);

                out.print("{\"status\":\"success\", \"message\":\"Cập nhật thành công!\"}");
            } catch (Exception e) {
                e.printStackTrace();
                out.print("{\"status\":\"error\", \"message\":\"Lỗi khi cập nhật trạng thái.\"}");
            }
            out.flush();
        }
    }
}