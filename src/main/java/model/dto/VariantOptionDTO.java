// model/dto/VariantOptionDTO.java
package model.dto;

import org.jdbi.v3.core.mapper.reflect.ColumnName;

public class VariantOptionDTO {
    private int id;
    private String colorName;
    private String img;
    private double price;

    public VariantOptionDTO() {}

    public VariantOptionDTO(int id, String colorName, String img, double price) {
        this.id = id;
        this.colorName = colorName;
        this.img = img;
        this.price = price;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getColorName() { return colorName; }

    @ColumnName("color_name")
    public void setColorName(String colorName) { this.colorName = colorName; }

    public String getImg() { return img; }

    @ColumnName("main_image_url")
    public void setImg(String img) { this.img = img; }

    public double getPrice() { return price; }

    @ColumnName("sell_price")
    public void setPrice(double price) { this.price = price; }
}