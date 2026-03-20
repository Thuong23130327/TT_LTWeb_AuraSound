package dao;

import model.entity.Banner;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class BannerDAO {

    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public List<Banner> getAll() {
        String sql = "SELECT * FROM Banners";
        return jdbi.withHandle(handle -> handle.createQuery(sql).mapToBean(Banner.class).list());
    }

    public static void main(String[] args) {
       BannerDAO bannerDAO = new BannerDAO();
        System.out.println(bannerDAO.getAll());
    }


}
