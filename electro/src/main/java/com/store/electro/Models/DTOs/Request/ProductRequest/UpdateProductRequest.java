package com.store.electro.Models.DTOs.Request.ProductRequest;

import java.util.List;

import com.store.electro.Models.Enums.ProductStatus;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class UpdateProductRequest {

    // Name
    @NotBlank(message = "Product name is required")
    private String name;

    // Short Description
    private String shortDescription;

    // Description
    private String description;

    // Status
    @NotNull
    private ProductStatus status;

    // Category ID
    @NotNull(message = "Category ID is required")
    @Min(value = 1)
    private Long categoryId;

    // Brand ID
    @NotNull(message = "Brand ID is required")
    @Min(value = 1)
    private Long brandId;

    // List of details
    @Valid
    private List<ProductDetailRequest> productDetails;

    // List of Images
    @Valid
    private List<ProductImageRequest> productImages;

    // List of Variants
    @Valid
    private List<ProductVariantRequest> productVariants;
}
