package dao.AdminDAO;

import model.entity.User;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class UserDAO {
    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    // kiểm tra email có tồn tại k
    public static boolean checkExistMail(String email) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT COUNT(id) FROM users WHERE email = :email")
                        .bind("email", email)
                        .mapTo(Integer.class)
                        .findOnly() > 0
        );
    }

    // ktra đăng nhập
    public User checkLogin(String email, String passHash) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Users WHERE email = :email AND password_hash = :pass")
                        .bind("email", email)
                        .bind("pass", passHash)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    // đăng ký tài khoản
    public boolean register(String email, String passHash, String fullname) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO Users (email, password_hash, full_name) VALUES (:email, :pass, :name)")
                        .bind("email", email)
                        .bind("pass", passHash)
                        .bind("name", fullname)
                        .execute() > 0
        );
    }

    // lấy tất cả user
    public List<User> getAllUser() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Users")
                        .mapToBean(User.class)
                        .list()
        );
    }

    // tìm user bằng id
    public User getUserById(String id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Users WHERE id = :id")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    //tìm user bằng email
    public User getUserByEmail(String email) {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT * FROM Users WHERE email = :email")
                        .bind("email", email)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        System.out.println(dao.getAllUser().toString());
    }

}

