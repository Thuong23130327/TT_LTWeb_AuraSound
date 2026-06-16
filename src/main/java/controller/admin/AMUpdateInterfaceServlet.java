package controller.admin;

import service.InterfaceService;
import service.CloudinaryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.google.gson.Gson;
@WebServlet(name = "AMUpdateInterfaceServlet", value = "/admin/upd-interface")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 20
)
public class AMUpdateInterfaceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        InterfaceService service = new InterfaceService();

        try {
            if ("addBanner".equals(action)) {
                Part filePart = request.getPart("imageFile");
                String imageUrl = CloudinaryService.uploadFile(filePart);

                if (imageUrl != null) {
                    service.addBanner(
                        imageUrl, 
                        request.getParameter("targetUrl"),
                        request.getParameter("title"),
                        request.getParameter("description"),
                        Integer.parseInt(request.getParameter("sortOrder"))
                    );
                }
            } else if ("deleteBanner".equals(action)) {
                boolean success = service.deleteBanner(Integer.parseInt(request.getParameter("id")));
                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson(success));
                return;

            } else if ("toggleBanner".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean currentStatus = Boolean.parseBoolean(request.getParameter("status"));
                boolean success = service.toggleBannerStatus(id, currentStatus);
                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson(success));
                return;

            } else if ("updateBanner".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String desc = request.getParameter("description");
                String url = request.getParameter("targetUrl");
                int sort = Integer.parseInt(request.getParameter("sortOrder"));
                boolean success = service.updateBanner(id, title, desc, url, sort);
                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson(success));
                return;
            }
            else if ("addBrand".equals(action)) {
                Part filePart = request.getPart("imageFile");
                String logoUrl = CloudinaryService.uploadFile(filePart);

                if (logoUrl != null) {
                    service.addBrand(request.getParameter("name"), logoUrl);
                }
            } else if ("deleteBrand".equals(action)) {
                service.deleteBrand(Integer.parseInt(request.getParameter("id")));
            }
            else if ("addFooter".equals(action)) {
                service.addFooter(request.getParameter("title"), request.getParameter("targetUrl"), Integer.parseInt(request.getParameter("sortOrder")));
                request.getServletContext().setAttribute("footerLinks", service.getAllFooterLinks());
            } else if ("deleteFooter".equals(action)) {
                service.deleteFooter(Integer.parseInt(request.getParameter("id")));
                request.getServletContext().setAttribute("footerLinks", service.getAllFooterLinks());
            }
            else if ("addCategory".equals(action)) {
                String parentIdStr = request.getParameter("parentId");
                Integer parentId = (parentIdStr == null || parentIdStr.isEmpty()) ? null : Integer.parseInt(parentIdStr);
                service.addCategory(request.getParameter("name"), parentId);
            } else if ("deleteCategory".equals(action)) {
                service.deleteCategory(Integer.parseInt(request.getParameter("id")));
            } else if ("reorderBanners".equals(action)) {
            String[] ids = request.getParameterValues("ids[]");
            if (ids != null) {
                service.reorderBanners(ids);
                response.setContentType("application/json");
                response.getWriter().write(new Gson().toJson(true));
                return;
            }
        }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/interface-manager");
    }
}