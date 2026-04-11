package util;

import java.util.regex.Pattern;

public class ValidationUtils {
    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String PHONE_PATTERN = "^0[35789]\\d{8}$";

    public static boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        return !isEmpty(email) && Pattern.compile(EMAIL_PATTERN).matcher(email).matches();
    }

    public static boolean isValidPhone(String phone) {
        return !isEmpty(phone) && Pattern.compile(PHONE_PATTERN).matcher(phone).matches();
    }
}