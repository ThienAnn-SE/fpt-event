package utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

public class FileHelper {

    public static final String[] imageExtension = {"png", "jpg", "svg", "jpeg", "bmp"};

    /**
     * @param request servlet request
     * @param filePart file part
     * @return url of this file
     */
    public static String uploadFile(HttpServletRequest request, Part filePart) throws IOException, ServletException {
        String UPLOAD_DIR = "images";

        try {
            String fileName = UUID.randomUUID() + getFileName(filePart);
            String applicationPath = request.getServletContext().getRealPath("");
            String basePath = applicationPath + File.separator + UPLOAD_DIR + File.separator;
            File theDir = new File(basePath);
            if (!theDir.exists()) {
                theDir.mkdirs();
            }

            InputStream inputStream = null;
            OutputStream outputStream = null;
            try {
                File outputFilePath = new File(basePath + fileName);
                inputStream = filePart.getInputStream();
                outputStream = new FileOutputStream(outputFilePath);
                int read;
                final byte[] bytes = new byte[1024];
                while ((read = inputStream.read(bytes)) != -1) {
                    outputStream.write(bytes, 0, read);
                }
                return UPLOAD_DIR + File.separator + fileName;
            } catch (IOException e) {
                return null;
            } finally {
                if (inputStream != null) {
                    inputStream.close();
                }
                if (outputStream != null) {
                    outputStream.close();
                }
            }

        } catch (IOException e) {
            return null;
        }

    }

    /**
     * Get file name
     *
     * @param part url of the file which we will to get file name
     * @return file name
     */
    public static String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }

        return null;
    }

    public static String readHTMLFile(String fileName) {
        StringBuilder contentBuilder = new StringBuilder();
        try {
            BufferedReader in = new BufferedReader(new FileReader(fileName));
            String str;
            while ((str = in.readLine()) != null) {
                contentBuilder.append(str);
            }
            in.close();
        } catch (IOException e) {
            return null;
        }
        return contentBuilder.toString();
    }
}
