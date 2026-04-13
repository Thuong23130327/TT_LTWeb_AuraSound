package model.enums;
public enum OrderStatus {
    PENDING(0, "Chờ duyệt"),
    SHIPPING(1, "Đang giao"),
    COMPLETED(2, "Hoàn thành"),
    CANCELLED(3, "Đã hủy");

    private final int value;
    private final String description;

    OrderStatus(int value, String description) {
        this.value = value;
        this.description = description;
    }

    public int getValue() { return value; }
    public String getDescription() { return description; }

    public static OrderStatus fromValue(int value) {
        for (OrderStatus s : values()) {
            if (s.value == value) return s;
        }
        return PENDING;
    }
}
