package model.entity;

import model.enums.OrderStatus;
import model.enums.PaymentStatus;
import org.jdbi.v3.core.mapper.reflect.ColumnName;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

public class Order {

    private int id;
    private User user;
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

    //Get - set

    @Override
	public String toString() {
		return "Order [id=" + id + ", user=" + user + ", vouchersId=" + vouchersId + ", orderCode=" + orderCode
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

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

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

    public void setVouchersId(int vouchersId) {
        this.vouchersId = vouchersId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public void setTotalProductsPrice(BigDecimal totalProductsPrice) {
        this.totalProductsPrice = totalProductsPrice;
    }

    public BigDecimal getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(BigDecimal shippingFee) {
        this.shippingFee = shippingFee;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(BigDecimal finalAmount) {
        this.finalAmount = finalAmount;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
