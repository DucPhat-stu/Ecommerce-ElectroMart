package com.store.electro.Models.DTOs.Response;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
    "id",
    "imageName",
    "imageUrl",
    "position",
    "isPrimary"
})
public class ProductImageDTO {
    private Long id;
    private String imageName;
    private String imageUrl;
    private Integer position;
    private boolean isPrimary;

    public ProductImageDTO() {
    }

    public ProductImageDTO(Long id, String imageName, String imageUrl, Integer position, boolean isPrimary) {
        this.id = id;
        this.imageName = imageName;
        this.imageUrl = imageUrl;
        this.position = position;
        this.isPrimary = isPrimary;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Integer getPosition() {
        return position;
    }

    public void setPosition(Integer position) {
        this.position = position;
    }

    public boolean isIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(boolean isPrimary) {
        this.isPrimary = isPrimary;
    }
}
