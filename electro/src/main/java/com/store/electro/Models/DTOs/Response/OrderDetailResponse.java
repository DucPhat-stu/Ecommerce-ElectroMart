package com.store.electro.Models.DTOs.Response;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
    "id",
    "productId",
    "productName",
    "productPrice",
    "discountPercent",
    "quantity",
    "subtotal",
    "options",
    "createdAt"
})
public class OrderDetailResponse {
    private Long id;
    private Long productId;
    private String productName;
    private BigDecimal productPrice;
    private Integer discountPercent;
    private Integer quantity;
    private BigDecimal subtotal;
    private List<VariantOptionInfo> options;
    private LocalDateTime createdAt;

    public OrderDetailResponse() {
    }

    public OrderDetailResponse(Long id, Long productId, String productName, BigDecimal productPrice,
                              Integer discountPercent, Integer quantity, BigDecimal subtotal,
                              List<VariantOptionInfo> options, LocalDateTime createdAt) {
        this.id = id;
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.discountPercent = discountPercent;
        this.quantity = quantity;
        this.subtotal = subtotal;
        this.options = options;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public List<VariantOptionInfo> getOptions() {
        return options;
    }

    public void setOptions(List<VariantOptionInfo> options) {
        this.options = options;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Inner class to represent variant options with clear naming
     */
    public static class VariantOptionInfo {
        private String optionName;
        private String optionValue;
        private BigDecimal extraPrice;

        public VariantOptionInfo() {
        }

        public VariantOptionInfo(String optionName, String optionValue, BigDecimal extraPrice) {
            this.optionName = optionName;
            this.optionValue = optionValue;
            this.extraPrice = extraPrice;
        }

        public String getOptionName() {
            return optionName;
        }

        public void setOptionName(String optionName) {
            this.optionName = optionName;
        }

        public String getOptionValue() {
            return optionValue;
        }

        public void setOptionValue(String optionValue) {
            this.optionValue = optionValue;
        }

        public BigDecimal getExtraPrice() {
            return extraPrice;
        }

        public void setExtraPrice(BigDecimal extraPrice) {
            this.extraPrice = extraPrice;
        }
    }
}
