package service;

import dao.VariantDAO;
import model.entity.ProductVariant;

import java.sql.SQLException;
import java.util.List;

public class ProductVariantService {
    private VariantDAO variantDAO = new VariantDAO();

    //lấy ds biến thể
    public List<ProductVariant> getVariantsByProductId(String productId) {
        return variantDAO.getVariantsByProductId(productId);
    }

    //lấy chi tiết 1 biến thể
    public ProductVariant getProductVariant(String variantId) throws SQLException {
        return variantDAO.getProductVariant(variantId);
    }
}
