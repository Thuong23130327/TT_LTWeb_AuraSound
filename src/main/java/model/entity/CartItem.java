package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class CartItem {
    private int id;
    private int cartId;
    private int productVariantId;
    private int quantity;
    private LocalDateTime createdAt;

    public CartItem() {
    }

    public CartItem(int id, int cartId, int productVariantId, int quantity, LocalDateTime createdAt) {
        this.id = id;
        this.cartId = cartId;
        this.productVariantId = productVariantId;
        this.quantity = quantity;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCartId() {
        return cartId;
    }
    @ColumnName("carts_id")
    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductVariantId() {
        return productVariantId;
    }
    @ColumnName("productvariants_id")
    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    @ColumnName("created_at")
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
