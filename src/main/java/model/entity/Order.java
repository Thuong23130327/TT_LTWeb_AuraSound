package model.entity;

import model.enums.OrderStatus;
import model.enums.PaymentStatus;

import java.sql.Timestamp;

public class Order {
	private int id;
	private int usersId;
	private int vouchersId;
	private String orderCode;
	private Timestamp orderDate;
	private OrderStatus status;
	private PaymentStatus paymentStatus;
	private double totalProductsPrice;
	private double shippingFee;
	private double discountAmount;
	private double finalAmount;
	private String adminNote;
	private Timestamp finishedAt; // ngay hoan thanh
	private String recipientName;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//Get - set
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Integer getUsersId() {
		return usersId;
	}

	public void setUsersId(Integer usersId) {
		if (usersId == null) {
			this.usersId = 0;
		} else
			this.usersId = usersId;
	}

	public int getVouchersId() {
		return vouchersId;
	}

	public void setVouchersId(int vouchersId) {
		this.vouchersId = vouchersId;
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

	public double getTotalProductsPrice() {
		return totalProductsPrice;
	}

	public void setTotalProductsPrice(double totalProductsPrice) {
		this.totalProductsPrice = totalProductsPrice;
	}

	public double getShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(double shippingFee) {
		this.shippingFee = shippingFee;
	}

	public double getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(double discountAmount) {
		this.discountAmount = discountAmount;
	}

	public double getFinalAmount() {
		return finalAmount;
	}

	public void setFinalAmount(double finalAmount) {
		this.finalAmount = finalAmount;
	}

	public String getAdminNote() {
		return adminNote;
	}

	public void setAdminNote(String adminNote) {
		this.adminNote = adminNote;
	}

	public Timestamp getFinishedAt() {
		return finishedAt;
	}

	public void setFinishedAt(Timestamp finishedAt) {
		this.finishedAt = finishedAt;
	}

	public String getRecipientName() {
		return recipientName;
	}

	public void setRecipientName(String recipientName) {
		this.recipientName = recipientName;
	}

}
