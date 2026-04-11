package controller.profileM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Order;
import model.entity.User;
import service.ProfileService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "CancelledServlet", value = "/order-cancelled")
public class CancelledServlet  extends HttpServlet {

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

            List<Order> cancelledOrders = profileService.getCancelledOrders(user.getId());
            System.out.println("DEBUG: đơn bị hủy: " + (cancelledOrders != null ? cancelledOrders.size() : "NULL"));
            request.setAttribute("cancelledOrders", cancelledOrders);

            request.getRequestDispatcher("/WEB-INF/views/profileM/order-cancelled.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}