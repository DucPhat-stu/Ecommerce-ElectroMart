package com.store.electro.Services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Service
public class FileStorageService {

    private static final List<String> ALLOWED_TYPES = List.of(
            "image/jpeg",
            "image/png",
            "image/webp"
    );

    @Value("${file.upload-dir}")
    private String uploadDir;

    public String saveProductImage(MultipartFile file, Long productId) throws IOException {

        if (file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }

        if (!ALLOWED_TYPES.contains(file.getContentType())) {
            throw new IllegalArgumentException("Invalid image type");
        }

        String fileName = UUID.randomUUID() + ".webp";

        Path productDir = Paths.get(uploadDir, "products", productId.toString());
        Files.createDirectories(productDir);

        Path filePath = productDir.resolve(fileName);

        Files.copy(
                file.getInputStream(),
                filePath,
                StandardCopyOption.REPLACE_EXISTING
        );

        return "/img/products/" + productId + "/" + fileName;
    }
}

