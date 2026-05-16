package dao.AdminDAO;

import model.entity.PasswordResetToken;
import org.jdbi.v3.core.Jdbi;
import java.time.LocalDateTime;

public class PasswordResetTokenDAO {
    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

//    Token mới
    public boolean insertToken(String email, String token, LocalDateTime expiryDate) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO password_reset_tokens (email, token, expiry_date) VALUES (:email, :token, :expiryDate)")
                        .bind("email", email)
                        .bind("token", token)
                        .bind("expiryDate", expiryDate)
                        .execute() > 0
        );
    }

//    Lấy token xác thực
    public PasswordResetToken getToken(String token) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM password_reset_tokens WHERE token = :token")
                        .bind("token", token)
                        .mapToBean(PasswordResetToken.class)
                        .findFirst()
                        .orElse(null)
        );
    }

//    Xóa token sau khi dùng
    public void deleteToken(String token) {
        jdbi.useHandle(handle ->
                handle.createUpdate("DELETE FROM password_reset_tokens WHERE token = :token")
                        .bind("token", token)
                        .execute()
        );
    }
}