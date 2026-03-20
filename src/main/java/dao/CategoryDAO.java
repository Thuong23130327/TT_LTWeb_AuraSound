package dao;

import dao.DB.DBConnect;
import model.entity.Category;
import org.jdbi.v3.core.Jdbi;
import java.sql.SQLException;
import java.util.List;

public class CategoryDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Category> getAll() {
        String sql = "SELECT * FROM Categories";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Category.class).list());
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
        System.out.println(dao.getAll());
    }


}
