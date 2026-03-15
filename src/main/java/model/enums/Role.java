package model.enums;

public enum Role {
    CUSTOMER(0, "khách hàng"),
    ADMIN(1, "admin");

    private final int value;
    private final String description;

    Role(int value, String description) {
        this.value = value;
        this.description = description;
    }

    public int getValue() {
        return value;
    }

    public String getDescription() {
        return description;
    }

    public static Role fromValue(int value) {
        for (Role role : Role.values()) {
            if (role.value == value) {
                return role;
            }
        }
        return CUSTOMER;
    }
}
