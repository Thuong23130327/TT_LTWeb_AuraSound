package controller;

import dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.User;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "WishlistServlet", value = "/wishlist-ajax")
public class WishlistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
//        checklogin
        User currentUser = (User) session.getAttribute("auth");
        if (currentUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"status\":\"error\", \"message\":\" đăng nhập để sử dụng tính năng này!\"}");
            out.flush();
            return;
        }
        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\":\"error\", \"message\":\"Thiếu productId!\"}");
            out.flush();
            return;
        }
        try {
            int productId = Integer.parseInt(productIdStr);
            int userId = currentUser.getId();
            WishlistDAO dao = new WishlistDAO();
            boolean isCurrentlyWished = dao.checkWishlist(userId, productId);
            boolean finalWishedStatus = false;
            if (isCurrentlyWished) {
                dao.removeWishlist(userId, productId);
                finalWishedStatus = false;
            } else {
                dao.addWishlist(userId, productId);
                finalWishedStatus = true;
            }
            out.print("{\"status\":\"success\", \"isWished\":" + finalWishedStatus + "}");

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"status\":\"error\", \"message\":\"productId không hợp lệ!\"}");
        } finally {
            out.flush();
        }
    }
}