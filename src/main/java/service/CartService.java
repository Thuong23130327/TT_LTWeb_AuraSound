package service;
import dao.CartDAO;
import model.entity.Cart;
import model.entity.CartItem;
import model.entity.CartItemDTO;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CartService {
    private final CartDAO cartDAO;

    public CartService(CartDAO cartDAO) {
        this.cartDAO = new CartDAO();
    }

    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public Cart getOrCreateCartByUserId(int userId) {
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart == null) {
            int newCartId = cartDAO.createCart(userId);
            cart = new Cart();
            cart.setId(newCartId);
            cart.setUserId(userId);
        }
        return cart;
    }

    public void addOrUpdateItem(int cartId, int variantId, int quantityChange) {
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

    public void deleteItem(int cartId, int variantId) {
        cartDAO.deleteCartItem(cartId, variantId);
    }

    public void deleteAllItems(int cartId) {
        cartDAO.clearCart(cartId);
    }

    public List<CartItemDTO> getListItems(int cartId) {
        return cartDAO.getListItems(cartId);
    }

    public int getTotalQuantity(int cartId) {
        return cartDAO.getTotalQuantity(cartId);
    }

    //Tổng tiền giỏ hàng
    public double getTotalPrice(int cartId) {
        List<CartItemDTO> items = cartDAO.getListItems(cartId);
        double sum = 0;
        for (CartItemDTO item : items) {
            sum += item.getTotalItemPrice();
        }
        return sum;
    }

    //Tính tiền cho sp đc chọn (được tick)
    public double getSelectedItemsTotalPrice(int cartId, List<Integer> selectedVariantIds) {
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
