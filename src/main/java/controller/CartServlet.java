package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.dto.CartItemDTO;
import model.entity.Cart;
import service.CartService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        //Chưa có chức năng đăng nhập, tạm thời để
        int userId = 1;
        Cart cart = CartService.getOrCreateCartByUserId(userId);
        int cartId = cart.getId();

        String action = request.getParameter("action");
        String idStr = request.getParameter("id"); //variantId
        String qStr = request.getParameter("q");

        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With")) || "ajax".equals(request.getParameter("type")) || "ajax".equals(request.getParameter("newVariantId"));
        try {
            if (action != null && idStr != null && !qStr.isEmpty()) {
                int variantId = Integer.parseInt(idStr);

                if ("delete".equals(action)) {
                    CartService.deleteItem(cartId, variantId);
                }

                if ("add".equals(action) || "updateQuantity".equals(action)) {
                    int quantityChange = (qStr != null) ? Integer.parseInt(qStr) : 1;
                    CartService.addOrUpdateItem(cartId, variantId, quantityChange);
                }
                //Ajax dùng tăng/giảm số lượng, tính tiền
                else if (isAjax) {
                    response.setContentType("application/json");
                    PrintWriter out = response.getWriter();

                    double totalPrice = CartService.getTotalPrice(cartId);
                    int totalQty = CartService.getTotalQuantity(cartId);

                    out.print("{\"status\": \"success\", \"cartTotal\": " + totalPrice + ", \"cartQty\": " + totalQty + "}");
                    out.flush();
                    return;
                } else if ("updateVariant".equals(action)) {
                    String newVariantIdStr = request.getParameter("newVariantId");
                    if (newVariantIdStr != null && !newVariantIdStr.isEmpty()) {
                        int newVariantId = Integer.parseInt(newVariantIdStr);

                        //Đổi biến thể: lấy sl cũ -> xóa sl cũ -> thêm sl mới tương đương
                        List<CartItemDTO> items = CartService.getListItems(cartId);
                        int oldQty = 0;
                        for (CartItemDTO item : items) {
                            if (item.getProductVariantId() == variantId) {
                                oldQty = item.getQuantity();
                                break;
                            }
                        }
                        if (oldQty > 0) {
                            CartService.deleteItem(cartId, variantId);
                            CartService.addOrUpdateItem(cartId, variantId, oldQty);

                            //Ajax dùng cho đổi biến thể
                            if (isAjax) {
                                List<CartItemDTO> updatedItems = CartService.getListItems(cartId);
                                CartItemDTO newItem = null;
                                for (CartItemDTO item : updatedItems) {
                                    if (item.getProductVariantId() == variantId) {
                                        newItem = item;
                                        break;
                                    }
                                }
                                response.setContentType("application/json");
                                PrintWriter out = response.getWriter();

                                if (newItem != null) {
                                    double totalOrder = CartService.getTotalPrice(cartId);

                                    StringBuilder json = new StringBuilder();
                                    json.append("{");
                                    json.append("\"status\": \"success\",");
                                    json.append("\"newId\": ").append(newItem.getProductVariantId()).append(",");
                                    json.append("\"img\": \"").append(newItem.getImg()).append("\",");
                                    json.append("\"price\": ").append(newItem.getPrice()).append(",");
                                    json.append("\"name\": \"").append(newItem.getName()).append("\",");
                                    json.append("\"totalOrder\": ").append(totalOrder);
                                    json.append("}");

                                    out.print(json.toString());
                                } else {
                                    out.print("{\"status\": \"error\", \"message\": \"Không tìm thấy biến thể\"}");
                                }
                                out.flush();
                                return;
                            }
                        }
                    }
                }
            }
            //Luồng
            List<CartItemDTO> cartItems = CartService.getListItems(cartId);
            double totalPrice = CartService.getTotalPrice(cartId);
            int totalQuantity = CartService.getTotalQuantity(cartId);

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("totalQuantity", totalQuantity);

            request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjax) {
                response.setStatus(500);
                response.getWriter().write("{\"status\": \"error\", \"message\": \"Lỗi xử lý giỏ hàng\"}");
            } else {
                response.sendRedirect("/cart.jsp?error=true");
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //Lấy tạm userId = 1
            int userId = 1;

            Cart cart = CartService.getOrCreateCartByUserId(userId);
            int cartId = cart.getId();
            //Lấy dl từ form trang sproduct đẩy lên
            String variantIdStr = request.getParameter("variantId");
            String quantityStr = request.getParameter("quantity");

            if (variantIdStr == null || variantIdStr.isEmpty()){
                throw new Exception("Thiếu VariantId");
            }

            int variantId = Integer.parseInt(variantIdStr);
            int qty = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

            //cập nhật qty
            CartService.addOrUpdateItem(cartId, variantId, qty);

            //redirect về doget để load ds hiển thị
            response.sendRedirect(request.getContextPath() + "/cart");
        }catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/cart?error=add_failed");
        }
    }
}