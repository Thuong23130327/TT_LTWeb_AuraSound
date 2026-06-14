package dao;

import model.entity.Image;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class GalleryDAO {
    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    //lấy danh sách ảnh theo ID sản phẩm
    public List<Image> getImagesByProductId(String productId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM ProductGalleries WHERE Products_id = :productId ORDER BY sort_order")
                        .bind("productId", productId)
                        .mapToBean(Image.class)
                        .list()
        );
    }

    public boolean insertImage(int productId, String imageUrl) {
        try {
            jdbi.useHandle(handle ->
                    handle.createUpdate(
                                    "INSERT INTO productgalleries (Products_id, image_url, sort_order) " +
                                            "VALUES (:pid, :url, " +
                                            "  (SELECT COALESCE(MAX(g.sort_order), 0) + 1 " +
                                            "   FROM productgalleries g WHERE g.Products_id = :pid2))")
                            .bind("pid",  productId)
                            .bind("url",  imageUrl)
                            .bind("pid2", productId)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteImage(int imgId) {
        try {
            jdbi.useHandle(handle ->
                    handle.createUpdate("DELETE FROM productgalleries WHERE id = :id")
                            .bind("id", imgId)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean updateOrder(String[] imgIds, String[] orders) {
        try {
            jdbi.useHandle(handle -> {
                var batch = handle.prepareBatch(
                        "UPDATE productgalleries SET sort_order = :order WHERE id = :id");
                for (int i = 0; i < imgIds.length; i++) {
                    batch.bind("order", Integer.parseInt(orders[i]))
                            .bind("id",    Integer.parseInt(imgIds[i]))
                            .add();
                }
                batch.execute();
            });
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
