package service;

import dao.AdminDAO.UserDAO;
import model.dto.LoginResult;
import model.entity.User;
import util.HashUtils;
import java.util.List;

public class UserService {
    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }

    // all user
    public List<User> getAllUsers() {
        return userDAO.getAllUser();
    }

    // check mail tồn tại - Login
    public boolean checkExistMail(String email) {
        return UserDAO.checkExistMail(email);
    }

    // đăng ký
    public int register(String email, String password, String fullname) {
        if (checkExistMail(email)) {
            return 0; // 0: lỗi do email đã tồn tại
        }
        String passHash = HashUtils.hashPass(password);
        boolean success = userDAO.register(email, passHash, fullname);
        return success ? 1 : -1; // 1: tạo tài khoản thành công, -1: tạo tài khoản k thành công (do lỗi hệ thống/db)
    }

    //đăng nhập
    public LoginResult checkLogin(String email, String password) {
        String genericError = "Email hoặc mật khẩu không chính xác.";
        String policyNote = " Tài khoản sẽ bị khóa nếu nhập sai quá 5 lần.";

        User user = userDAO.getUserByEmail(email);

        //TH1: email k tồn tại
        if (user == null)
            return new LoginResult( genericError, 0, false);
        //TH2: tk bị khóa
        if (user.isLocked())
            return new LoginResult("Tài khoản này hiện đang bị khóa. Hãy liên hệ Admin để mở lại.", 0, true);

        //TH3: check pass
        String hashInput = HashUtils.hashPass(password.trim());
        if (!user.getPasswordHash().equals(hashInput)) {
            userDAO.incrementFailedAttempts(email);
            int failedCount = user.getFailedAttempts() + 1;

            if (failedCount >= 5) {
                userDAO.lockAccount(email);
                return new LoginResult("Bạn đã nhập sai 5 lần. Tài khoản đã bị khóa.", 0, true);
            }
            return new LoginResult(genericError + policyNote, 5 - failedCount, false);
        }

        // Thành công: Reset và trả về user
        userDAO.resetFailedAttempts(email);
        System.out.println(user.getMergedPermissions().toString() + "-"+user.getRoles().toString());
        return new LoginResult(user);
    }

    public static void main(String[] args) {
        UserService dao = new UserService();
        System.out.println(dao.checkExistMail("admin@gmail.com"));
        System.out.println(dao.checkExistMail("24@gmail.com"));
        System.out.println(dao.register("24@gmail.com", "abcdef","Nguyen"));

    }
}