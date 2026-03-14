package model.entity;

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

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getCategoriesId() {
        return categoriesId;
    }

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

    public void setOldPrice(double oldPrice) {
        this.oldPrice = oldPrice;
    }

    public double getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(double sellPrice) {
        this.sellPrice = sellPrice;
    }

    public String getImg() {
        return img;
    }

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
}
