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
        String successMsg = (String) session.getAttribute("successMessage");
        if (successMsg != null) {
            request.setAttribute("successMessage", successMsg);
            session.removeAttribute("successMessage");
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
            session.setAttribute("successMessage", "AuraSound đã nhận được thành công. Xin cảm ơn quý khách!");

            response.sendRedirect(request.getContextPath() + "/contact");
        } else {
            request.setAttribute("errorMessage", "Lỗi hệ thống hoặc nội dung trống. Vui lòng thử lại!");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("message", message);
            request.getRequestDispatcher("/WEB-INF/views/contact.jsp").forward(request, response);
        }
    }
}