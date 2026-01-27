package com.store.electro.Models.DTOs.Request;

import java.math.BigDecimal;
import java.util.List;

import com.store.electro.Models.Enums.ProductStatus;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AddProductRequest {

    // Name
    @NotBlank(message = "Product name is required")
    private String name;

    // Short Description
    private String shortDescription;

    // Description
    private String description;

    // Status
    private ProductStatus status;

    // Category ID
    @NotNull(message = "Category ID is required")
    @Min(value = 1)
    private Long categoryId;

    // Brand ID
    @NotNull(message = "Brand ID is required")
    private Long brandId;

    // List of details
    private List<ProductDetailRequest> productDetails;

    // List of Images
    private List<ProductImageRequest> productImages;

    // List of Variants
    private List<ProductVariantRequest> productVariants;
}
