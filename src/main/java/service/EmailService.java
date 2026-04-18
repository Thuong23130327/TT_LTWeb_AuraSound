package service;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailService {
    private static final String EMAIL = "aurasound.contact@gmail.com";
    private static final String APP_PASSWORD = "jxeqicmdvmjovjne";

    public static boolean sendResetEmail(String toEmail, String resetLink) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL, "AuraSound Security"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Yêu cầu đặt lại mật khẩu - AuraSound");
            message.setContent("<p>Click vào link sau để đổi mật khẩu (hết hạn sau 15 phút):</p><a href='" + resetLink + "'>Đổi mật khẩu</a>", "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}