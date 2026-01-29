package com.store.electro.Models.DTOs.Request.ProductRequest;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.Min;
import lombok.Data;

@Data
public class ProductImageRequest {

    @Min(value = 1)
    private Long id;

    // Image file to upload
    private MultipartFile imageFile;

    // Image URL (used for existing images during update)
    private String imageUrl;

    // Is Primary
    private boolean isPrimary;
}
