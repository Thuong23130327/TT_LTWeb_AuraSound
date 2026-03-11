package dao;

import model.Banner;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BannerDAO {

    private Banner mapBaner(ResultSet rs) throws SQLException {
        return new Banner(rs.getInt("id"), rs.getString("image_url"), rs.getString("target_url"), rs.getString("title")
                , rs.getString("description"), rs.getInt("sort_order"), rs.getBoolean("is_active"), rs.getTimestamp("created_at"));
    }

    public List<Banner> get3ListBanner() {
        String sql = "select * from banners where is_active=1 limit 3";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
        ) {
            List<Banner> listBanner = new ArrayList<Banner>();
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listBanner.add(mapBaner(rs));

            }
            return listBanner;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

    }
}
