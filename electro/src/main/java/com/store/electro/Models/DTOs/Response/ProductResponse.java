package com.store.electro.Models.DTOs.Response;

import java.time.LocalDateTime;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
    "id",
    "name",
    "shortDescription",
    "description",
    "categoryName",
    "brandName",
    "status",
    "productImages",
    "productDetails",
    "productVariants",
    "createdAt",
    "updatedAt"
})
public class ProductResponse {
    private Long id;
    private String name;
    private String shortDescription;
    private String description;
    private String categoryName;
    private String brandName;
    private String status;
    private Set<ProductImageDTO> images;
    private Set<ProductDetailDTO> details;
    private Set<ProductVariantDTO> variants;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public ProductResponse() {
    }

    public ProductResponse(Long id, String name, String shortDescription, String description,
                          String categoryName, String brandName, String status,
                          Set<ProductImageDTO> images, Set<ProductDetailDTO> details,
                          Set<ProductVariantDTO> variants, LocalDateTime createdAt,
                          LocalDateTime updatedAt) {
        this.id = id;
        this.name = name;
        this.shortDescription = shortDescription;
        this.description = description;
        this.categoryName = categoryName;
        this.brandName = brandName;
        this.status = status;
        this.images = images;
        this.details = details;
        this.variants = variants;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Set<ProductImageDTO> getImages() {
        return images;
    }

    public void setImages(Set<ProductImageDTO> images) {
        this.images = images;
    }

    public Set<ProductDetailDTO> getDetails() {
        return details;
    }

    public void setDetails(Set<ProductDetailDTO> details) {
        this.details = details;
    }

    public Set<ProductVariantDTO> getVariants() {
        return variants;
    }

    public void setVariants(Set<ProductVariantDTO> variants) {
        this.variants = variants;
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
