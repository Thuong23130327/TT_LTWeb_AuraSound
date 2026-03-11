package model;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class ProductSpec {
	private int id;
	private int productId;
	private String specName;
	private String specValue;

	public ProductSpec() {
	}

	public ProductSpec(int id, int productId, String specName, String specValue) {
		super();
		this.id = id;
		this.productId = productId;
		this.specName = specName;
		this.specValue = specValue;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getProductId() {
		return productId;
	}

	@ColumnName("Products_id")
	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getSpecName() {
		return specName;
	}

	@ColumnName("spec_name")
	public void setSpecName(String specName) {
		this.specName = specName;
	}

	public String getSpecValue() {
		return specValue;
	}

	@ColumnName("spec_value")
	public void setSpecValue(String specValue) {
		this.specValue = specValue;
	}

	@Override
	public String toString() {
		return "ProductSpec [id=" + id + ", productId=" + productId + ", specName=" + specName + ", specValue="
				+ specValue + "]";
	}

}
