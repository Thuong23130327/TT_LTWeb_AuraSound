package service;
import dao.NotificationDAO;

public class NotificationService {
    public static void addNotification(String type, String message) {
        NotificationDAO.insert(type, message);
    }

    public static java.util.List<java.util.Map<String, Object>> getRecentNotifications() {
        return NotificationDAO.getRecentNotifications();
    }
}