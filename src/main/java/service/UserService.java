package service;

import dao.AdminDAO.UserDAO;
import model.entity.User;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class UserService {
    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    // băm mk sang md5
    private String hashPass(String password) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md5.digest(password.getBytes());
            BigInteger n = new BigInteger(1, messageDigest);
            String hashpassword = n.toString(16);
            while (hashpassword.length() < 32) {
                hashpassword = "0" + hashpassword;
            }
            return hashpassword;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    // check mail tồn tại
    public boolean checkExistMail(String email) {
        return UserDAO.checkExistMail(email);
    }

    // đăng ký
    public int register(String email, String password, String fullname) {
        if (checkExistMail(email)) {
            return 0; // 0: lỗi do email đã tồn tại
        }

        String passHash = hashPass(password);
        boolean success = userDAO.register(email, passHash, fullname);

        return success ? 1 : -1; // 1: tạo tài khoản thành công, -1: tạo tài khoản k thành công (do lỗi hệ thống/db)
    }

    //đăng nhập
    public User login(String email, String password) {
        String passHash = hashPass(password);
        return userDAO.checkLogin(email, passHash);
    }

    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }

    // all user
    public List<User> getAllUsers() {
        return userDAO.getAllUser();
    }

    public static void main(String[] args) {
        UserService dao = new UserService();
        System.out.println(dao.checkExistMail("admin@gmail.com"));
        System.out.println(dao.checkExistMail("24@gmail.com"));
        System.out.println(dao.register("24@gmail.com", "abcdef","Nguyen"));

    }
}