package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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

    @ColumnName("failed_attempts")
    private int failedAttempts;

    @ColumnName("is_locked")
    private boolean isLocked;

    @ColumnName("created_at")
    private LocalDateTime createdAt;

    private List<Role> roles = new ArrayList<>();

    private Set<String> mergedPermissions = new HashSet<>();


    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
        updateMergedPermissions();
    }

    public Set<String> getMergedPermissions() {
        return mergedPermissions;
    }

    public void setMergedPermissions(Set<String> mergedPermissions) {
        this.mergedPermissions = mergedPermissions;
    }

    public void updateMergedPermissions() {
        this.mergedPermissions.clear();
        if (this.roles != null) {
            for (Role r : this.roles) {
                if (r.getPermissionsList() != null) {
                    this.mergedPermissions.addAll(r.getPermissionsList());
                }
            }
        }
    }

    public boolean hasPermission(String featureCode) {
        return mergedPermissions.contains(featureCode);
    }

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

    public boolean isLocked() {
        return isLocked;
    }

    public void setLocked(boolean isLocked) {
        this.isLocked = isLocked;
    }
    public boolean isIsLocked() {
        return isLocked;
    }

    public void setIsLocked(boolean isLocked) {
        this.isLocked = isLocked;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public int getFailedAttempts() {
        return failedAttempts;
    }

    public void setFailedAttempts(int failedAttempts) {
        this.failedAttempts = failedAttempts;
    }
}