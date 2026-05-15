package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.ProductDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.entity.*;
import model.entity.Cart;
import model.entity.OrderShipping;
import model.entity.User;
import model.entity.Voucher;
import service.CheckoutService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {
    private CheckoutService checkoutService = new CheckoutService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        List<CheckoutItemDTO> checkoutList = new ArrayList<>();
0
        if (cart != null && cart.getListItems() != null) {
            ProductDAO productDAO = new ProductDAO();

            for (CartItem item : cart.getListItems()) {
                // Lấy id sp gốc
                int productId = item.getProductVariant().getProductId();

                // Tìm tên sp
                Product p = productDAO.getById(String.valueOf(productId));
                String name = (p != null) ? p.getName() : "Sản phẩm không xác định";

                // Đóng gói cartItem+tên vào DTO
                checkoutList.add(new CheckoutItemDTO(item, name));
            }
        }

        // Gửi list mới sang jsp
        request.setAttribute("checkoutDisplayList", checkoutList);

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject jsonResp = new JsonObject();

        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            User user = (User) session.getAttribute("user");

            if (cart == null || cart.getTotalQuantity() == 0) {
                jsonResp.addProperty("status", "error");
                jsonResp.addProperty("message", "Giỏ hàng trống!");
                out.print(gson.toJson(jsonResp));
                return;
            }

            String action = request.getParameter("action");

            // Kiểm tra voucher
            if ("checkVoucher".equals(action)) {
                String code = request.getParameter("code");
                Voucher v = checkoutService.checkVoucherValid(code, cart.getTotalPrice());

                if (v != null) {
                    jsonResp.addProperty("status", "success");
                    jsonResp.addProperty("discount", v.getDiscountValue());
                    double finalPrice = (cart.getTotalPrice() + 30000) - v.getDiscountValue();
                    jsonResp.addProperty("finalPrice", finalPrice);
                } else {
                    jsonResp.addProperty("status", "invalid");
                    jsonResp.addProperty("message", "Mã không hợp lệ hoặc chưa đủ điều kiện.");
                }
            }

            // Đặt hàng
            else if ("placeOrder".equals(action)) {
                // Lấy dữ liệu từ Form
                String fullname = request.getParameter("fullname");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String city = request.getParameter("city");
                String note = request.getParameter("note");
                String voucherCode = request.getParameter("voucherCode");

                // Tạo đối tượng Shipping
                OrderShipping shipping = new OrderShipping();
                shipping.setRecipientName(fullname);
                shipping.setPhone(phone);
                shipping.setAddress(address);
                shipping.setCity(city);
                shipping.setNote(note);

                // Gọi Service
                boolean success = checkoutService.placeOrder(shipping, cart, voucherCode, user);

                if (success) {
                    session.removeAttribute("cart"); // Xóa giỏ hàng sau khi mua thành công
                    jsonResp.addProperty("status", "success");
                } else {
                    jsonResp.addProperty("status", "error");
                    jsonResp.addProperty("message", "Lỗi hệ thống, vui lòng thử lại.");
                }
            }
            out.print(gson.toJson(jsonResp));

        } catch (Exception e) {
            e.printStackTrace();
            jsonResp.addProperty("status", "error");
            jsonResp.addProperty("message", "Lỗi Server: " + e.getMessage());
            out.print(gson.toJson(jsonResp));
        }
    }
}
