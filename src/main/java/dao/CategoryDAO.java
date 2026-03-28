package dao;

import model.entity.Category;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class CategoryDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Category> getAll() {
        String sql = "SELECT * FROM Categories";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Category.class).list());
    }

    public Category getCategoryById(int id) {
        String sql = "SELECT id, name, parents_id FROM Categories WHERE id = :id";
        try {
            return jdbi.withHandle(handle ->
                    handle.createQuery(sql)
                            .bind("id", id)
                            .mapToBean(Category.class)
                            .findOne()
                            .orElse(null)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
//        System.out.println(dao.getAll());
        System.out.println(dao.getCategoryById(3));
    }


}
