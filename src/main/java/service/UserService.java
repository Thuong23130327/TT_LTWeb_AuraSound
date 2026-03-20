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
    private String hashMD5(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(password.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
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
            return 0; // 0: Lỗi do email tồn tại
        }

        String passHash = hashMD5(password);
        boolean success = userDAO.register(email, passHash, fullname);

        return success ? 1 : -1; // 1: Thành công, -1: Lỗi hệ thống/Database
    }

    //đăng nhập
    public User login(String email, String password) {
        String passHash = hashMD5(password);
        return userDAO.checkLogin(email, passHash);
    }

    // all user
    public List<User> getAllUsers() {
        return userDAO.getAllUser();
    }
}