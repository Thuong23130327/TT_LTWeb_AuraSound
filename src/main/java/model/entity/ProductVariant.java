package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.math.BigDecimal;

public class ProductVariant {
    private int id;
    private int productId;
    private String variantSku;
    private String colorName;
    private String mainImageUrl;
    private BigDecimal marketPrice;
    private BigDecimal sellPrice;

    private int stockQuantity;
    private int soldQuantity;
    private boolean isDefault;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    @ColumnName("products_id")
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getVariantSku() {
        return variantSku;
    }

    public void setVariantSku(String variantSku) {
        this.variantSku = variantSku;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getMainImageUrl() {
        return mainImageUrl;
    }

    public void setMainImageUrl(String mainImageUrl) {
        this.mainImageUrl = mainImageUrl;
    }

    public BigDecimal getMarketPrice() {
        return marketPrice;
    }

    public void setMarketPrice(BigDecimal marketPrice) {
        this.marketPrice = marketPrice;
    }

    public BigDecimal getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(BigDecimal sellPrice) {
        this.sellPrice = sellPrice;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public boolean isDefault() {
        return isDefault;
    }

    public void setDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    public int getDiscountPercent() {
        if (marketPrice == null || sellPrice == null || marketPrice.compareTo(java.math.BigDecimal.ZERO) <= 0) {
            return 0;
        }
        java.math.BigDecimal diff = marketPrice.subtract(sellPrice);
        java.math.BigDecimal percent = diff.divide(marketPrice, 2, java.math.RoundingMode.HALF_UP).multiply(new java.math.BigDecimal("100"));
        return percent.intValue();
    }


    @Override
    public String toString() {
        return "ProductVariant [id=" + id + ", productId=" + productId + ", variantSku=" + variantSku + ", colorName="
                + colorName + ", mainImageUrl=" + mainImageUrl + ", marketPrice=" + marketPrice + ", sellPrice="
                + sellPrice + ", stockQuantity=" + stockQuantity + ", soldQuantity=" + soldQuantity + ", isDefault="
                + isDefault;
    }
}
