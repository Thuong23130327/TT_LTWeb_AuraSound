package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Voucher {
    private int id;
    private String code;
    private double discountAmount;
    private double minimumOrderAmount;
    private int usageLimit;
    private LocalDateTime createdAt;
    private LocalDateTime endDate;


    private static final DateTimeFormatter DISPLAY_FMT =
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

    public Voucher() {}

    public Voucher(int id, String code, double discountAmount,
                   double minimumOrderAmount, int usageLimit,
                   LocalDateTime endDate, LocalDateTime createdAt) {
        this.id = id;
        this.code = code;
        this.discountAmount = discountAmount;
        this.minimumOrderAmount = minimumOrderAmount;
        this.usageLimit = usageLimit;
        this.endDate = endDate;
        this.createdAt = createdAt;
    }

    public int getId()                   { return id; }
    public String getCode()              { return code; }
    public double getDiscountAmount()    { return discountAmount; }
    public double getMinimumOrderAmount(){ return minimumOrderAmount; }
    public int getUsageLimit()           { return usageLimit; }
    public LocalDateTime getEndDate()    { return endDate; }
    public LocalDateTime getCreatedAt()  { return createdAt; }
    public String getEndDateFormatted() {
        return endDate != null ? endDate.format(DISPLAY_FMT) : "";
    }

    public String getCreatedAtFormatted() {
        return createdAt != null ? createdAt.format(DISPLAY_FMT) : "—";
    }
    public void setId(int id)                         { this.id = id; }
    public void setCode(String code)                  { this.code = code; }

    @ColumnName("discount_amount")
    public void setDiscountAmount(double v)           { this.discountAmount = v; }

    @ColumnName("min_order_value")
    public void setMinimumOrderAmount(double v)       { this.minimumOrderAmount = v; }

    @ColumnName("usage_limit")
    public void setUsageLimit(int v)                  { this.usageLimit = v; }

    @ColumnName("end_date")
    public void setEndDate(LocalDateTime v)           { this.endDate = v; }

    @ColumnName("created_at")
    public void setCreatedAt(LocalDateTime v)         { this.createdAt = v; }
}