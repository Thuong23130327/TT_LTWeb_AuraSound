package dao;

import model.entity.Cart;
import model.entity.CartItem;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CartDAO {
    private Jdbi jdbi;

    public CartDAO(Jdbi jdbi) {
        this.jdbi = jdbi;
    }

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
}
