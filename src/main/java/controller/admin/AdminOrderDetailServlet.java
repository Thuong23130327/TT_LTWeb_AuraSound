package controller.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.entity.Order;
import model.entity.OrderItem;
import service.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderDetailServlet", value = "/admin/order-detail")
public class AdminOrderDetailServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("id");

        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-order");
            return;
        }

        Order order = orderService.getAdminOrderDetailById(orderId);

        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-order");
            return;
        }

        List<OrderItem> orderItems = orderService.getAdminOrderItemsByOrderId(orderId);

        request.setAttribute("pageTitle", "Chi tiết đơn hàng " + order.getOrderCode());
        request.setAttribute("order", order);
        request.setAttribute("orderItems", orderItems);

        request.getRequestDispatcher("/WEB-INF/views/admin/orderDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}