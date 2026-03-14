package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class User {

    private int id;
    private String email;

    @ColumnName("password_hash")
    private String passwordHash;

    @ColumnName("full_name")
    private String fullName;
    private String phone;

    @ColumnName("avatar_url")
    private String avatarUrl;
    private Role role;

    @ColumnName("is_locked")
    private boolean isLocked;
    @ColumnName("created_at")
    private LocalDateTime createdAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public boolean isLocked() {
        return isLocked;
    }

    public void setLocked(boolean isLocked) {
        this.isLocked = isLocked;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public User() {
    }

    public User(String email, String passwordHash, String fullName) {
        super();
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.isLocked = false;
        this.avatarUrl = "";
        this.role = Role.Customer;
    }


    public User(int id, String email, String passwordHash, String fullName) {
        super();
        this.id = id;
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.isLocked = false;
        this.avatarUrl = "";
        this.role = Role.Customer;
    }

    public User(int id, String email, String passwordHash, String fullName, String phone, String avatarUrl, Role role,
                boolean isLocked, LocalDateTime createdAt) {
        super();
        this.id = id;
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.phone = phone;
        this.avatarUrl = avatarUrl;
        this.role = role;
        this.isLocked = isLocked;
        this.createdAt = createdAt;
    }

    public User(String email, String passwordHash) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = "New User";
        this.phone = null;
        this.avatarUrl = null;
        this.role = Role.Customer;
        this.isLocked = false;
    }

    public enum Role {
        Customer(0, "khách hàng"), Admin(1, "admin");
        private final int value;
        private final String description;

        Role(int value, String description) {
            this.value = value;
            this.description = description;
        }
        public int getValue() { return value; }
        public String getDescription() { return description; }

        public static Role fromValue(int value) {
            for (Role role : Role.values()) {
                if (role.value == value) {
                    return role;
                }
            }
            return Customer;
        }
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", passwordHash='" + passwordHash + '\'' +
                ", fullName='" + fullName + '\'' +
                ", phone='" + phone + '\'' +
                ", avatarUrl='" + avatarUrl + '\'' +
                ", role=" + role +
                ", isLocked=" + isLocked +
                ", createdAt=" + createdAt +
                '}';
    }
}
