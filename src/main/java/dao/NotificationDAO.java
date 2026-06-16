package dao;
import org.jdbi.v3.core.Jdbi;

public class NotificationDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public static void insert(String type, String message) {
        jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO notifications (type, message) VALUES (:type, :msg)")
                        .bind("type", type)
                        .bind("msg", message)
                        .execute()
        );
    }

    public static java.util.List<java.util.Map<String, Object>> getRecentNotifications() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT id, type, message, DATE_FORMAT(created_at, '%H:%i %d/%m/%Y') as created_at FROM notifications ORDER BY created_at DESC LIMIT 5")
                        .mapToMap()
                        .list()
        );
    }
}