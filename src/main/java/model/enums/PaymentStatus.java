package model.enums;
public enum PaymentStatus {
    UNPAID(0, "Chưa thanh toán"),
    PAID(1, "Đã thanh toán"),
    REFUNDED(2, "Đã hoàn tiền");

    private final int value;
    private final String description;

    PaymentStatus(int value, String description) {
        this.value = value;
        this.description = description;
    }

    public int getValue() { return value; }
    public String getDescription() { return description; }

    public static PaymentStatus fromInt(int value) {
        for (PaymentStatus p : values()) {
            if (p.value == value) return p;
        }
        return UNPAID;
    }


}
