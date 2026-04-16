package model.IconLogin;

public class FacebookConfig {
    public static final String FACEBOOK_APP_ID = "958626530005155";
    public static final String FACEBOOK_APP_SECRET = "6a4a309b837f2176654b37729074af63";
    public static final String FACEBOOK_REDIRECT_URL = "http://localhost:8080/AuraSound/login-facebook";
    public static final String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/v19.0/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";
    public static final String FACEBOOK_LINK_GET_USER_INFO = "https://graph.facebook.com/me?fields=id,name,email&access_token=%s";
}