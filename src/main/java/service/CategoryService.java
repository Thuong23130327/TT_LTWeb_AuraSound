package service;

import dao.CategoryDAO;
import model.entity.Category;

import java.sql.SQLException;
import java.util.List;

public class CategoryService {
    private CategoryDAO categoryDAO;

    public CategoryService() throws SQLException, ClassNotFoundException {
        this.categoryDAO = new CategoryDAO();
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAll();
    }
}