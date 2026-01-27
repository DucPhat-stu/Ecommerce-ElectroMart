package com.store.electro.Models.DTOs.Request.ProductRequest;

import java.math.BigDecimal;
import java.util.List;

import com.store.electro.Models.Enums.ProductStatus;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ProductVariantRequest {

    @NotNull(message = "Variant ID is required")
    @Min(value = 1)
    private Long id;

    // Price
    @NotNull(message = "Base price is required")
    @DecimalMin(value = "0.0", message = "Price must be greater than or equal to 0")
    private BigDecimal basePrice;

    // Discount Percent
    @Min(value = 0, message = "Discount percent must be between 0 and 100")
    @Max(value = 100)
    private Integer discountPercent = 0;

    private ProductStatus status;

    private List<VariantOptionRequest> options;
}
