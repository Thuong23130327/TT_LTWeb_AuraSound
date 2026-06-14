package dao;

import model.entity.ProductSpec;
import model.entity.ProductVariant;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SpecDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<ProductSpec> getSpecsByProductId(String pid) {
        String sql = "SELECT * FROM ProductSpecs WHERE Products_id = :pid";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .bind("pid", pid)
                        .mapToBean(ProductSpec.class).list());
    }

    public static void main(String[] args) {
        SpecDAO specDAO = new SpecDAO();
        System.out.println(specDAO.getSpecsByProductId("2"));
    }
    public boolean insertSpec(int productId, String specName, String specValue) {
        try {
            jdbi.useHandle(handle ->
                    handle.createUpdate(
                                    "INSERT INTO productspecs (Products_id, spec_name, spec_value) " +
                                            "VALUES (:pid, :name, :value)")
                            .bind("pid",   productId)
                            .bind("name",  specName)
                            .bind("value", specValue)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteSpec(int specId) {
        try {
            jdbi.useHandle(handle ->
                    handle.createUpdate("DELETE FROM productspecs WHERE id = :id")
                            .bind("id", specId)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
