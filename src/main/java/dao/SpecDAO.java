package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.ProductSpec;

import static dao.ContactDAO.jdbi;

public class SpecDAO {
    private Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    //Lay thong so tu prdid
    public List<ProductSpec> getSpecsByProductId(String productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM productspecs WHERE Products_id = :productId")
                        .bind("productId", productId)
                        .mapToBean(ProductSpec.class)
                        .list()
        );
    }


}