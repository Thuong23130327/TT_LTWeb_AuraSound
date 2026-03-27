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

        try {
            ProductDetailService productDetailService = new ProductDetailService();
            ProductService productService = new ProductService();
            Product product = productService.getById(pid);
            productService.updateViewCount(pid);
            if (product == null) {
                response.sendError(404, "Sản phẩm không tồn tại!");
                return;
            }

            List<ProductSpec> specs = productDetailService.getAllSpecByProductId(pid);
            List<ProductVariant> variants = productDetailService.getAllVariantByProductId(pid);
            List<Image> imgs = productDetailService.getImageByProductId(pid);
            ProductVariant curVariant = productDetailService.getVariantByImg(variants, product.getImg());
            List<Category> categories = productDetailService.getCategory(product.getCategoriesId());

            request.setAttribute("product", product);
            request.setAttribute("variants", variants);
            request.setAttribute("specs", specs);
            request.setAttribute("images", imgs);
            request.setAttribute("curVariant", curVariant);
            request.setAttribute("categories", categories);


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        request.getRequestDispatcher("/WEB-INF/views/productdetail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        doGet(request, response);
    }
}