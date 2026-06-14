package controller.profileM;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Order;
import model.entity.OrderItem;
import model.entity.User;
import model.entity.Cart;
import service.CartService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "BuyAgainServlet", value = "/api/buy-again")
public class BuyAgainServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("auth") : null;

        if (user == null) {
            response.setStatus(401);
            out.write("{\"status\":\"error\",\"message\":\"Vui lòng đăng nhập.\"}");
            return;
        }

        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.setStatus(400);
            out.write("{\"status\":\"error\",\"message\":\"Thiếu mã đơn hàng.\"}");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr.trim());
        } catch (NumberFormatException e) {
            response.setStatus(400);
            out.write("{\"status\":\"error\",\"message\":\"Mã đơn hàng không hợp lệ.\"}");
            return;
        }

        Order order = orderDAO.getOrderById(String.valueOf(orderId));
        if (order == null) {
            response.setStatus(404);
            out.write("{\"status\":\"error\",\"message\":\"Không tìm thấy đơn hàng.\"}");
            return;
        }

        List<OrderItem> items = orderDAO.getAllOrdersItem(String.valueOf(orderId));


        Cart cart = CartService.getOrCreateCartByUserId(user.getId());
        int cartId = cart.getId();

        for (OrderItem item : items) {
            if (item.getProductVariant() != null) {
                int variantId = item.getProductVariant().getId();
                int qty = item.getQuantity();
                CartService.addOrUpdateItem(cartId, variantId, qty);
            }
        }

        int totalQty = CartService.getTotalQuantity(cartId);
        session.setAttribute("cartQty", totalQty);

        out.write("{\"status\":\"success\",\"message\":\"Đã thêm sản phẩm vào giỏ hàng.\"}");
    }
}
