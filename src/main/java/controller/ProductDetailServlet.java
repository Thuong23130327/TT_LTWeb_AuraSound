package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.*;
import service.ProductDetailService;
import service.ProductService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ProductDetailServlet", value = "/detail")
public class ProductDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pid = request.getParameter("pid");
        if (pid == null) {
            response.sendRedirect("home"); // Hoặc trang lỗi
            return;
        }
        ProductService productService = new ProductService();
        productService.updateViewCount(pid);

            Product product = productService.getById(pid);
            if (product == null) {
                response.sendError(404, "Sản phẩm không tồn tại!");
                return;
            }

            List<ProductSpec> specs = productService.getAllSpecByProductId(pid);
            List<ProductVariant> variants = productService.getAllVariantByProductId(pid);
            List<Image> imgs = productService.getImageByProductId(pid);
            ProductVariant curVariant = productService.getVariantByImg(variants, product.getImg());
            List<Category> categories = productService.getCategory(product.getCategoriesId());

            request.setAttribute("product", product);
            request.setAttribute("variants", variants);
            request.setAttribute("specs", specs);
            request.setAttribute("images", imgs);
            request.setAttribute("curVariant", curVariant);
            request.setAttribute("categories", categories);


        request.getRequestDispatcher("/WEB-INF/views/productdetail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}