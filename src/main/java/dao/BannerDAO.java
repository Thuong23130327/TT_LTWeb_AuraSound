package dao;

import model.entity.Banner;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class BannerDAO {

    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Banner> getAll() {
        String sql = "SELECT * FROM Banners ORDER BY sort_order ASC";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Banner.class).list());
    }

    public static void main(String[] args) {
        BannerDAO bannerDAO = new BannerDAO();
        System.out.println(bannerDAO.getAll());
    }
    public boolean updateSortOrder(int id, int sortOrder) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE banners SET sort_order = :sort WHERE id = :id")
                        .bind("sort", sortOrder)
                        .bind("id", id)
                        .execute() > 0);
    }
    public List<Banner> getActiveBanners() {
        String sql = "SELECT * FROM Banners WHERE is_active = 1 ORDER BY sort_order ASC";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Banner.class).list());
    }

    public boolean update(int id, String title, String description, String targetUrl, int sortOrder) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE banners SET title = :title, description = :desc, target_url = :url, sort_order = :sort WHERE id = :id")
                        .bind("title", title)
                        .bind("desc", description)
                        .bind("url", targetUrl)
                        .bind("sort", sortOrder)
                        .bind("id", id)
                        .execute() > 0);
    }

    public boolean insert(String imageUrl, String targetUrl, String title, String description, int sortOrder) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO banners (image_url, target_url, title, description, sort_order, is_active) VALUES (:img, :url, :title, :desc, :sort, 1)")
                        .bind("img", imageUrl)
                        .bind("url", targetUrl)
                        .bind("title", title)
                        .bind("desc", description)
                        .bind("sort", sortOrder)
                        .execute() > 0);
    }

    public boolean updateStatus(int id, boolean newStatus) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE banners SET is_active = :status WHERE id = :id")
                        .bind("status", newStatus ? 1 : 0)
                        .bind("id", id)
                        .execute() > 0);
    }

    public boolean delete(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM banners WHERE id = :id")
                        .bind("id", id).execute() > 0);
    }

}
