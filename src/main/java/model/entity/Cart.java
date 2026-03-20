package model.entity;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Cart {
    private int id;
    private int userId;
    LocalDateTime createdAt;

    public Cart() {
    }

    public Cart(int id, int userId, LocalDateTime createdAt) {
        this.id = id;
        this.userId = userId;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    @ColumnName("users_id")
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    @ColumnName("created_at")
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
