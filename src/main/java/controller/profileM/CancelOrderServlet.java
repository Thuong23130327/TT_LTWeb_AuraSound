package controller.profileM;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Order;
import model.entity.User;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CancelOrderServlet", value = "/api/cancel-order")
public class CancelOrderServlet extends HttpServlet {

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

        if (order.getStatus() != 0) {
            response.setStatus(400);
            out.write("{\"status\":\"error\",\"message\":\"Chỉ có thể hủy đơn hàng đang chờ duyệt.\"}");
            return;
        }

        orderDAO.updateOrderStatus(orderId, 3);
        out.write("{\"status\":\"success\",\"message\":\"Đơn hàng đã được hủy thành công.\"}");
    }
}
