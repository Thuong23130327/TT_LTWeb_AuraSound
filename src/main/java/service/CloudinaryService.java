package service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;

public class CloudinaryService {
    private static final Cloudinary cloudinary;
    static {
        Properties props = new Properties();
        try (InputStream is = CloudinaryService.class.getClassLoader().getResourceAsStream("env.properties")) {
            if (is != null) {
                props.load(is);
            }
        } catch (Exception e) {
            System.err.println("Không tìm thấy");
        }
        cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", props.getProperty("cloudinary.cloud_name", "YOUR_CLOUD_NAME"),
                "api_key", props.getProperty("cloudinary.api_key", "YOUR_API_KEY"),
                "api_secret", props.getProperty("cloudinary.api_secret", "YOUR_SECRET"),
                "secure", true
        ));
    }

    public static String uploadFile(Part filePart) {
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        try {
            byte[] fileBytes = filePart.getInputStream().readAllBytes();

            Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap(
                    "folder", "AuraSound_Banners"
            ));

            return uploadResult.get("secure_url").toString();

        } catch (IOException e) {
            System.err.println("Lỗi khi up ảnh lên Cloudinary: " + e.getMessage());
            return null;
        }
    }
}