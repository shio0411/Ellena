package store.login_with_facebook;

public class Constants {

    public static String FACEBOOK_APP_ID = "893226585410442";
    public static String FACEBOOK_APP_SECRET = "6abe6445ba33f6c3e3c2107617a8b8ea";
    public static String FACEBOOK_REDIRECT_URL = "http://localhost:8080/Ellena/LoginFacebookController";
    public static String FACEBOOK_LINK_GET_TOKEN = "https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&redirect_uri=%s&code=%s";
}
