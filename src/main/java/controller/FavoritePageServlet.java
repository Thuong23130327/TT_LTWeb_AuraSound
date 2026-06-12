package controller;

import dao.WishlistDAO;
import model.entity.Product;
import model.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.ProfileService;

import java.io.IOException;
import java.util.List;

@WebServlet("/favorite")
public class FavoritePageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("auth");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        ProfileService profileService = new service.ProfileService();
        List<Product> wishlistProducts = profileService.getWishlistByUser(currentUser.getId());
        request.setAttribute("wishlistProducts", wishlistProducts);

        try {
            User userDetail = profileService.getUserById(currentUser.getId());
            request.setAttribute("userDetail", userDetail);
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
     request.getRequestDispatcher("/WEB-INF/views/profileM/favorites.jsp").forward(request, response);








    }
}
