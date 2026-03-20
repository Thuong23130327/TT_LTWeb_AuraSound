package model.entity;

public class CartItemDTO {
    private int productVariantId;
    private String name;    //bảng products
    private int quantity;
    private double price;   //bảng productvariants
    private String img;     //bảng productvariants
    private boolean isChecked = true;

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
}