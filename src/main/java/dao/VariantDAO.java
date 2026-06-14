package dao;

import model.entity.Brand;
import model.entity.Product;
import model.entity.ProductVariant;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.reflect.FieldMapper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VariantDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<ProductVariant> getVariantsByProductId(String pid) {

        return jdbi.withHandle(handle -> {
            handle.registerRowMapper(FieldMapper.factory(ProductVariant.class));
            return handle.createQuery("SELECT * FROM ProductVariants WHERE products_id = :pid")
                    .bind("pid", pid)
                    .mapTo(ProductVariant.class).list();
        });
    }


    public ProductVariant getProductVariant(String vid) {
        String sql = "SELECT * FROM ProductVariants WHERE id = :vid";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("vid", vid)
                        .mapToBean(ProductVariant.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public static void main(String[] args) {
        VariantDAO dao = new VariantDAO();
        System.out.println(dao.getVariantsByProductId("1"));
    }
    public int insertVariant(int productId, String colorName,
                             java.math.BigDecimal marketPrice,
                             java.math.BigDecimal sellPrice,
                             int stockQuantity, String imageUrl) {
        try {
            return jdbi.withHandle(handle ->
                    handle.createUpdate(
                                    "INSERT INTO productvariants " +
                                            "(products_id, color_name, market_price, sell_price, stock_quantity, main_image_url, is_default) " +
                                            "VALUES (:pid, :color, :market, :sell, :stock, :img, 0)")
                            .bind("pid",    productId)
                            .bind("color",  colorName)
                            .bind("market", marketPrice)
                            .bind("sell",   sellPrice)
                            .bind("stock",  stockQuantity)
                            .bind("img",    imageUrl)
                            .executeAndReturnGeneratedKeys("id")
                            .mapTo(Integer.class)
                            .findFirst()
                            .orElse(-1)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }
    public boolean updateVariant(int variantId, String colorName,
                                 java.math.BigDecimal marketPrice,
                                 java.math.BigDecimal sellPrice,
                                 int stockQuantity, String imageUrl) {
        try {
            jdbi.useHandle(handle -> {
                StringBuilder sql = new StringBuilder(
                        "UPDATE productvariants " +
                                "SET color_name = :color, market_price = :market, " +
                                "    sell_price = :sell, stock_quantity = :stock");
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    sql.append(", main_image_url = :img");
                }
                sql.append(" WHERE id = :id");
                var upd = handle.createUpdate(sql.toString())
                        .bind("color",  colorName)
                        .bind("market", marketPrice)
                        .bind("sell",   sellPrice)
                        .bind("stock",  stockQuantity)
                        .bind("id",     variantId);
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    upd.bind("img", imageUrl);
                }
                upd.execute();
            });
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteVariant(int variantId) {
        try {
            jdbi.useHandle(handle ->
                    handle.createUpdate("DELETE FROM productvariants WHERE id = :id")
                            .bind("id", variantId)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
