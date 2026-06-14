package model.entity;

import java.math.BigDecimal;
import org.jdbi.v3.core.mapper.Nested;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class OrderItem {
	private int id;
	private int ordersId;
	private ProductVariant productVariant;
	private int quantity;
	private BigDecimal price_at_purchase;
	private String productName;

	
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

	@ColumnName("price_at_purchase")
	public BigDecimal getPrice_at_purchase() {
		return this.price_at_purchase;
	}

	public void setPrice_at_purchase(BigDecimal price_at_purchase) {
		this.price_at_purchase = price_at_purchase;
	}

	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	@Override
	public String toString() {
		return "OrderItem [id=" + id + ", ordersId=" + ordersId + ", productVariant=" + productVariant + ", quantity="
				+ quantity + ", price_at_purchase=" + price_at_purchase + "]\n";
	}
	

}
