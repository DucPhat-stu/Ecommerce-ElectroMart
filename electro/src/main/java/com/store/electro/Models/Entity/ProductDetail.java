package com.store.electro.Models.Entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
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

@JsonPropertyOrder({ "id", "productId", "attributeName", "attributeValue" })
@Entity
@Table(name = "product_details")
public class ProductDetail {

    // Product Detail ID
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Product ID
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productId")
    @JsonBackReference
    private Product product;

    // Attribute Name
    @Column(name = "attributeName")
    private String attributeName;

    // Attribute Value
    @Column(name = "attributeValue")
    private String attributeValue;

    /*
     * CONSTRUCTORS
     */

    public ProductDetail() {
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

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    /*
     * toString Method
     */
    @Override
    public String toString() {
        return "ProductDetail [id=" + id + ", product=" + product + ", attributeName=" + attributeName
                + ", attributeValue=" + attributeValue + "]";
    }

}
