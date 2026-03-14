package service;

import dao.ProductDAO;
import model.entity.Product;

import java.sql.SQLException;
import java.util.List;

public class ProductService {
    private ProductDAO productDao;

    public ProductService() throws SQLException, ClassNotFoundException {
        productDao = new ProductDAO();
    }

    public List<Product> searchProductByText(String textSearch) {
        return productDao.searchProductByText(textSearch);
    }

    public int pageNeed(String cateId, int sizePerPage) {
        return productDao.pageNeed(cateId, sizePerPage);
    }

    public List<Product> filterProduct(String[] brandIds, String[] cateIds, int numPerPage, int page, String selectedSort) {
        if (selectedSort == null) selectedSort = "default";
        return productDao.filterProduct(brandIds, cateIds, numPerPage, page, selectedSort);
    }

    public List<Product> getPerPageProduct(int numPerPage, int page, String cId, String selectedSort) {
        if (cId != null) {
            return productDao.getPerPageProductByCategoryId(numPerPage, page, cId, selectedSort);
        }
        return productDao.getPerPageAllProduct(numPerPage, page, selectedSort);
    }

    public List<Product> getAllProduct() {
        return productDao.getAllProduct();
    }


    public List<Product> getProductByCategoryId(String cateId) {
        return productDao.getProductByCategoryId(cateId);
    }

    public Product getById(String pid) {
        Product p = productDao.getById(pid);
        return p != null ? p : null;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        ProductService ps = new ProductService();
        System.out.println(ps.getAllProduct().toString());
    }

    public boolean deleteProduct(String pid) {
        return productDao.deleteProduct(pid);
    }

    public int totalProduct(String[] selectedBrands, String[] selectedCates) {
        return productDao.filterProduct(selectedBrands, selectedCates, 0, 0, null).size();
    }

    public int addNewProduct(Product p) {return productDao.addProduct(p);}

    public void updateSearchCount(String pid) {
        productDao.updateSearchCount(pid);
    }

    public void updateViewCount(String pid) {
        productDao.updateViewCount(pid);
    }
}
