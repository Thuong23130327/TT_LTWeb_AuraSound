package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;
import model.Product;
import service.AdminProductService;
import service.CategoryService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AMProductServlet", value = "/admin/product-manager")
public class AMProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryId = request.getParameter("categoryId");

        AdminProductService adminProductService = null;
        try {
            adminProductService = new AdminProductService();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        List<Product> productList = new ArrayList<>();
        Map<Integer, Integer> stockMap = adminProductService.getTotalStock();
        Map<Integer, Integer> varCountMap = adminProductService.getVarTotal();

        if (categoryId != null && !categoryId.isEmpty()) {
            productList = adminProductService.getProductByCategoryId(categoryId);
        } else {
            productList = adminProductService.getAllProduct();
        }
        CategoryService categoryService = null;
        List<Category> categoryList = new ArrayList<>();
        try {
            categoryService = new CategoryService();
            categoryList = categoryService.getAllCategories();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.setAttribute("activeId", categoryId);
        request.setAttribute("productList", productList);
        request.setAttribute("totalStockMap", stockMap);
        request.setAttribute("varCountMap", varCountMap);
        request.setAttribute("listOption", categoryList);
        request.getRequestDispatcher("/WEB-INF/views/admin/products.jsp").forward(request, response);

    }
}
