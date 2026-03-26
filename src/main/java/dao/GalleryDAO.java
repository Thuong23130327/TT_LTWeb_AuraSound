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
}
