package dao;

import dao.DB.DBConnect;
import model.entity.Product;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.FieldMapper;

import java.util.List;

public class WishlistDAO {

    private final Jdbi jdbi = DBConnect.getJdbi();

    //   Them 1 sp vo list
    public boolean addWishlist(int userId, int productId) {
        try {
            int rowsAffected = jdbi.withHandle(handle ->
                    handle.createUpdate("INSERT IGNORE INTO wishlists (users_id, products_id) VALUES (:userId, :productId)")
                            .bind("userId", userId)
                            .bind("productId", productId)
                            .execute()
            );
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //   Xoa 1 sp khoi list
    public boolean removeWishlist(int userId, int productId) {
        try {
            int rowsAffected = jdbi.withHandle(handle ->
                    handle.createUpdate("DELETE FROM wishlists WHERE users_id = :userId AND products_id = :productId")
                            .bind("userId", userId)
                            .bind("productId", productId)
                            .execute()
            );
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    //   Check xem user da tim sp nay hay chua
    public boolean checkWishlist(int userId, int productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM wishlists WHERE users_id = :userId AND products_id = :productId")
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .mapTo(Integer.class)
                        .findFirst()
                        .orElse(0) > 0
        );
    }

    //Lay ds yeu thich cua user
    public List<Product> getWishlistByUser(int userId) {
        return jdbi.withHandle(handle -> {
            handle.registerRowMapper(FieldMapper.factory(Product.class));

            return handle.createQuery(
                            "SELECT p.* FROM products p " +
                                    "JOIN wishlists w ON p.id = w.products_id " +
                                    "WHERE w.users_id = :userId " +
                                    "ORDER BY w.created_at DESC")
                    .bind("userId", userId)
                    .mapTo(Product.class)
                    .list();
        });
    }

    public static void main(String[] args) {
        WishlistDAO dao = new WishlistDAO();

        // Giả sử test với user_id = 1 và product_id = 5
         boolean isAdded = dao.addWishlist(1, 5);
         System.out.println("Thêm thành công: " + isAdded);

         boolean isWished = dao.checkWishlist(1, 5);
         System.out.println("Đã yêu thích chưa: " + isWished);
    }
}
