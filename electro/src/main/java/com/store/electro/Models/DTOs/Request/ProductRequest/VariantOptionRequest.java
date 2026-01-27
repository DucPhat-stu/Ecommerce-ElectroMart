package com.store.electro.Models.DTOs.Request.ProductRequest;

import java.math.BigDecimal;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class VariantOptionRequest {

    @NotNull(message = "ID is required")
    @Min(value = 1)
    private Long id;

    @NotNull(message = "Option ID is required")
    @Min(value = 1)
    private Long optionId;

    @NotNull(message = "value is required")
    private String value;

    @NotNull(message = "Extra price is required")
    @DecimalMin(value = "0.0", message = "Price must be greater than or equal to 0")
    private BigDecimal extraPrice;
}
