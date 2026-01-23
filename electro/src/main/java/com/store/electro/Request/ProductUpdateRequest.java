package com.store.electro.Request;

import com.store.electro.Models.Entity.Category;
import com.store.electro.Models.Enums.ProductStatus;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class ProductUpdateRequest {

    @NotBlank(message = "Product name is required")
    private String name;

    @NotNull(message = "Price is required")
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    private BigDecimal price;

    @Min(value = 0, message = "Discount percent must be between 0 and 100")
    private Integer discountPercent = 0;

    private String shortDescription;

    private String description;

    private ProductStatus status = ProductStatus.ACTIVE;

    @NotNull(message = "Category ID is required")
    private Category category;
}
