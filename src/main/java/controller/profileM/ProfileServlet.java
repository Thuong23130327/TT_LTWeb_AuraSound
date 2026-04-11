package controller.profileM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.User;
import service.ProfileService;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {

    private ProfileService profileService = new ProfileService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("auth") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            User userDetail = profileService.getUserById(user.getId());
            request.setAttribute("userDetail", userDetail);
            request.getRequestDispatcher("/WEB-INF/views/profileM/profile.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("auth");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        try {
            String result = profileService.updateProfile(user.getId(), fullName, phone);

            if ("success".equals(result)) {
                user.setFullName(fullName);
                user.setPhone(phone);
                session.setAttribute("auth", user);
                System.out.println("FULLNAME NHAN DUOC: " + request.getParameter("fullName"));

                request.setAttribute("message", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("error", result);
            }

            doGet(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu.");
            doGet(request, response);
        }
    }
}
