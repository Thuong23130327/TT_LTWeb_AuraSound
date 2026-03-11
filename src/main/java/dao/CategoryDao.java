package dao;

import model.Category;
import model.Contact;
import model.Product;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    private Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Category> getAllCategories() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Categories")
                        .mapToBean(Category.class)
                        .list()
        );
    }

}
