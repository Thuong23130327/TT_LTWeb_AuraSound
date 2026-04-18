package service;

import dao.AdminDAO.PasswordResetTokenDAO;
import dao.AdminDAO.UserDAO;
import model.entity.PasswordResetToken;
import java.time.LocalDateTime;
import java.util.UUID;

public class PasswordService {
    private PasswordResetTokenDAO tokenDAO = new PasswordResetTokenDAO();
    private UserDAO userDAO = new UserDAO();

    // Sinh Token, set Timeout 15 phút và gửi Mail
    public boolean processForgotPassword(String email, String baseUrl) {
       if(!userDAO.checkExistMail(email)) return false;

        String token = UUID.randomUUID().toString();
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(10);

        if (tokenDAO.insertToken(email, token, expiry)) {
            String resetLink = baseUrl + "?token=" + token;
            return EmailService.sendResetEmail(email, resetLink);
        }
        return false;
    }

    // Validate Token ktra tồn tại và còn hạn không
    public boolean isTokenValid(String token) {
        PasswordResetToken prt = tokenDAO.getToken(token);
        return prt != null && prt.getExpiryDate().isAfter(LocalDateTime.now());
    }

    // Đổi mật khẩu & hiệu hóa Token
    public boolean resetPassword(String token, String newPassword) {
        PasswordResetToken prt = tokenDAO.getToken(token);
        if (prt != null && prt.getExpiryDate().isAfter(LocalDateTime.now())) {
            String hashedPass = newPassword;
            if (userDAO.updatePassword(prt.getEmail(), hashedPass)) {
                tokenDAO.deleteToken(token);
                return true;
            }
        }
        return false;
    }
}