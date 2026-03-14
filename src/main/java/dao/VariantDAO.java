package dao;

import model.entity.Brand;
import model.entity.ProductVariant;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VariantDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<ProductVariant> getVariantsByProductId(String pid) {
        String sql = "SELECT * FROM ProductVariants WHERE Products_id = :pid";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("pid", pid)
                        .mapToBean(ProductVariant.class).list());
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



}
