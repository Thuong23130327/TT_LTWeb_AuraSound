package service;

import dao.OrderDAO;
import dao.ProfileMDAO.ProfileDAO;
import model.entity.Order;
import model.entity.OrderItem;
import model.entity.User;

import java.sql.SQLException;
import java.util.List;

public class ProfileService {
    private ProfileDAO pDAO = new ProfileDAO();
    private OrderDAO oDAO = new OrderDAO();

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

    public Order getOrderById(String orderId){
        return oDAO.getOrderById(orderId);
    }

    public List<Order> getHistoryOrders(int userId){
        return oDAO.getAllOrderById(userId);
    }

    public List<Order> getPendingOrders(int userId){
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

    public List<OrderItem> getAllOrdersItem(String orderId){
        return oDAO.getAllOrdersItem(orderId);
    }
}
