package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.entity.Category;
import model.entity.Product;
import service.ProductService;

import java.io.IOException;

import java.sql.SQLException;
import java.util.List;

// sản phẩm all, theo phan loai cate, brand ban dau
@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService productService = new ProductService();

        String cateId = request.getParameter("cateId");
        String brandId = request.getParameter("brandId");
        int totalPage = 1;
        List<Product> productList = null;

        //Mặc định khi ko lọc theo brand/ cate
        if (cateId == null || brandId == null) {
            productList = productService.getList(null, null, null, null, null, 1);
            totalPage = productService.getTotalPages(null, null, null, null);
        } else if (cateId != null) {
            productList = productService.getList(List.of(cateId), null, null, null, null, 1);
            totalPage = productService.getTotalPages(List.of(cateId), null, null, null);
        } else {
            productList = productService.getList(null, List.of(brandId), null, null, null, 1);
            totalPage = productService.getTotalPages(null, List.of(brandId), null, null);
        }

        request.setAttribute("totalPage", totalPage);
        request.setAttribute("pageCurrent", 1);
        request.setAttribute("cateId", cateId);
        request.setAttribute("brandId", brandId);
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/WEB-INF/views/headphones.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedSort = request.getParameter("selectedSort") != null ? request.getParameter("selectedSort") : "default";

    }
}