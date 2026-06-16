package dao.AdminDAO;
import org.jdbi.v3.core.Jdbi;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminDAO {
    private static final Jdbi jdbi = dao.DB.DBConnect.getJdbi();

    public static Map<String, Object> getDashboardStats() {
        return jdbi.withHandle(handle -> {
            Map<String, Object> stats = new HashMap<>();

            stats.put("totalProducts", handle.createQuery("SELECT COUNT(*) FROM products").mapTo(Integer.class).one());
            stats.put("totalOrders", handle.createQuery("SELECT COUNT(*) FROM orders").mapTo(Integer.class).one());
            stats.put("ordersPending", handle.createQuery("SELECT COUNT(*) FROM orders WHERE status = 0").mapTo(Integer.class).one());
            stats.put("totalCustomer", handle.createQuery("SELECT COUNT(*) FROM users").mapTo(Integer.class).one());

            stats.put("totalRevenue", handle.createQuery("SELECT COALESCE(SUM(final_amount), 0) FROM orders WHERE status = 2").mapTo(Double.class).one());
            stats.put("yearRevenue", handle.createQuery("SELECT COALESCE(SUM(final_amount), 0) FROM orders WHERE status = 2 AND YEAR(order_date) = YEAR(CURDATE())").mapTo(Double.class).one());
            stats.put("monthRevenue", handle.createQuery("SELECT COALESCE(SUM(final_amount), 0) FROM orders WHERE status = 2 AND MONTH(order_date) = MONTH(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE())").mapTo(Double.class).one());
            stats.put("dayRevenue", handle.createQuery("SELECT COALESCE(SUM(final_amount), 0) FROM orders WHERE status = 2 AND DATE(order_date) = CURDATE()").mapTo(Double.class).one());

            return stats;
        });
    }

    public static Map<String, Object> getChartData(String filter) {
        return jdbi.withHandle(handle -> {
            Map<String, Object> result = new HashMap<>();
            List<String> labels = new ArrayList<>();
            List<Double> data = new ArrayList<>();

            String sql = "";
            if ("7days".equals(filter)) {
                sql = "SELECT DATE_FORMAT(order_date, '%d/%m') as label, COALESCE(SUM(final_amount), 0) as value FROM orders " +
                        "WHERE status = 2 AND order_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
                        "GROUP BY DATE(order_date) ORDER BY DATE(order_date) ASC";
            } else if ("thisMonth".equals(filter)) {
                sql = "SELECT DATE_FORMAT(order_date, '%d/%m') as label, COALESCE(SUM(final_amount), 0) as value FROM orders " +
                        "WHERE status = 2 AND MONTH(order_date) = MONTH(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE()) " +
                        "GROUP BY DATE(order_date) ORDER BY DATE(order_date) ASC";
            } else if ("thisYear".equals(filter)) {
                sql = "SELECT DATE_FORMAT(order_date, 'Tháng %m') as label, COALESCE(SUM(final_amount), 0) as value FROM orders " +
                        "WHERE status = 2 AND YEAR(order_date) = YEAR(CURDATE()) " +
                        "GROUP BY MONTH(order_date) ORDER BY MONTH(order_date) ASC";
            }

            handle.createQuery(sql).map((rs, ctx) -> {
                labels.add(rs.getString("label"));
                data.add(rs.getDouble("value"));
                return null;
            }).list();

            result.put("labels", labels);
            result.put("data", data);
            return result;
        });
    }
}