package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.RedisUtility;

import java.io.IOException;

@WebServlet(name = "VerifyEmailServlet", value = "/verify-email")
public class VerifyEmailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String token = request.getParameter("token");
        String email = RedisUtility.getEmailByToken(token);

        if (email != null) {
            HttpSession session = request.getSession();
            session.setAttribute("verified_email", email);

            RedisUtility.deleteToken(token);

            response.sendRedirect("login?showRegisterPanel=true&status=verified");
        } else {
            response.getWriter().write("Liên kết không hợp lệ hoặc đã hết hạn.");
        }


    }


}