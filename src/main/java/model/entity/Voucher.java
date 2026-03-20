package model.entity;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.time.LocalDateTime;

public class Voucher {
    private int id;
    private String code; // Mã Vou để app
    private double discountAmount; // % giảm
    private double minimumOrderAmount; // giá trị tối thiểu
    private int usageLimit; // Số lần Voucher đc dùng
    private LocalDateTime createdAt; // Ngày bắt đầu hiệu lực
    private LocalDateTime endDate;

    public Voucher() {
    }

    public Voucher(int id, String code, double discountAmount, double minimumOrderAmount, int usageLimit, LocalDateTime endDate, LocalDateTime createdAt) {
        this.id = id;
        this.code = code;
        this.discountAmount = discountAmount;
        this.minimumOrderAmount = minimumOrderAmount;
        this.usageLimit = usageLimit;
        this.endDate = endDate;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }
    @ColumnName("discount_amount")
    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getMinimumOrderAmount() {
        return minimumOrderAmount;
    }
    @ColumnName("min_order_value")
    public void setMinimumOrderAmount(double minimumOrderAmount) {
        this.minimumOrderAmount = minimumOrderAmount;
    }

    public int getUsageLimit() {
        return usageLimit;
    }
    @ColumnName("usage_limit")
    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }
    @ColumnName("end_date")
    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    @ColumnName("created_at")
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

}
