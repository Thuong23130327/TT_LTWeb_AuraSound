package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.util.Properties;

public class EmailUtility {
    public static void sendMagicLink(String toEmail, String link) throws MessagingException {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        final String username = "nhthuong.1305@gmail.com";
        final String password = "ympz yort geid amyr";

        Session session = Session.getInstance(prop, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Xác thực Email - AuraSound");

        String htmlContent = "<h3>Chào mừng bạn đến với AuraSound!</h3>" +
                "<p>Vui lòng click vào link bên dưới để xác thực email và hoàn tất đăng ký:</p>" +
                "<a href='" + link + "' style='padding:10px; background:blue; color:white;'>Xác thực ngay</a>";

        message.setContent(htmlContent, "text/html; charset=utf-8");
        Transport.send(message);
    }
}