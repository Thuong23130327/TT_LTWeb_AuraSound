package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.Contact;
import service.AdminMailService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AMMailDetailServlet", value = "/admin/mail_detail")
public class AMMailDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminMailService adminMailService = new AdminMailService();
        String id = request.getParameter("id");
        Contact contact = null;
        try {
            contact = adminMailService.getContact(id);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        List<String> statusList = new ArrayList<>() {{
            add("All");
            add("Mới");
            add("Chưa phản hồi");
            add("Đã phản hổi");
        }};
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setAttribute("statusList", statusList);
        request.setAttribute("contact", contact);
        request.getRequestDispatcher("/WEB-INF/views/admin/responseMail.jsp").forward(request, response);

    }

}