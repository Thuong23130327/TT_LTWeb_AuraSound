package controller.profileM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.entity.User;
import service.ProfileService;
import util.ImageUploadUtil;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ProfileServlet", value = "/profile")
@MultipartConfig(
    maxFileSize = 5 * 1024 * 1024,    
    maxRequestSize = 10 * 1024 * 1024   
)
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
        String message = "";
        String error = "";

        try {
            Part avatarPart = request.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String oldAvatarUrl = user.getAvatarUrl();
                
                String uploadBasePath = request.getServletContext().getRealPath("/");
                String newAvatarUrl = ImageUploadUtil.uploadAvatar(avatarPart, uploadBasePath);
                
                if (newAvatarUrl != null) {
                    String result = profileService.updateAvatar(user.getId(), newAvatarUrl);
                    if ("success".equals(result)) {
    
                        ImageUploadUtil.deleteOldAvatar(oldAvatarUrl, uploadBasePath);
                        
                        user.setAvatarUrl(newAvatarUrl);
                        message = message.isEmpty() ? "Avatar đã được cập nhật thành công!" : message + " Avatar cập nhật thành công!";
                    } else {
                        error = "Lỗi cập nhật avatar: " + result;
                    }
                } else {
                    error = "Tệp tải lên không hợp lệ. Vui lòng kiểm tra kích thước và định dạng tệp.";
                }
            }


            if (fullName != null || phone != null) {
                String result = profileService.updateProfile(user.getId(), fullName, phone);

                if ("success".equals(result)) {
                    user.setFullName(fullName);
                    user.setPhone(phone);
                    message = message.isEmpty() ? "Cập nhật thông tin thành công!" : message + " Thông tin cá nhân cập nhật thành công!";
                } else {
                    if (error.isEmpty()) {
                        error = result;
                    } else {
                        error = error + " " + result;
                    }
                }
            }

            session.setAttribute("auth", user);

            if (!error.isEmpty()) {
                request.setAttribute("error", error);
            }
            if (!message.isEmpty()) {
                request.setAttribute("message", message);
            }

            System.out.println("FULLNAME NHAN DUOC: " + fullName);
            doGet(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu.");
            doGet(request, response);
        }
    }
}
