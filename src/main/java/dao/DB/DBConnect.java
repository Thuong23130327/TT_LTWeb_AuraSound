package dao.DB;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnect {

    private static HikariDataSource dataSource;
    private static Jdbi jdbi;

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            init();
        }
        return jdbi;

    }

    public static void init() {

        if (dataSource == null || dataSource.isClosed()) {
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
        }
    }


    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource chưa được khởi tạo. Kiểm tra lại cấu hình HikariCP.");
        }
        return dataSource.getConnection();
    }

    public static void close() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            dataSource = null;
            jdbi = null;
        }
    }

}
