package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Contact;
import model.entity.User;
import model.entity.User;
import service.ContactService;

import java.io.IOException;

@WebServlet(name = "ContactServlet", value = "/contact")
public class ContactServlet extends HttpServlet {

    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("activePage", "contact");
        HttpSession session = request.getSession();
        if (session.getAttribute("successMessage") != null) {
            request.setAttribute("successMessage", session.getAttribute("successMessage"));
            session.removeAttribute("successMessage");
        }
        if (session.getAttribute("errorMessage") != null) {
            request.setAttribute("errorMessage", session.getAttribute("errorMessage"));
            session.removeAttribute("errorMessage");
        }

        if (session.getAttribute("old_name") != null) {
            request.setAttribute("name", session.getAttribute("old_name"));
            session.removeAttribute("old_name");
        }

        request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("activePage", "contact");

        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");
        boolean sendSuccess = contactService.sendContactMail(email, name, phone, message, user);

        if (sendSuccess) {
            session.setAttribute("successMessage", "AuraSound đã nhận được lời nhắn. Xin cảm ơn quý khách!");
            response.sendRedirect(request.getContextPath() + "/contact");
        } else {
            session.setAttribute("errorMessage", "Không thể gửi tin nhắn. Vui lòng kiểm tra lại thông tin!");

            session.setAttribute("old_name", name);
            session.setAttribute("old_email", email);
            session.setAttribute("old_phone", phone);
            session.setAttribute("old_message", message);

            response.sendRedirect(request.getContextPath() + "/contact");
        }
    }
}