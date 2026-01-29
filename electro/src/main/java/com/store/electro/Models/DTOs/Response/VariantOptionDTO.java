package com.store.electro.Models.DTOs.Response;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonPropertyOrder({
    "id",
    "optionCode",
    "value",
    "extraPrice"
})
public class VariantOptionDTO {
    private Long id;
    private String optionCode;
    private String value;
    private BigDecimal extraPrice;

    public VariantOptionDTO() {
    }

    public VariantOptionDTO(Long id, String optionCode, String value, BigDecimal extraPrice) {
        this.id = id;
        this.optionCode = optionCode;
        this.value = value;
        this.extraPrice = extraPrice;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOptionCode() {
        return optionCode;
    }

    public void setOptionCode(String optionCode) {
        this.optionCode = optionCode;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public BigDecimal getExtraPrice() {
        return extraPrice;
    }

    public void setExtraPrice(BigDecimal extraPrice) {
        this.extraPrice = extraPrice;
    }
}
