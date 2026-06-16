package dao;

import model.entity.FooterLink;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class FooterLinkDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();


    public boolean insert(FooterLink link) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO footer_links (title, target_url, sort_order) VALUES (:title, :targetUrl, :sortOrder)")
                        .bindBean(link).execute() > 0);
    }

    public boolean delete(int id) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("DELETE FROM footer_links WHERE id = :id")
                        .bind("id", id).execute() > 0);
    }

    public List<FooterLink> getAll() {
        String sql = "SELECT * FROM footer_links ORDER BY sort_order ASC";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(FooterLink.class).list());
    }

    public boolean update(int id, String title, String targetUrl, int sortOrder) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE footer_links SET title = :title, target_url = :targetUrl, sort_order = :sortOrder WHERE id = :id")
                        .bind("id", id)
                        .bind("title", title)
                        .bind("targetUrl", targetUrl)
                        .bind("sortOrder", sortOrder)
                        .execute() > 0);
    }
}