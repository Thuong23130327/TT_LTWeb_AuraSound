package model.entity;

import java.math.BigDecimal;
import org.jdbi.v3.core.mapper.Nested;

public class OrderItem {
	private int id;
	private int ordersId;
	private ProductVariant productVariant;
	private int quantity;
	private BigDecimal price_at_purchase;

	
//	Get-set
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOrdersId() {
		return ordersId;
	}

	public void setOrdersId(int ordersId) {
		this.ordersId = ordersId;
	}

    @Nested("pv")
	public ProductVariant getProductVariant() {
		return productVariant;
	}

	public void setProductVariant(ProductVariant productVariant) {
		this.productVariant = productVariant;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getPrice_at_purchase() {
		return price_at_purchase;
	}

	public void setPrice_at_purchase(BigDecimal price_at_purchase) {
		this.price_at_purchase = price_at_purchase;
	}

	@Override
	public String toString() {
		return "OrderItem [id=" + id + ", ordersId=" + ordersId + ", productVariant=" + productVariant + ", quantity="
				+ quantity + ", price_at_purchase=" + price_at_purchase + "]\n";
	}
	

}
