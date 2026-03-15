package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.entity.Category;
import service.ProductService;

import java.io.IOException;

import java.sql.SQLException;
import java.util.List;

// sản phẩm all, theo phan loai cate, brand ban dau
@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService productService = new ProductService();
        String selectedSort = request.getParameter("selectedSort") != null ? request.getParameter("selectedSort") : "default";

        String cateId = request.getParameter("cateId");
        List<model.entity.Product> productList = null;


        productList = productService.getList(null, null, null, null, selectedSort, 1);
        request.setAttribute("pageCurrent", 1);
        request.setAttribute("cateId", cateId);
        request.setAttribute("productList", productList);
//
        request.getRequestDispatcher("/WEB-INF/views/headphones.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/headphones.jsp").forward(request, response);
    }
}