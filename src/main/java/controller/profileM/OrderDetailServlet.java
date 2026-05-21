package controller.profileM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Order;
import model.entity.OrderItem;
import model.entity.User;
import service.ProfileService;

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
            User userDetail = profileService.getUserById(user.getId());
            request.setAttribute("userDetail", userDetail);

            String orderId = request.getParameter("id");
            if (orderId != null) {

                List<OrderItem> cancelledItems = profileService.getAllOrdersItem(orderId);
                Order order = profileService.getOrderById(orderId);

                request.setAttribute("orderItems", cancelledItems);
                request.setAttribute("order", order);
            }

            request.getRequestDispatcher("/WEB-INF/views/profileM/order-detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return;
    }

}