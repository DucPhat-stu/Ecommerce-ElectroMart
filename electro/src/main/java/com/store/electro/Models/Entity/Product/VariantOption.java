package com.store.electro.Models.Entity.Product;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@JsonPropertyOrder({
        "id",
        "optionCode",
        "variant",
        "option",
        "value",
        "extraPrice"
})
@Entity
@Table(name = "variant_options")
public class VariantOption {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "variant_id")
    @JsonBackReference
    private ProductVariant variant;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "option_id")
    @JsonBackReference
    private ProductOption option;

    @Column(name = "value")
    private String value;

    @Column(name = "extra_price")
    private BigDecimal extraPrice;

    // Json Property to get option code
    @JsonProperty("optionCode")
    public String getOptionCode() {
        return option != null ? option.getCode() : null;
    }

    /*
     * CONSTRUCTORS
     */

    public VariantOption() {
    }

    /*
     * GETTERS AND SETTERS
     */

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public ProductVariant getVariant() {
        return variant;
    }

    public void setVariant(ProductVariant variant) {
        this.variant = variant;
    }

    public ProductOption getOption() {
        return option;
    }

    public void setOption(ProductOption option) {
        this.option = option;
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

    /*
     * Methods
     */
}
