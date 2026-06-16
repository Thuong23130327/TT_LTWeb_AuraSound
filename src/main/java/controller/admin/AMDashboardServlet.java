package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Map;

@WebServlet(name = "AMDashboardServlet", value = "/admin/dashboard")
public class AMDashboardServlet extends HttpServlet {

//    private AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        model.entity.User currentUser = (model.entity.User) request.getSession().getAttribute("author");
        if (currentUser == null || !currentUser.hasPermission("can_report_view")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xem báo cáo.");
            return;
        }
        Map<String, Object> stats = service.AdminService.getDashboardStats();
        request.setAttribute("stats", stats);

        java.util.List<java.util.Map<String, Object>> recentNotis = service.NotificationService.getRecentNotifications();
        request.setAttribute("recentNotis", recentNotis);

        LocalDate now = LocalDate.now();
        request.setAttribute("currentMonth", now.getMonthValue());
        request.setAttribute("currentYear", now.getYear());

        request.getRequestDispatcher("/WEB-INF/views/admin/admin.jsp").forward(request, response);
    }
}
