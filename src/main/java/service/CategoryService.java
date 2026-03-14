package service;

import java.sql.SQLException;
import java.util.List;

import dao.CategoryDAO;
import model.entity.Category;

public class CategoryService {
        CategoryDAO categoryDao = new CategoryDAO();

        public List<Category> getAllCategories() throws SQLException, ClassNotFoundException {
            return categoryDao.getAllCategories();
        }

        public Category getCategoryById(int cateId) throws SQLException, ClassNotFoundException {
            List<Category> categoryList = categoryDao.getAllCategories();
            for (Category category : categoryList) {
                if (category.getId() == cateId) return category;
            }
            return null;

        }

        public boolean isParent(Category c) {
            return c.getParentID() == 0;
        }

        public static void main(String[] args) throws SQLException, ClassNotFoundException {
            service.CategoryService categoryService = new service.CategoryService();
            System.out.println(categoryService.getAllCategories());
        }

    }


