package dao;

import model.entity.Cart;
import model.entity.CartItem;
import model.entity.CartItemDTO;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CartDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    //Lấy cart theo mã người dùng
    public Cart getCartByUserId(int userId){
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM carts WHERE users_id = :userId")
                        .bind("userId", userId)
                        .mapToBean(Cart.class)
                        .findFirst()
                        .orElse(null)
        );
    }
    //Tạo cart mới
    public int createCart(int userId){
        return jdbi.withHandle(handle -> {
                handle.createUpdate("INSERT INTO carts (users_id) VALUES (:userId)")
                        .bind("userId", userId)
                        .execute();

        return handle.createQuery("SELECT LAST_INSERT_ID()")
                .mapTo(Integer.class)
                .findFirst()
                .orElse(0);
    });

    }
    //Các phương thức cho cartItems
    public CartItem getCartItem(int cartId, int variantId){
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM cart_items WHERE carts_id = :cartId AND productvariants_id = :variantId")
                        .bind("cartId", cartId)
                        .bind("variantId", variantId)
                        .mapToBean(CartItem.class)
                        .findFirst()
                        .orElse(null));
    }
    public void insertCartItem(int cartId, int variantId, int quantity){
        jdbi.useHandle(handle ->
                handle.createUpdate("INSERT INTO cart_items (carts_id, productvariants_id, quantity) VALUES (:cartId, :variantId, :quantity)")
                        .bind("cartId", cartId)
                        .bind("variantId", variantId)
                        .bind("quantity", quantity)
                        .execute());
    }

    public void updateCartItemQuantity(int cartId, int variantId, int quantity){
        jdbi.useHandle(handle ->
                handle.createUpdate("UPDATE cart_items SET quantity = :quantity WHERE carts_id = :cartId AND productvariants_id = :variantId")
                        .bind("cartId", cartId)
                        .bind("variantId", variantId)
                        .bind("quantity", quantity)
                        .execute());
    }

    public void deleteCartItem(int cartId, int variantId){
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM cart_items WHERE carts_id = :cartId AND productvariants_id = :variantId")
                        .bind("cartId", cartId)
                        .bind("variantId", variantId)
                        .execute());
    }
    public void clearCart(int cartId){
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM cart_items WHERE carts_id = :cartId")
                        .bind("cartId", cartId)
                        .execute());
    }

    public int getTotalQuantity(int cartId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COALESCE(SUM(quantity), 0) FROM cart_items WHERE carts_id = :cartId")
                        .bind("cartId", cartId)
                        .mapTo(Integer.class)
                        .findFirst()
                        .orElse(0));
    }

    public List<CartItemDTO> getListItems(int cartId){
        return jdbi.withHandle(handle ->
                handle.createQuery(
                        "SELECT ci.productvariants_id AS productVariantId, " +
                                "ci.quantity AS quantity, " +
                                "p.name AS name, " +
                                "pv.sell_price AS price, " +
                                "pv.main_image_url AS img " +
                                "FROM cart_items ci " +
                                "JOIN productvariants pv ON ci.productvariants_id = pv.id " +
                                "JOIN products p ON pv.product_id = p.id " +
                                "WHERE ci.carts_id = :cartId")
                        .bind("cartId", cartId)
                        .mapToBean(CartItemDTO.class)
                        .list()
                );
    }
}
