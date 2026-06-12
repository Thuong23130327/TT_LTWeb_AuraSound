package model.dto;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.util.ArrayList;
import java.util.List;

public class CartItemDTO {
    private int productId;
    private int productVariantId;
    private String name;    //bảng products
    private int quantity;
    private double price;   //bảng productvariants
    private String img;     //bảng productvariants
    private boolean isChecked = true;
    private String colorName;
    private List<VariantOptionDTO> variantOptions = new ArrayList<>();

    public CartItemDTO() {
    }

    public CartItemDTO(int productVariantId, String name, int quantity, double price, String img, boolean isChecked) {
        this.productVariantId = productVariantId;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.img = img;
        this.isChecked = isChecked;
    }

    public CartItemDTO(int productId, int productVariantId, String name, int quantity, double price, String img, boolean isChecked, String colorName, List<VariantOptionDTO> variantOptions) {
        this.productId = productId;
        this.productVariantId = productVariantId;
        this.name = name;
        this.quantity = quantity;
        this.price = price;
        this.img = img;
        this.isChecked = isChecked;
        this.colorName = colorName;
        this.variantOptions = variantOptions;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public boolean isChecked() {
        return isChecked;
    }

    public void setChecked(boolean checked) {
        isChecked = checked;
    }

    public double getTotalItemPrice() {
        return this.price * this.quantity;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public List<VariantOptionDTO> getVariantOptions() {
        return variantOptions;
    }

    public void setVariantOptions(List<VariantOptionDTO> variantOptions) {
        this.variantOptions = variantOptions;
    }

    public int getProductId() { return productId; }

    @ColumnName("products_id")
    public void setProductId(int productId) { this.productId = productId; }
}