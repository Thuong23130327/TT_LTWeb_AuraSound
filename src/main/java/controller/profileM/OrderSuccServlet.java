package controller.profileM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.CartItem;
import model.entity.Order;
import model.entity.OrderItem;
import model.entity.User;
import service.ProfileService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "OrdSuccServlet", value = "/order-detail-success")
public class OrderSuccServlet extends HttpServlet {

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

            System.out.println(userDetail.getId());

            String orderId = request.getParameter("id");
            try {
                if (orderId != null) {
                    List<OrderItem> activeItems = profileService.getAllOrdersItem(orderId);
                    request.setAttribute("orderItems", activeItems);

                    Order order = profileService.getOrderById(orderId);
                    request.setAttribute("order", order);
                }

                request.setAttribute("userDetail", profileService.getUserById(user.getId()));
                request.getRequestDispatcher("/order-detail.jsp").forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(500);
            }
            request.getRequestDispatcher("/WEB-INF/views/profileM//order-detail-success.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

