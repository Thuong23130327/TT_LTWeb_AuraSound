package model.enums;

public enum ContactStatus {
    NEW(0, "Mới"),
    READ(1, "Đã phản hồi");

    private final int value;
    private final String description;

    ContactStatus(int value, String description) {
        this.value = value;
        this.description = description;
    }

    public int getValue() {
        return value;
    }

    public String getDescription() {
        return description;
    }

    public static ContactStatus fromValue(int value) {
        for (ContactStatus s : values()) {
            if (s.value == value) return s;

        }
        return NEW;
    }


}
