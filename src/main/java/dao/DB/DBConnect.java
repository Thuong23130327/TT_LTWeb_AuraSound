package dao.DB;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    private static HikariDataSource dataSource;
    private static Jdbi jdbi;

    public static Jdbi getJdbi() {
        return jdbi;
    }

    static {
        try {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(DBProperties.URL);
            config.setUsername(DBProperties.USERNAME);
            config.setPassword(DBProperties.PASSWORD);
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

            config.setMaximumPoolSize(20);
            config.setMinimumIdle(5);
            config.setIdleTimeout(30000);
            config.setConnectionTimeout(20000);

            dataSource = new HikariDataSource(config);
            jdbi = Jdbi.create(dataSource);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Loi khoi tao HKR va JDBI");
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource chưa được khởi tạo. Kiểm tra lại cấu hình HikariCP.");
        }
        return dataSource.getConnection();
    }

    static {
        try {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(DBProperties.URL);
            config.setUsername(DBProperties.USERNAME);
            config.setPassword(DBProperties.PASSWORD);
            config.setDriverClassName("com.mysql.cj.jdbc.Driver");

            config.setMaximumPoolSize(20);
            config.setMinimumIdle(5);
            config.setIdleTimeout(300000);
            config.setConnectionTimeout(20000);
            config.setMaxLifetime(1800000);

            dataSource = new HikariDataSource(config);
            jdbi = Jdbi.create(dataSource);

            System.out.println("Khởi tạo HikariCP và JDBI thành công!");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Lỗi khởi tạo HikariCP và JDBI: " + e.getMessage());
        }
    }
}
