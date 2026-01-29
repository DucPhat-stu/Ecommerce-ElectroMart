package com.store.electro.Models.DTOs.Response;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
    "id",
    "basePrice",
    "finalPrice",
    "discountPercent",
    "status",
    "options",
    "createdAt",
    "updatedAt"
})
public class ProductVariantDTO {
    private Long id;
    private BigDecimal basePrice;
    private BigDecimal finalPrice;
    private Integer discountPercent;
    private String status;
    private Set<VariantOptionDTO> options;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public ProductVariantDTO() {
    }

    public ProductVariantDTO(Long id, BigDecimal basePrice, BigDecimal finalPrice, Integer discountPercent,
                            String status, Set<VariantOptionDTO> options, LocalDateTime createdAt,
                            LocalDateTime updatedAt) {
        this.id = id;
        this.basePrice = basePrice;
        this.finalPrice = finalPrice;
        this.discountPercent = discountPercent;
        this.status = status;
        this.options = options;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }

    public BigDecimal getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Set<VariantOptionDTO> getOptions() {
        return options;
    }

    public void setOptions(Set<VariantOptionDTO> options) {
        this.options = options;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
