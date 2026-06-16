package dao;

import model.entity.Brand;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class BrandDAO {

    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Brand> getAll() {
        String sql = "SELECT * FROM Brands";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Brand.class).list());
    }

    public static void main(String[] args) {
        BrandDAO dao = new BrandDAO();
        System.out.println(dao.getAll());
    }
    public boolean update(int id, String name, String logoUrl) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE brands SET name = :name" +
                                (logoUrl != null ? ", logo_url = :logoUrl" : "") +
                                " WHERE id = :id")
                        .bind("id", id)
                        .bind("name", name)
                        .bind("logoUrl", logoUrl)
                        .execute() > 0);
    }
    public boolean insert(String name, String logoUrl) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO brands (name, logo_url, is_active) VALUES (:name, :logo, 1)")
                        .bind("name", name).bind("logo", logoUrl).execute() > 0);
    }

    public boolean delete(int id) {
        return jdbi.withHandle(handle -> {
            int productCount = handle.createQuery("SELECT COUNT(*) FROM products WHERE brands_id = :id")
                    .bind("id", id)
                    .mapTo(Integer.class).one();

            if (productCount > 0) {
                System.out.println("CẢNH BÁO: Không thể xóa Hãng này vì vẫn còn sản phẩm thuộc Hãng");
                return false;
            }
            return handle.createUpdate("DELETE FROM brands WHERE id = :id")
                    .bind("id", id).execute() > 0;
        });
    }
}
