package service;

import dao.CartDAO;
import model.dto.VariantOptionDTO;
import model.entity.Cart;
import model.entity.CartItem;
import model.dto.CartItemDTO;
import org.jdbi.v3.core.Jdbi;


import java.util.List;

public class CartService {
    private static final CartDAO cartDAO = new CartDAO();
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public static Cart getOrCreateCartByUserId(int userId) {
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart == null) {
            cart = new Cart();
            int newCartId = cartDAO.createCart(userId);
            cart.setId(newCartId);
            cart.setUserId(userId);
        }
        return cart;
    }

    public static void addOrUpdateItem(int cartId, int variantId, int quantityChange) {
        CartItem existingItem = cartDAO.getCartItem(cartId, variantId);

        if (existingItem != null) {
            int newQuantity = existingItem.getQuantity() + quantityChange;
            if (newQuantity <= 0) {
                cartDAO.deleteCartItem(cartId, variantId);
            } else {
                cartDAO.updateCartItemQuantity(cartId, variantId, newQuantity);
            }
        } else {
            if (quantityChange > 0) {
                cartDAO.insertCartItem(cartId, variantId, quantityChange);
            }
        }
    }

    public static void deleteItem(int cartId, int variantId) {
        cartDAO.deleteCartItem(cartId, variantId);
    }

    public static void deleteAllItems(int cartId) {
        cartDAO.clearCart(cartId);
    }

    public static List<CartItemDTO> getListItems(int cartId) {
        List<CartItemDTO> items = cartDAO.getListItems(cartId);
        for (CartItemDTO item : items) {
            System.out.println(">>> productId = " + item.getProductId()
                    + " | colorName = " + item.getColorName());
            List<VariantOptionDTO> options =
                    cartDAO.getVariantOptionsByProductId(item.getProductId());
            System.out.println(">>> variants loaded = " + options.size());
            item.setVariantOptions(options);
        }
        return items;
    }

    public static int getTotalQuantity(int cartId) {
        return cartDAO.getTotalQuantity(cartId);
    }

    //Tổng tiền giỏ hàng
    public static double getTotalPrice(int cartId) {
        List<CartItemDTO> items = cartDAO.getListItems(cartId);
        double sum = 0;
        for (CartItemDTO item : items) {
            sum += item.getTotalItemPrice();
        }
        return sum;
    }

    //Tính tiền cho sp đc chọn (được tick)
    public static double getSelectedItemsTotalPrice(int cartId, List<Integer> selectedVariantIds) {
        if (selectedVariantIds == null || selectedVariantIds.isEmpty()) {
            return 0;
        }
        List<CartItemDTO> items = cartDAO.getListItems(cartId);
        double sum = 0;
        for (CartItemDTO item : items) {
            if (selectedVariantIds.contains(item.getProductVariantId())) {
                //Duyệt qua hàng đc tick vào rồi tính tiền
                sum += item.getTotalItemPrice();
            }
        }
        return sum;
    }


}
