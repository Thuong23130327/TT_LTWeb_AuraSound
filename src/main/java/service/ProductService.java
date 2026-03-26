package service;

import dao.*;
import model.entity.Banner;
import model.entity.Brand;
import model.entity.Category;
import model.entity.Product;

import java.sql.SQLException;
import java.util.List;

public class ProductService {
    private ProductDAO productDAO = new ProductDAO();
    private VariantDAO variantDAO = new VariantDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private BrandDAO brandDAO = new BrandDAO();
    BannerDAO bannerDAO = new BannerDAO();
    private int pageSize = 12;

    public List<Brand> getAllBrands() {
        return brandDAO.getAll();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAll();
    }

    public List<Product> getList(List<String> cates, List<String> brands, Double min, Double max, String selectedSort, int page) {
        int offset = (page - 1) * pageSize;
        return productDAO.getProductsByPage(cates, brands, min, max, selectedSort, offset, pageSize);
    }

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

    //cập nhật lượt xem sản phẩm
    public void updateViewCount(String pid) {
        productDAO.updateViewCount(pid);
    }

}
