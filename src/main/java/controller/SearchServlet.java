package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.Product;
import service.ProductService;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "SearchServlet", value = "/search")
public class SearchServlet extends HttpServlet {

    private ProductService productService = new ProductService();
    private static final int AJAX_LIMIT = 15;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("search");
        String ajax = request.getParameter("ajax");

        if (keyword == null || keyword.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }

        keyword = keyword.trim();

        if ("true".equals(ajax)) {
            List<Product> results = productService.searchProducts(keyword, AJAX_LIMIT);

            Map<String, Object> jsonMap = new HashMap<>();
            jsonMap.put("products", results);
            jsonMap.put("keyword", keyword);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(jsonMap));

        } else {
            List<Product> productList = productService.searchProducts(keyword, AJAX_LIMIT);

            request.setAttribute("productList", productList);
            request.setAttribute("search", keyword);
            request.setAttribute("activePage", "product");
            request.setAttribute("totalPage", 1);
            request.setAttribute("pageCurrent", 1);

            request.getRequestDispatcher("/WEB-INF/views/headphones.jsp")
                    .forward(request, response);
        }
    }
}
