package dao.DB;

import java.io.IOException;
import java.util.Properties;

public class DBProperties {
    private static final Properties prop = new Properties();
    public static final String URL;
    public static final String USERNAME;
    public static final String PASSWORD;

    static {
        try {
            prop.load(DBProperties.class.getClassLoader().getResourceAsStream("db.properties"));

            URL = String.format("jdbc:mysql://%s:%s/%s?%s",
                    prop.getProperty("db.host"),
                    prop.getProperty("db.port"),
                    prop.getProperty("db.dbname"),
                    prop.getProperty("db.option"));

            USERNAME = prop.getProperty("db.username");
            PASSWORD = prop.getProperty("db.password");

        } catch (IOException e) {
            throw new RuntimeException("Property cua DB bị lỗi ", e);
        }
    }
}