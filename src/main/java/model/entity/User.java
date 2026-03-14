package model.entity;

import java.security.Timestamp;

public class User {

    private int id;
    private String email;
    private String passwordHash;
    private String fullName;
    private String phone;
    private String avatarUrl;
    private Role role;
    private boolean isLocked;
    private Timestamp createdAt;

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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
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
                boolean isLocked, Timestamp createdAt) {
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
        Customer, Admin
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
