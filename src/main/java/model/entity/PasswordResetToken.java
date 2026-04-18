package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;
import java.time.LocalDateTime;

public class PasswordResetToken {
    private int id;
    private String email;
    private String token;

    @ColumnName("expiry_date")
    private LocalDateTime expiryDate;

    @ColumnName("created_at")
    private LocalDateTime createdAt;

    // Getter và Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }
    public LocalDateTime getExpiryDate() { return expiryDate; }
    public void setExpiryDate(LocalDateTime expiryDate) { this.expiryDate = expiryDate; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}