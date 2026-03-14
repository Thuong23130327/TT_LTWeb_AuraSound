package model.entity;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.sql.Timestamp;

public class Product {
    private int id;
    private int brandId;
    private int categoriesId;
    private String sku;
    private String name;
    private String description;
    private float avgRating;
    private int soldCount;
    private boolean isActive;
    private Timestamp createdAt;
    private double oldPrice;
    private double sellPrice;
    private String img;

    public Product() {
    }

    public Product(int id, int brandId, int categoriesId, String sku, String name, String description, float avgRating, int soldCount, boolean isActive, Timestamp createdAt, double oldPrice, double sellPrice, String img) {
        this.id = id;
        this.brandId = brandId;
        this.categoriesId = categoriesId;
        this.sku = sku;
        this.name = name;
        this.description = description;
        this.avgRating = avgRating;
        this.soldCount = soldCount;
        this.isActive = isActive;
        this.createdAt = createdAt;
        this.oldPrice = oldPrice;
        this.sellPrice = sellPrice;
        this.img = img;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getBrandId() {
        return brandId;
    }

    @ColumnName("Brands_id")
    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getCategoriesId() {
        return categoriesId;
    }

    @ColumnName("Categories_id")
    public void setCategoriesId(int categoriesId) {
        this.categoriesId = categoriesId;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getAvgRating() {
        return avgRating;
    }

    @ColumnName("avg_rating")
    public void setAvgRating(float avgRating) {
        this.avgRating = avgRating;
    }

    public int getSoldCount() {
        return soldCount;
    }

    public void setSoldCount(int soldCount) {
        this.soldCount = soldCount;
    }

    public boolean isActive() {
        return isActive;
    }

    @ColumnName("is_active")
    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public double getOldPrice() {
        return oldPrice;
    }

    @ColumnName("display_market_price")
    public void setOldPrice(double oldPrice) {
        this.oldPrice = oldPrice;
    }

    public double getSellPrice() {
        return sellPrice;
    }

    @ColumnName("display_sell_price")
    public void setSellPrice(double sellPrice) {
        this.sellPrice = sellPrice;
    }

    public String getImg() {
        return img;
    }

    @ColumnName("display_image_url")
    public void setImg(String img) {
        this.img = img;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", brandId=" + brandId +
                ", categoriesId=" + categoriesId +
                ", sku='" + sku + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", avgRating=" + avgRating +
                ", soldCount=" + soldCount +
                ", isActive=" + isActive +
                ", createdAt=" + createdAt +
                ", oldPrice=" + oldPrice +
                ", sellPrice=" + sellPrice +
                ", img='" + img + '\'' +
                '}';
    }

    public int getDiscountPercent() {
        if (this.oldPrice == 0) {
            return 0;
        }
        double result = ((this.oldPrice - this.sellPrice) / this.oldPrice) * 100;
        return (int) Math.round(result);
    }
}
