package model.entity;

import java.sql.Timestamp;

public class Wishlist {
    private int id;
    private int usersId;
    private int productsId;
    private Timestamp createdAt;

    public Wishlist() {
    }

    public Wishlist(int id, int usersId, int productsId, Timestamp createdAt) {
        this.id = id;
        this.usersId = usersId;
        this.productsId = productsId;
        this.createdAt = createdAt;
    }

    public Wishlist(int usersId, int productsId) {
        this.usersId = usersId;
        this.productsId = productsId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUsersId() {
        return usersId;
    }

    public void setUsersId(int usersId) {
        this.usersId = usersId;
    }

    public int getProductsId() {
        return productsId;
    }

    public void setProductsId(int productsId) {
        this.productsId = productsId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
