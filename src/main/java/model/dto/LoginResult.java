package model.dto;

import model.entity.User;

public class LoginResult {
    private User user;
    private String message;
    private int attemptsLeft;
    private boolean isLocked;

    //đăng nhập thành công
    public LoginResult(User user) {
        this.user = user;
    }

    //đăng nhập thất bại
    public LoginResult(String message, int attemptsLeft, boolean isLocked) {
        this.message = message;
        this.attemptsLeft = attemptsLeft;
        this.isLocked = isLocked;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getAttemptsLeft() {
        return attemptsLeft;
    }

    public void setAttemptsLeft(int attemptsLeft) {
        this.attemptsLeft = attemptsLeft;
    }

    public boolean isLocked() {
        return isLocked;
    }

    public void setLocked(boolean isLocked) {
        this.isLocked = isLocked;
    }
}
