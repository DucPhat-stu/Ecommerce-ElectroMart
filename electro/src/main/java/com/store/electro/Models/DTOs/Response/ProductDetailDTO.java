package com.store.electro.Models.DTOs.Response;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
    "id",
    "attributeName",
    "attributeValue"
})
public class ProductDetailDTO {
    private Long id;
    private String attributeName;
    private String attributeValue;

    public ProductDetailDTO() {
    }

    public ProductDetailDTO(Long id, String attributeName, String attributeValue) {
        this.id = id;
        this.attributeName = attributeName;
        this.attributeValue = attributeValue;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAttributeName() {
        return attributeName;
    }

    public void setAttributeName(String attributeName) {
        this.attributeName = attributeName;
    }

    public String getAttributeValue() {
        return attributeValue;
    }

    public void setAttributeValue(String attributeValue) {
        this.attributeValue = attributeValue;
    }
}
