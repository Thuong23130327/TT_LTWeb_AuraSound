package model.entity;

import model.enums.OrderStatus;
import model.enums.PaymentStatus;
import org.jdbi.v3.core.mapper.reflect.ColumnName;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.time.format.DateTimeFormatter;

public class Order {

    private int id;
    private int userId;
    private int vouchersId;
    private String orderCode;
    private LocalDateTime orderDate;
    private OrderStatus status;
    private PaymentStatus paymentStatus;
    private BigDecimal totalProductsPrice;
    private BigDecimal shippingFee;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;
    private String adminNote;
    private LocalDateTime finishedAt;

    private String recipientName;
    private List<OrderItem> items;

    private String shippingOrderCode;

    //Thông tin cho admin
    private String shippingPhone;
    private String shippingAddress;
    private String shippingCity;
    private String customerEmail;
    private String shippingNote;

    //Get - set

    @Override
	public String toString() {
		return "Order [id=" + id + ", userId=" + userId + ", vouchersId=" + vouchersId + ", orderCode=" + orderCode
				+ ", orderDate=" + orderDate + ", status=" + status + ", paymentStatus=" + paymentStatus
				+ ", totalProductsPrice=" + totalProductsPrice + ", shippingFee=" + shippingFee + ", discountAmount="
				+ discountAmount + ", finalAmount=" + finalAmount + ", adminNote=" + adminNote + ", finishedAt="
				+ finishedAt + ", recipientName=" + recipientName + ", items=" + items + "]\n";
	}

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderCode() {
        return orderCode;
    }

    @ColumnName("order_code")
    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    @ColumnName("order_date")
    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public LocalDateTime getFinishedAt() {
        return finishedAt;
    }

    public void setFinishedAt(LocalDateTime finishedAt) {
        this.finishedAt = finishedAt;
    }

    public String getAdminNote() {
        return adminNote;
    }

    public void setAdminNote(String adminNote) {
        this.adminNote = adminNote;
    }

    public String getRecipientName() {
        return recipientName;
    }

    @ColumnName("recipient_name")
    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public int getVouchersId() {
        return vouchersId;
    }

    @ColumnName("vouchers_id")
    public void setVouchersId(int vouchersId) {
        this.vouchersId = vouchersId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getStatus() {
        return status != null ? status.getValue() : 0;
    }

    public void setStatus(int value) {
        this.status = OrderStatus.fromValue(value);
    }
    public OrderStatus getEOrderStatus() {
        return status;
    }

    public String getStatusClass() {
        if (status == null) return "secondary";

        switch (status) {
            case PENDING:
                return "warning";

            case SHIPPING:
                return "primary";

            case COMPLETED:
                return "success";

            case CANCELLED:
                return "danger";

            case RETURNED:
                return "dark";
            default:
                return "secondary";
        }
    }
    public int getPaymentStatus() {
        return paymentStatus != null ? paymentStatus.getValue() : 0;
    }
    public PaymentStatus getEPaymentStatus() {
        return paymentStatus;
    }
    public void setPaymentStatus(int value) {
        this.paymentStatus = PaymentStatus.fromValue(value);
    }

    public BigDecimal getTotalProductsPrice() {
        return totalProductsPrice;
    }

    @ColumnName("total_products_price")
    public void setTotalProductsPrice(BigDecimal totalProductsPrice) {
        this.totalProductsPrice = totalProductsPrice;
    }

    public BigDecimal getShippingFee() {
        return shippingFee;
    }

    @ColumnName("shipping_fee")
    public void setShippingFee(BigDecimal shippingFee) {
        this.shippingFee = shippingFee;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    @ColumnName("discount_amount")
    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getFinalAmount() {
        return finalAmount;
    }

    @ColumnName("final_amount")
    public void setFinalAmount(BigDecimal finalAmount) {
        this.finalAmount = finalAmount;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public String getShippingOrderCode() {
        return shippingOrderCode;
    }

    @ColumnName("shipping_order_code")
    public void setShippingOrderCode(String shippingOrderCode) {
        this.shippingOrderCode = shippingOrderCode;
    }

    //Nhóm Admin
    @ColumnName("shipping_phone")
    public String getShippingPhone() { return shippingPhone; }
    public void setShippingPhone(String shippingPhone) { this.shippingPhone = shippingPhone; }

    @ColumnName("shipping_address")
    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    @ColumnName("shipping_city")
    public String getShippingCity() { return shippingCity; }
    public void setShippingCity(String shippingCity) { this.shippingCity = shippingCity; }

    @ColumnName("customer_email")
    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    @ColumnName("shipping_note")
    public String getShippingNote() { return shippingNote; }
    public void setShippingNote(String shippingNote) { this.shippingNote = shippingNote; }

    //Định dạng ngày/h vn cho chi tiết đơn ở trong qly đơn
    public String getFormattedOrderDate() {
        if (this.orderDate == null) return "";
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            return this.orderDate.format(formatter);
        } catch (Exception e) {
            return this.orderDate.toString().replace("T", " ");
        }
    }
}
