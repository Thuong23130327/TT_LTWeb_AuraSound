package util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashUtils {

    public static String hashPass(String password) {
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md5.digest(password.getBytes());
            BigInteger n = new BigInteger(1, messageDigest);
            String hashpassword = n.toString(16);
            while (hashpassword.length() < 32) {
                hashpassword = "0" + hashpassword;
            }
            return hashpassword;
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
