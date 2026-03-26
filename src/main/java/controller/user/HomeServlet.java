package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.Banner;
import model.entity.Brand;
import model.entity.Product;
import service.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductService service = new ProductService();
        List<Banner> bannerList = service.getListBanner();

        List<Brand> brandList = service.getListBrands();

        List<Product> featuredProducts = service.getList(null, null, null, null, null, 1);
        request.setAttribute("bannerList", bannerList);
        request.setAttribute("brandList", brandList);
//        System.out.println(bannerList + " " + brandList);
        request.setAttribute("featuredProducts", featuredProducts);
        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}