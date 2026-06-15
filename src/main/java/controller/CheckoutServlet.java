
package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.dto.CartItemDTO;
import model.entity.Cart;
import model.entity.User;
import model.entity.UserAddress;
import service.AddressService;
import service.CartService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {

    private AddressService addressService = new AddressService();

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

        List<UserAddress> addresses = new ArrayList<>();
        try {
            addresses = addressService.getUserAddresses(auth.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("addresses", addresses);
        request.setAttribute("addressCount", addresses.size());

        Cart cart = CartService.getOrCreateCartByUserId(auth.getId());
        int cartId = cart.getId();

        // Đọc id đc chọn
        String[] selectedIdsParam = request.getParameterValues("selectedIds");
        List<Integer> selectedIds = new ArrayList<>();

        if (selectedIdsParam != null) {
            for (String idStr : selectedIdsParam) {
                try {
                    selectedIds.add(Integer.parseInt(idStr.trim()));
                } catch (NumberFormatException ignored) {
                }
            }
        }

        // Lấy ds sp
        List<CartItemDTO> allItems = CartService.getListItems(cartId);

        String vnpayStatus = request.getParameter("vnpay");

        if (allItems == null || allItems.isEmpty()) {
            if (!"success".equals(vnpayStatus)) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
        }

        List<CartItemDTO> cartItems;
        if (!selectedIds.isEmpty()) {
            final List<Integer> finalIds = selectedIds;
            cartItems = allItems.stream()
                    .filter(item -> finalIds.contains(item.getProductVariantId()))
                    .collect(Collectors.toList());
        } else {
            cartItems = allItems;
        }

        if (cartItems.isEmpty()) {
            if (!"success".equals(vnpayStatus)) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }
        }

        request.getSession().setAttribute("checkoutSelectedIds", selectedIds);

        // Tính tiền
        double totalPrice = cartItems.stream()
                .mapToDouble(CartItemDTO::getTotalItemPrice)
                .sum();
        double shippingFee = 30_000;
        double finalTotal = totalPrice + shippingFee;

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("finalTotal", finalTotal);

        service.VoucherService voucherService = new service.VoucherService();
        List<model.entity.Voucher> walletVouchers = voucherService.getVouchersForUserWallet(auth.getId());
        request.setAttribute("walletVouchers", walletVouchers);

        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/checkout");
    }
}