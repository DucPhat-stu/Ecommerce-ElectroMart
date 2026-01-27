package com.store.electro.Models.DTOs.Request.ProductRequest;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ProductDetailRequest {

    @NotNull(message = "Product detail ID is required")
    @Min(value = 1)
    private Long id;

    // Attribute Name
    private String attributeName;

    // Attribute Value
    private String attributeValue;
}
