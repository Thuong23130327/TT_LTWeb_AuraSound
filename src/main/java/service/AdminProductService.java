package service;

import dao.ProductDAO;
import model.entity.Product;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class AdminProductService {
    private ProductDAO productDAO;

    public AdminProductService() throws SQLException, ClassNotFoundException{
         productDAO = new ProductDAO();
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
        return productDAO.getProductsByPage(List.of(categoryId), null, null, null, null, 0, 10000);
    }
}