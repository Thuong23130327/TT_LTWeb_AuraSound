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

    public boolean insert(String name, Integer parentId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO categories (name, parents_id) VALUES (:name, :parentId)")
                        .bind("name", name).bind("parentId", parentId).execute() > 0);
    }
    public boolean delete(int id) {
        return jdbi.withHandle(handle -> {
            int productCount = handle.createQuery("SELECT COUNT(*) FROM products WHERE categories_id = :id")
                    .bind("id", id)
                    .mapTo(Integer.class).one();
            int childCount = handle.createQuery("SELECT COUNT(*) FROM categories WHERE parents_id = :id")
                    .bind("id", id)
                    .mapTo(Integer.class).one();

            if (productCount > 0 || childCount > 0) {
                System.out.println("CẢNH BÁO: Không thể xóa Danh mục đang có sản phẩm hoặc có chứa thư mục con!");
                return false;
            }
            return handle.createUpdate("DELETE FROM categories WHERE id = :id")
                    .bind("id", id).execute() > 0;
        });
    }
    public boolean update(int id, String name, Integer parentId) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE categories SET name = :name, parents_id = :parentId WHERE id = :id")
                        .bind("id", id)
                        .bind("name", name)
                        .bind("parentId", parentId)
                        .execute() > 0);
    }
    public Category getCategoryById(int id) {
        String sql = "SELECT id, name, parents_id FROM Categories WHERE id = :id";
            return jdbi.withHandle(handle ->
                    handle.createQuery(sql)
                            .bind("id", id)
                            .mapToBean(Category.class)
                            .findFirst()
                            .orElse(null)
            );
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
//        System.out.println(dao.getAll());
        System.out.println(dao.getCategoryById(3));
    }


}
