package service;

import dao.*;
import model.entity.*;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class AdminProductService {

    private ProductDAO  productDAO  = new ProductDAO();
    private VariantDAO  variantDAO  = new VariantDAO();
    private SpecDAO     specDAO     = new SpecDAO();
    private GalleryDAO  galleryDAO  = new GalleryDAO();
    private BrandDAO    brandDAO    = new BrandDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    public AdminProductService() throws SQLException, ClassNotFoundException {
    }

    public Map<Integer, Integer> getTotalStock() {
        return productDAO.getTotalStock();
    }

    public Map<Integer, Integer> getVarTotal() {
        return productDAO.getVarTotal();
    }

    public List<Product> getAllProduct() {
        return productDAO.getAllProduct();
    }

    public List<Product> getProductByCategoryId(String categoryId) {
        return productDAO.getProductsByPage(
                List.of(categoryId), null, null, null, null, 0, 10000);
    }

    public Product getProductById(String pid) {
        return productDAO.getById(pid);
    }

    public List<ProductVariant> getVariantsByProductId(String pid) {
        return variantDAO.getVariantsByProductId(pid);
    }

    public List<ProductSpec> getSpecsByProductId(String pid) {
        return specDAO.getSpecsByProductId(pid);
    }

    public List<Image> getImagesByProductId(String pid) {
        return galleryDAO.getImagesByProductId(pid);
    }

    public List<Brand> getAllBrands() {
        return brandDAO.getAll();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAll();
    }
    public boolean updateProduct(String pid, String brandId, String cateId,
                                 String name, String sku, String desc,
                                 String varSelected, String isActive) {
        return productDAO.updateProduct(
                pid, brandId, cateId, name, sku, desc, varSelected, isActive);
    }

    public boolean updateVariant(int vid, String colorName,
                                 BigDecimal marketPrice, BigDecimal sellPrice,
                                 int stock, String imageUrl) {
        return variantDAO.updateVariant(vid, colorName, marketPrice, sellPrice, stock, imageUrl);
    }

    public int addVariant(int pid, String colorName,
                          BigDecimal marketPrice, BigDecimal sellPrice,
                          int stock, String imageUrl) {
        return variantDAO.insertVariant(pid, colorName, marketPrice, sellPrice, stock, imageUrl);
    }

    public boolean deleteVariant(int vid) {
        return variantDAO.deleteVariant(vid);
    }

    public boolean updateSpecs(String[] ids, String[] values) {
        return productDAO.updateSpecs(ids, values);
    }

    public boolean addSpec(int pid, String name, String value) {
        return specDAO.insertSpec(pid, name, value);
    }

    public boolean deleteSpec(int sid) {
        return specDAO.deleteSpec(sid);
    }

    public boolean addGalleryImage(int pid, String imageUrl) {
        return galleryDAO.insertImage(pid, imageUrl);
    }

    public boolean deleteGalleryImage(int imgId) {
        return galleryDAO.deleteImage(imgId);
    }

    public boolean updateGalleryOrder(String[] imgIds, String[] orders) {
        return galleryDAO.updateOrder(imgIds, orders);
    }
}