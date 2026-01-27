package com.store.electro.Models.DTOs.Request;

import com.store.electro.Models.Enums.ProductStatus;
import jakarta.validation.constraints.*;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class ProductVariantRequest {
    @NotBlank(message = "Storage is required")
    private String storageSize;

    @NotBlank(message = "Color is required")
    private String color;

    // Price
    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", message = "Price must be greater than or equal to 0")
    private BigDecimal price;

    // Discount Percent
    @Min(value = 0, message = "Discount percent must be between 0 and 100")
    @Max(value = 100)
    private Integer discountPercent = 0;

    private ProductStatus status;
}
