package dao.AdminDAO;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.generic.GenericType;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;

public class AdminDAO {
    private static Jdbi jdbi = dao.DB.DBConnect.getJdbi();


    //  tổng sp
    public int totalProducts() {
        String sql = "SELECT COUNT(*) FROM Products";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // tổng đơn
    public int totalOrders() {
        String sql = "SELECT COUNT(*) FROM Orders";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // đơn chờ xử lý
    public int ordersPending() {
        String sql = "SELECT COUNT(*)  FROM Orders WHERE payment_status = 'PENDING'";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // tổng khách hàng
    public int totalCustomer() {
        String sql = "SELECT COUNT(*) FROM Users WHERE role = 'Customer';";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // tổng doanh thu
    public int totalRevenue() {
        String sql = "SELECT SUM(final_amount) FROM Orders WHERE status = 'COMPLETED' ";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // doanh thu theo năm
    public int yearRevenue() {
        String sql = "SELECT SUM(final_amount) AS DoanhThuNamNay FROM Orders WHERE status = 'COMPLETED' AND YEAR(order_date) = YEAR(CURDATE())";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // doanh thu theo tháng
    public int monthRevenue() {
        String sql = "SELECT SUM(final_amount) AS DoanhThuThangNay FROM Orders WHERE status = 'COMPLETED'  AND MONTH(order_date) = MONTH(CURDATE()) AND YEAR(order_date) = YEAR(CURDATE())";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // doanh thu theo ngày
    public int dayRevenue() {
        String sql = "SELECT SUM(final_amount) FROM Orders WHERE status = 'COMPLETED' AND DATE(order_date) = CURDATE()";
        return jdbi.withHandle(handle ->
                handle.createQuery(sql).mapTo(Integer.class).findFirst().orElse(0)
        );
    }

    // 6 tháng gần nhất
    public Map<String, Integer> chartRevenue() {
        Map<String, Integer> finalData = new LinkedHashMap<>();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/yyyy");
        LocalDate now = LocalDate.now();

        for (int i = 5; i >= 0; i--) {
            LocalDate targetDate = now.minusMonths(i);
            finalData.put(targetDate.format(formatter), 0);
        }

        String sql = "SELECT " +
                "  DATE_FORMAT(order_date, '%m/%Y') AS month_year, " +
                "  SUM(final_amount) AS monthly_revenue " +
                "FROM Orders " +
                "WHERE status = 'COMPLETED' " +
                "  AND order_date >= LAST_DAY(CURRENT_DATE - INTERVAL 6 MONTH) + INTERVAL 1 DAY " +
                "GROUP BY YEAR(order_date), MONTH(order_date) " +
                "ORDER BY YEAR(order_date) ASC, MONTH(order_date) ASC";

        jdbi.useHandle(handle -> {
            handle.createQuery(sql)
                    .map((rs, ctx) -> Map.entry(rs.getString("month_year"), rs.getInt("monthly_revenue")))
                    .list()
                    .forEach(entry -> {
                        if (finalData.containsKey(entry.getKey())) {
                            finalData.put(entry.getKey(), entry.getValue());
                        }
                    });
        });

        return finalData;
    }
    // 7 ngày gần nhất
    public Map<String, Long> chartSevenDaysRevenue() {
        Map<String, Long> finalData = new LinkedHashMap<>();
        DateTimeFormatter displayFormatter = DateTimeFormatter.ofPattern("dd/MM");
        DateTimeFormatter dbFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate today = LocalDate.now();
        for (int i = 6; i >= 0; i--) {
            finalData.put(today.minusDays(i).format(dbFormatter), 0L);
        }
        String sql = "SELECT DATE(order_date) AS d, SUM(final_amount) AS r " +
                "FROM Orders " +
                "WHERE status = 'COMPLETED' " +
                "  AND order_date >= CURDATE() - INTERVAL 6 DAY " +
                "GROUP BY DATE(order_date)";
        Map<String, Long> dbData = jdbi.withHandle(handle ->
                handle.createQuery(sql)
                        .setMapKeyColumn("d")
                        .setMapValueColumn("r")
                        .collectInto(new GenericType<Map<String, Long>>() {})
        );
        finalData.putAll(dbData);
        Map<String, Long> displayData = new LinkedHashMap<>();
        finalData.forEach((key, value) -> {
            displayData.put(LocalDate.parse(key).format(displayFormatter), value);
        });

        return displayData;
    }
}
