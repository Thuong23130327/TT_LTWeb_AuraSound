package util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

public class ImageUploadUtil {


    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;
    

    private static final String[] ALLOWED_TYPES = {"image/jpeg", "image/png", "image/gif", "image/webp"};
    

    private static final String AVATAR_UPLOAD_DIR = "img/avatars";

    public static String uploadAvatar(Part part, String uploadBasePath) {
        if (part == null) {
            return null;
        }

        try {
    
            String fileName = getFileName(part);
            long fileSize = part.getSize();
            String contentType = part.getContentType();

         
            if (fileName == null || fileName.isEmpty()) {
                System.out.println("File name is empty");
                return null;
            }

            if (!isValidFileType(contentType)) {
                System.out.println("Invalid file type: " + contentType);
                return null;
            }

            if (fileSize > MAX_FILE_SIZE) {
                System.out.println("File size exceeds maximum allowed size");
                return null;
            }


            Path uploadPath = Paths.get(uploadBasePath, AVATAR_UPLOAD_DIR);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

         
            String uniqueFileName = generateUniqueFileName(fileName);
            
    
            Path filePath = uploadPath.resolve(uniqueFileName);
            part.write(filePath.toString());

          
            String relativePath = AVATAR_UPLOAD_DIR + "/" + uniqueFileName;
            System.out.println("File uploaded successfully: " + relativePath);
            return relativePath;

        } catch (IOException e) {
            System.out.println("Error uploading file: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Extract file name from Part
     */
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return null;
    }

    /**
     * Generate unique file name using UUID
     */
    private static String generateUniqueFileName(String originalFileName) {
        String extension = getFileExtension(originalFileName);
        String uniqueName = UUID.randomUUID().toString() + (extension.isEmpty() ? "" : "." + extension);
        return uniqueName;
    }

    /**
     * Extract file extension
     */
    private static String getFileExtension(String fileName) {
        if (fileName.contains(".")) {
            return fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        }
        return "";
    }

    /**
     * Validate file type
     */
    private static boolean isValidFileType(String contentType) {
        if (contentType == null) {
            return false;
        }
        for (String type : ALLOWED_TYPES) {
            if (contentType.equals(type)) {
                return true;
            }
        }
        return false;
    }

    /**
     * Delete old avatar file
     */
    public static void deleteOldAvatar(String avatarPath, String uploadBasePath) {
        if (avatarPath == null || avatarPath.isEmpty()) {
            return;
        }
        try {
            // Skip deletion if it's a default avatar or external URL
            if (avatarPath.contains("default") || avatarPath.startsWith("http")) {
                return;
            }
            
            Path filePath = Paths.get(uploadBasePath, avatarPath);
            if (Files.exists(filePath)) {
                Files.delete(filePath);
                System.out.println("Old avatar deleted: " + avatarPath);
            }
        } catch (IOException e) {
            System.out.println("Error deleting old avatar: " + e.getMessage());
        }
    }
}
