package com.store.electro.Models.DTOs.Request;

import lombok.Data;

@Data
public class ProductImageRequest {

    // Image URL
    private String imageUrl;

    // Is Primary
    private boolean isPrimary;
}
