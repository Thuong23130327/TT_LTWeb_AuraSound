package model.entity;

import model.enums.OrderStatus;
import model.enums.PaymentStatus;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

public class Order {

    private int id;
    private User user;
    private int vouchersId;
    private String orderCode;
    private Timestamp orderDate;
    private OrderStatus status;
    private PaymentStatus paymentStatus;
    private BigDecimal totalProductsPrice;
    private BigDecimal shippingFee;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;
    private String adminNote;
    private Timestamp finishedAt;

    private String recipientName;
    private List<OrderItem> items;
    //Get - set

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

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public Timestamp getFinishedAt() {
        return finishedAt;
    }

    public void setFinishedAt(Timestamp finishedAt) {
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

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(int value) {
        this.status = OrderStatus.fromInt(value);
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int value) {
        this.paymentStatus = PaymentStatus.fromInt(value);
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
