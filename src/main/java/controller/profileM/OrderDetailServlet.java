package controller.profileM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Order;
import model.entity.OrderItem;
import model.entity.OrderShipping;
import model.entity.User;
import service.ProfileService;
import service.GHNService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "OrderDetailServlet", value = "/order-detail")
public class OrderDetailServlet extends HttpServlet {

    private ProfileService profileService = new ProfileService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("auth") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
//            User userDetail = profileService.getUserById(user.getId());
//            request.setAttribute("userDetail", userDetail);
//
//            String orderId = request.getParameter("id");
//            if (orderId != null) {
//
//                List<OrderItem> cancelledItems = profileService.getAllOrdersItem(orderId);
//                Order order = profileService.getOrderById(orderId);
//
//                request.setAttribute("orderItems", cancelledItems);
//                request.setAttribute("order", order);
//            }
//
//            request.getRequestDispatcher("/WEB-INF/views/profileM/order-detail.jsp").forward(request, response);
            String orderIdParam = request.getParameter("id");
            if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/order-history");
                return;
            }

            int orderId;
            try {
                orderId = Integer.parseInt(orderIdParam.trim());
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/order-history");
                return;
            }

            Order order = profileService.getOrderById(orderIdParam);
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/order-history");
                return;
            }

            List<OrderItem> orderItems = profileService.getAllOrdersItem(orderIdParam);

            OrderShipping orderShipping = profileService.getOrderShipping(orderId);

            User userDetail = profileService.getUserById(user.getId());

            String shippingLogJson = null;
            if (order.getShippingOrderCode() != null && !order.getShippingOrderCode().isEmpty()) {
                try {
                    shippingLogJson = GHNService.getOrderLogProgress(order.getShippingOrderCode());
                } catch (Exception e) {
                    System.out.println("Error fetching GHN logs: " + e.getMessage());
                }
            }

            request.setAttribute("userDetail", userDetail);
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItems);
            request.setAttribute("orderShipping", orderShipping);
            request.setAttribute("shippingLogJson", shippingLogJson);

            request.getRequestDispatcher("/WEB-INF/views/profileM/order-detail.jsp")
                    .forward(request, response);


        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return;
    }
}