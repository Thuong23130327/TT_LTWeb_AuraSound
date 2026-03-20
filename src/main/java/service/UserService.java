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
    public boolean isEmailExists(String email) {
        return UserDAO.checkExistMail(email);
    }

    // đăng ký
    public boolean register(String email, String password, String fullname) {
        if (isEmailExists(email)) {
            return false;
        }
        String passHash = hashMD5(password);
        return userDAO.register(email, passHash, fullname);
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