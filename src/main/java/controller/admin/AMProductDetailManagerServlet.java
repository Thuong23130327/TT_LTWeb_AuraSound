package controller.admin;

import dao.BrandDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.*;
import service.AdminProductService;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "AMProductDetailManagerServlet", value = "/admin/product-detail-manager")
public class AMProductDetailManagerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pid = request.getParameter("pid");

        if (pid == null || pid.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/product-manager");
            return;
        }

        try {
            AdminProductService service = new AdminProductService();

            Product product = service.getProductById(pid);
            if (product == null) {
                response.sendError(404, "Sản phẩm không tồn tại");
                return;
            }

            List<ProductVariant> variants = service.getVariantsByProductId(pid);
            List<ProductSpec>    specs    = service.getSpecsByProductId(pid);
            List<Image>          images   = service.getImagesByProductId(pid);

            List<Brand>    brandList = service.getAllBrands();
            List<Category> childList = service.getAllCategories()
                    .stream()
                    .filter(c -> c.getParentId() > 0)
                    .collect(Collectors.toList());

            request.setAttribute("p",         product);
            request.setAttribute("variants",  variants);
            request.setAttribute("specs",     specs);
            request.setAttribute("images",    images);
            request.setAttribute("brandList", brandList);
            request.setAttribute("childList", childList);

            request.getRequestDispatcher("/WEB-INF/views/admin/product_detail.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Lỗi: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}