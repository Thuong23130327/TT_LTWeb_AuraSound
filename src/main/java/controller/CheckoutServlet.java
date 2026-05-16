package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.dto.CartItemDTO;
import model.entity.Cart;
import model.entity.User;
import service.CartService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("auth") : null;

        // Ktra đăng nhập
        if (auth == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Cart cart = CartService.getOrCreateCartByUserId(auth.getId());
        int cartId = cart.getId();

        // Lấy ds sp
        List<CartItemDTO> cartItems = CartService.getListItems(cartId);

        // Giỏ trống về cart
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Tính tiền
        double totalPrice  = CartService.getTotalPrice(cartId);
        double shippingFee = 30_000;
        double finalTotal  = totalPrice + shippingFee;

        request.setAttribute("cartItems",   cartItems);
        request.setAttribute("totalPrice",  totalPrice);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("finalTotal",  finalTotal);

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/checkout");
    }
}