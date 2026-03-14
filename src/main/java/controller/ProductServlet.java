package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.entity.Category;
import service.CategoryService;
import service.ProductService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

// sản phẩm all, theo phan loai cate, brand ban dau
@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int numPerPage = 12;
        CategoryService categoryService = new CategoryService();
        ProductService productService = null;
        String selectedSort = request.getParameter("selectedSort") != null ? request.getParameter("selectedSort") : "default";

        try {
            productService = new ProductService();
            String cateId = request.getParameter("cateId");
            int numPage = productService.pageNeed(cateId, numPerPage);
            List<model.entity.Product> productList = null;
            if (cateId != null && !cateId.equals("0")) {
                Category c = categoryService.getCategoryById(Integer.parseInt(cateId));
                request.setAttribute("cateName", c.getName());
            }

            productList = productService.getPerPageProduct(numPerPage, 1, cateId, selectedSort);
            request.setAttribute("numPage", numPage);
            request.setAttribute("pageCurrent", 1);
            request.setAttribute("cateId", cateId);
            request.setAttribute("productList", productList);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        request.getRequestDispatcher("/WEB-INF/view/headphones.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/headphones.jsp").forward(request, response);
    }
}