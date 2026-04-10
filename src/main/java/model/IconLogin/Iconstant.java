package model.IconLogin;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class  Iconstant {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = Iconstant.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                System.out.println("Xin lỗi, không tìm thấy config.properties");
            } else {
                properties.load(input);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public static final String GOOGLE_CLIENT_ID = properties.getProperty("google.client.id");
    public static final String GOOGLE_CLIENT_SECRET = properties.getProperty("google.client.secret");
    public static final String GOOGLE_REDIRECT_URI = properties.getProperty("google.redirect.uri");

    public static final String GOOGLE_GRANT_TYPE = "authorization_code";
    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
}