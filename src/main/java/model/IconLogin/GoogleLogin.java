    package model.IconLogin;

    import com.google.gson.Gson;
    import com.google.gson.JsonObject;
    import model.entity.GoogleAccount;
    import org.apache.http.client.ClientProtocolException;
    import org.apache.http.client.fluent.Form;
    import org.apache.http.client.fluent.Request;

    import java.io.IOException;
    import java.io.InputStream;
    import java.net.HttpURLConnection;
    import java.net.URL;
    import java.util.Scanner;

    public class GoogleLogin {

        public static String getToken(String code) throws ClientProtocolException, IOException {
            String response = Request.Post(Iconstant.GOOGLE_LINK_GET_TOKEN)
                    .bodyForm(
                            Form.form()
                                    .add("client_id", Iconstant.GOOGLE_CLIENT_ID)
                                    .add("client_secret", Iconstant.GOOGLE_CLIENT_SECRET)
                                    .add("redirect_uri", Iconstant.GOOGLE_REDIRECT_URI)
                                    .add("code", code)
                                    .add("grant_type", Iconstant.GOOGLE_GRANT_TYPE)
                                    .build()
                    )
                    .execute().returnContent().asString();

            JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
            String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
            return accessToken;
        }

        public static GoogleAccount getUserInfo(final String accessToken) throws IOException {
            String link = Iconstant.GOOGLE_LINK_GET_USER_INFO + accessToken;
            URL url = new URL(link);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            InputStream inputStream = conn.getInputStream();
            Scanner scanner = new Scanner(inputStream, "UTF-8").useDelimiter("\\A");
            String response = scanner.hasNext() ? scanner.next() : "";
            scanner.close();

            GoogleAccount googlePojo = new Gson().fromJson(response, GoogleAccount.class);
            return googlePojo;
        }
    }