package service;

import dao.OrderDAO;
import dao.OrderShippingDAO;
import dao.ProfileMDAO.ProfileDAO;
import model.entity.*;

import java.sql.SQLException;
import java.util.List;

import dao.WishlistDAO;

public class ProfileService {
    private ProfileDAO pDAO = new ProfileDAO();
    private OrderDAO oDAO = new OrderDAO();
    private OrderShippingDAO osDAO = new OrderShippingDAO();
    private WishlistDAO wDAO = new WishlistDAO();
    public User getUserById(int userId) throws SQLException {
        return pDAO.getUserById(userId);
    }


    public String updateProfile(int userId, String fullName, String phone) throws SQLException {
        if (fullName == null || fullName.trim().isEmpty()) {
            return "Họ tên không được để trống.";
        }
        if (phone == null || phone.trim().isEmpty()) {
            return "Số điện thoại không được để trống.";
        }

        if (fullName.trim().length() < 2 || fullName.trim().length() > 50) {
            return "Họ tên phải từ 2 đến 50 ký tự.";
        }
        boolean isSuccess = pDAO.updateUserInfo(userId, fullName.trim(), phone.trim());

        return isSuccess ? "success" : "Cập nhật thất bại tại hệ thống.";
    }

    public String updateAvatar(int userId, String avatarUrl) throws SQLException {
        if (avatarUrl == null || avatarUrl.trim().isEmpty()) {
            return "Avatar URL không được để trống.";
        }
        boolean isSuccess = pDAO.updateAvatarUrl(userId, avatarUrl.trim());
        return isSuccess ? "success" : "Cập nhật avatar thất bại.";
    }

    public Order getOrderById(String orderId) {
        return oDAO.getOrderById(orderId);
    }

    public List<Order> getHistoryOrders(int userId) {
        return oDAO.getAllOrderById(userId);
    }

    public List<Order> getPendingOrders(int userId) {
        return oDAO.getPendingOrders(userId);
    }

    public List<Order> getShippingOrders(int userId) {
        return oDAO.getShippingOrders(userId);
    }

    public List<Order> getCompletedOrders(int userId) {
        return oDAO.getCompletedOrders(userId);
    }

    public List<Order> getCancelledOrders(int userId) {
        return oDAO.getCancelledOrders(userId);
    }

    public List<OrderItem> getAllOrdersItem(String orderId) {
        return oDAO.getAllOrdersItem(orderId);
    }

    public static void main(String[] args) {
        ProfileService dao = new ProfileService();
        //   System.out.println(dao.getAll().toString());
        System.out.println("--");
//        System.out.println(dao.getOrderById("1"));
        System.out.println(dao.getHistoryOrders(10).toString());
        System.out.println("-1-");
        System.out.println(dao.getCompletedOrders(10).toString());
        System.out.println("-2-");
        System.out.println(dao.getAllOrdersItem("4").toString());
    }

    public boolean toggleWishlist(int userId, int productId) {
        boolean isCurrentlyWished = wDAO.checkWishlist(userId, productId);
        if (isCurrentlyWished) {
            wDAO.removeWishlist(userId, productId);
            return false;
        } else {
            wDAO.addWishlist(userId, productId);
            return true;
        }
    }
    public List<Product> getWishlistByUser(int userId) {
        return wDAO.getWishlistByUser(userId);
    }

    public List<Integer> getWishlistProductIds(int userId) {
        return wDAO.getWishlistProductIds(userId);
    }

    public OrderShipping getOrderShipping(int orderId) {
        return osDAO.getByOrderId(orderId);
    }
}


