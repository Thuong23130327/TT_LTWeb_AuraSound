package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.AdminDAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.IconLogin.FacebookConfig;
import model.dto.FacebookAccount;
import model.entity.Role;
import model.entity.User;
import org.apache.http.client.fluent.Request;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "FacebookLoginServlet", value = "/login-facebook")
public class FacebookLoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            String redirectUrl = "https://www.facebook.com/v19.0/dialog/oauth?"
                    + "client_id=" + FacebookConfig.FACEBOOK_APP_ID
                    + "&redirect_uri=" + FacebookConfig.FACEBOOK_REDIRECT_URL
                    + "&scope=email,public_profile";

            response.sendRedirect(redirectUrl);
            return;
        }

        String accessToken = getToken(code);
        FacebookAccount fbAccount = getFbUserInfo(accessToken);
        handleLoginWithDatabase(fbAccount, request, response);
    }

    private void handleLoginWithDatabase(FacebookAccount fbAccount, HttpServletRequest request, HttpServletResponse response) throws IOException {
        UserDAO userDao = new UserDAO();

        User user = userDao.getUserByEmail(fbAccount.getEmail());

        if (user == null) {
            user = new User();
            user.setEmail(fbAccount.getEmail());
            user.setFullName(fbAccount.getName());
            user.setPasswordHash("");
            user.setLocked(false);
            user.setAvatarUrl("https://graph.facebook.com/" + fbAccount.getId() + "/picture?type=large");

            int newUserId = userDao.insertUser(user);
            user.setId(newUserId);

            userDao.assignRole(newUserId, 2);
        }

        if (user.isLocked()) {
            response.sendRedirect(request.getContextPath() + "/login?error=account_locked");
            return;
        }

        List<Role> roles = userDao.getRolesByUserId(user.getId());
        user.setRoles(roles);
        System.out.println("DEBUG: User sau khi xử lý DB: " + user);

        if (user != null) {
            request.getSession().setAttribute("LOGIN_USER", user);
            System.out.println("DEBUG: Đã lưu User vào Session thành công!");
        } else {
            System.out.println("DEBUG: User bị NULL rồi Thương ơi!");
        }

        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }

    private String getToken(String code) throws IOException {
        String link = String.format(FacebookConfig.FACEBOOK_LINK_GET_TOKEN,
                FacebookConfig.FACEBOOK_APP_ID, FacebookConfig.FACEBOOK_APP_SECRET,
                FacebookConfig.FACEBOOK_REDIRECT_URL, code);

        String response = Request.Get(link).execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    private FacebookAccount getFbUserInfo(String accessToken) throws IOException {
        String link = String.format(FacebookConfig.FACEBOOK_LINK_GET_USER_INFO, accessToken);
        String response = Request.Get(link).execute().returnContent().asString();
        return new Gson().fromJson(response, FacebookAccount.class);
    }
}