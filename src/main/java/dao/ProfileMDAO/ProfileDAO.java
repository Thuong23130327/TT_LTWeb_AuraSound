package dao.ProfileMDAO;

import model.entity.User;
import org.jdbi.v3.core.Jdbi;

public class ProfileDAO {

    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    //lấy thông tin User theo ID
    public User getUserById(int userId) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM users WHERE id = :id")
                        .bind("id", userId)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    //cập nhật thông tin cá nhân theo id
    public boolean updateUserInfo(int userId, String fullName, String phone) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("UPDATE users SET full_name = :name, phone = :phone WHERE id = :id")
                        .bind("name", fullName)
                        .bind("phone", phone)
                        .bind("id", userId)
                        .execute() > 0
        );
    }
}
