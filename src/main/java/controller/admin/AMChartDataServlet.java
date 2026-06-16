package controller.admin;

import com.google.gson.Gson;
import dao.AdminDAO.AdminDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/api/chart")
public class AMChartDataServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String filter = req.getParameter("filter");
        if (filter == null) filter = "7days";

        Map<String, Object> chartData = AdminDAO.getChartData(filter);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new Gson().toJson(chartData));
    }
}