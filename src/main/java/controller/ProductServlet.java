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
import java.util.Arrays;
import java.util.List;

// sản phẩm all, theo phan loai cate, brand ban dau
@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    private ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String cateId = request.getParameter("cateId");
        String brandId = request.getParameter("brandId");

        int totalPage = 1;
        List<Product> productList = null;

        //Mặc định khi ko lọc theo brand/ cate
        if (cateId == null && brandId == null) {
            productList = productService.getList(null, null, null, null, null, 1);
            totalPage = productService.getTotalPages(null, null, null, null);
        } else if (cateId != null) {
            productList = productService.getList(List.of(cateId), null, null, null, null, 1);
            totalPage = productService.getTotalPages(List.of(cateId), null, null, null);
        } else {
            productList = productService.getList(null, List.of(brandId), null, null, null, 1);
            System.out.println(productList.toString());

            totalPage = productService.getTotalPages(null, List.of(brandId), null, null);
        }
        System.out.println(totalPage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("pageCurrent", 1);
        request.setAttribute("cateId", cateId);
        request.setAttribute("brandId", brandId);
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("/WEB-INF/views/headphones.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedBrands = request.getParameterValues("selectedBrands");
        String[] selectedCates = request.getParameterValues("selectedCates");
        String selectedSort = request.getParameter("selectedSort");
        String pageStr = request.getParameter("page");

        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        List<String> brandIds = (selectedBrands != null) ? Arrays.asList(selectedBrands) : null;
        List<String> cateIds = (selectedCates != null) ? Arrays.asList(selectedCates) : null;

        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;

        Double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : null;
        Double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : null;

        if (selectedSort == null || selectedSort.isEmpty()) {
            selectedSort = "default";
        }

        List<Product> productList = productService.getList(cateIds, brandIds, minPrice, maxPrice, selectedSort, page+1);
        int totalPage = productService.getTotalPages(cateIds, brandIds, minPrice, maxPrice);

        request.setAttribute("productList", productList);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("pageCurrent", page);
        request.getRequestDispatcher("/WEB-INF/views/_product_grid_ajax.jsp").forward(request, response);
    }
}