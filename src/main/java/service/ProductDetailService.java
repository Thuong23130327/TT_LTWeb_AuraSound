package service;

import dao.CategoryDAO;
import dao.GalleryDAO;
import dao.SpecDAO;
import dao.VariantDAO;
import model.entity.Category;
import model.entity.Image;
import model.entity.ProductSpec;
import model.entity.ProductVariant;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDetailService {

    private VariantDAO variantDAO = new VariantDAO();
    private SpecDAO specDAO = new SpecDAO();
    private GalleryDAO galleryDAO = new GalleryDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    // Lấy ds biến thể
    public List<ProductVariant> getVariantsByProductId(String productId) {
        return variantDAO.getVariantsByProductId(productId);
    }

    // Lấy chi tiết 1 biến thể
    public ProductVariant getProductVariant(String variantId) throws SQLException {
        return variantDAO.getProductVariant(variantId);
    }

    //lấy thông tin kỹ thuật của sp
    public List<ProductSpec> getAllSpecByProductId(String productId) throws SQLException, ClassNotFoundException {
        List<ProductSpec> specs = specDAO.getSpecsByProductId(productId);
        return specs != null ? specs : null;
    }

    //lấy tất cả biến thể bằng id
    public List<ProductVariant> getAllVariantByProductId(String productId) throws SQLException, ClassNotFoundException {
        List<ProductVariant> variants = variantDAO.getVariantsByProductId(productId);
        return variants != null ? variants : null;
    }

    //lấy ảnh tất cả biến thể
    public List<Image> getImageByProductId(String productId) throws SQLException, ClassNotFoundException {
        if (productId == null || productId.isEmpty()) return null;
        return galleryDAO.getImagesByProductId(productId);
    }

    //lấy biến thể bằng ảnh
    public ProductVariant getVariantByImg(List<ProductVariant> list, String img) throws SQLException, ClassNotFoundException {
        if (list == null || list.isEmpty()) {
            return null;
        }
        for (ProductVariant productVariant : list) {
            if (productVariant.getMainImageUrl() != null && productVariant.getMainImageUrl().equalsIgnoreCase(img)) {
                return productVariant;
            }
        }
        return list.get(0);
    }

    //xác định danh mục của sản phẩm
    public List<Category> getCategory(int id){
        List<Category> list = new ArrayList<>();
        CategoryDAO dao = new CategoryDAO();

        Category current = dao.getCategoryById(id);
        while (current != null) {
            list.add(0, current);

            if (current.getParentId() <= 0) break;
            current = dao.getCategoryById(Integer.parseInt(String.valueOf(current.getParentId())));
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDetailService service = new ProductDetailService();
        System.out.println(service.getCategory(3));
    }

}
