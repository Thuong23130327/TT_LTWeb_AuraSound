package service;

import dao.*;
import model.entity.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();
    private VariantDAO variantDAO = new VariantDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private BrandDAO brandDAO = new BrandDAO();
    BannerDAO bannerDAO = new BannerDAO();
    private SpecDAO specDAO = new SpecDAO();
    private GalleryDAO galleryDAO = new GalleryDAO();

    private int pageSize = 12;

    public List<Category> getAllCategories() {
        return categoryDAO.getAll();
    }

    //SP từng paaan trang
    public List<Product> getList(List<String> cates, List<String> brands, Double min, Double max, String selectedSort, int page) {
        int offset = (page - 1) * pageSize;
        return productDAO.getProductsByPage(cates, brands, min, max, selectedSort, offset, pageSize);
    }

    //So trang
    public int getTotalPages(List<String> cates, List<String> brands, Double min, Double max) {
        int totalItems = productDAO.countProducts(cates, brands, min, max);
        return (int) Math.ceil((double) totalItems / pageSize);
    }

    public static void main(String[] args) {
        ProductService productService = new ProductService();
        List<Product> productList = null;
        productList = productService.getList(null, null, null, null, "default", 1);
        System.out.println(productList);
    }


    public List<Banner> getListBanner() {
        return bannerDAO.getAll();

    }

    public List<Brand> getListBrands() {
        return brandDAO.getAll();

    }

    //lấy sp bằng id
    public Product getById(String pid) {
        Product p = productDAO.getById(pid);
        return p != null ? p : null;
    }

    public List<ProductSpec> getAllSpecByProductId(String productId){
        List<ProductSpec> specs = specDAO.getSpecsByProductId(productId);
        return specs != null ? specs : null;
    }

    public List<ProductVariant> getAllVariantByProductId(String productId) {
        List<ProductVariant> variants = variantDAO.getVariantsByProductId(productId);
        return variants != null ? variants : null;
    }

    public List<Image> getImageByProductId(String productId) {
        if (productId == null || productId.isEmpty()) return null;
        return galleryDAO.getImagesByProductId(productId);
    }

    public ProductVariant getVariantByImg(List<ProductVariant> list, String img)  {
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

    public List<Category> getCategory(int id) {
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


    //cập nhật lượt xem sản phẩm
    public void updateViewCount(String pid) {
        productDAO.updateViewCount(pid);
    }

}
