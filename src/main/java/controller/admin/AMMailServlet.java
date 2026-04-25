package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Contact;
import service.AdminMailService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AMMailServlet", value = "/admin/mail")
public class AMMailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminMailService adminMailService = new AdminMailService();
        List<Contact> allContacts = null;
        try {
            allContacts = adminMailService.getAllContacts();
            System.out.println(allContacts.size());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        List<String> statusList = new ArrayList<>() {{
            add("Mới nhất");
            add("Cũ nhất");
            add("Chưa phản hồi");
            add("Đã phản hổi");
        }};
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        request.setAttribute("statusList", statusList);
        request.setAttribute("allContacts", allContacts);
        request.getRequestDispatcher("/WEB-INF/views/admin/mailBox.jsp").forward(request, response);
    }

}