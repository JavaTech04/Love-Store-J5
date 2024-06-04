package vunh.lovestore.utils;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.util.Objects;

public class HandleImages {
    public static String handleMultipartFile(MultipartFile multipartFile) throws IOException {
        Path path = Paths.get("images/");
        InputStream inputStream = multipartFile.getInputStream();
        Files.copy(inputStream, path.resolve(Objects.requireNonNull(multipartFile.getOriginalFilename())), StandardCopyOption.REPLACE_EXISTING);
        return multipartFile.getOriginalFilename();
    }
}
