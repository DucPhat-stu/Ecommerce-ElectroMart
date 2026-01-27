package com.store.electro.Models.DTOs.Request.ProductRequest;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ProductImageRequest {

    @NotNull(message = "Image ID is required")
    @Min(value = 1)
    private Long id;

    // Image URL
    private String imageUrl;

    // Is Primary
    private boolean isPrimary;
}
