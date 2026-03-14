package dao.DB;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.DriverManager;

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
}
