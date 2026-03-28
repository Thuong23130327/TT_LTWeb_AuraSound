package dao;

import org.jdbi.v3.core.Jdbi;
import service.ReviewService;

public class ReviewDAO {
    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    // lưu đánh giá & trả về id mới
    public int saveReview(String pid, String uid, String rating, String comment) {
        String sql = "INSERT INTO reviews (Products_id, Users_id, rating, comment) VALUES (?, ?, ?, ?)";

        try {
            return jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind(0, pid)
                            .bind(1, uid)
                            .bind(2, rating)
                            .bind(3, comment)
                            .executeAndReturnGeneratedKeys()
                            .mapTo(Integer.class)
                            .findFirst()
                            .orElse(-1)
            );
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }
    }

    // lưu ảnh đánh giá
    public boolean saveReviewImages(int reviewId, String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) return false;

        String sql = "INSERT INTO reviewgalleries (Reviews_id, image_url) VALUES (?, ?)";

        try {
            return jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind(0, reviewId)
                            .bind(1, imageUrl)
                            .execute() > 0
            );
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // cập nhật điểm đánh giá tb
    public boolean updateProductAvgRating(String productId) {
        String sql = "UPDATE products SET avg_rating = (SELECT AVG(CAST(rating AS DECIMAL(10,2))) " +
                "FROM reviews WHERE Products_id = ?) WHERE id = ?";

        try {
            return jdbi.withHandle(handle ->
                    handle.createUpdate(sql)
                            .bind(0, productId)
                            .bind(1, productId)
                            .execute() > 0
            );
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
