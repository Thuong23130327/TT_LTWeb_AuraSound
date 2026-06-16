package controller.admin;

import service.InterfaceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "AMInterfaceServlet", value = "/admin/interface-manager")
public class AMInterfaceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InterfaceService service = new InterfaceService();
        request.setAttribute("activePage", "ui");
        request.setAttribute("banners", service.getAllBanners());
        request.setAttribute("footers", service.getAllFooterLinks());
        request.setAttribute("brands", service.getAllBrands());
        request.setAttribute("categories", service.getAllCategories());

        request.getRequestDispatcher("/WEB-INF/views/admin/interface_manager.jsp").forward(request, response);
    }
}