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

    public boolean insert(String imageUrl, String targetUrl) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO banners (image_url, target_url, is_active) VALUES (:img, :url, 1)")
                        .bind("img", imageUrl).bind("url", targetUrl).execute() > 0);
    }

    public boolean delete(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM banners WHERE id = :id")
                        .bind("id", id).execute() > 0);
    }
}
