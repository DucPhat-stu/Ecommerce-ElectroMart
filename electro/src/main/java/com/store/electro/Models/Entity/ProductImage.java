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

@JsonPropertyOrder({ "id", "productId", "imageUrl", "position", "isPrimary" })
@Entity
@Table(name = "product_images")
public class ProductImage {

    // Product Image ID
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Product ID
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "productId")
    @JsonBackReference
    private Product product;

    // Image URL
    @Column(name = "imageUrl")
    private String imageUrl;

    // Position
    @Column(name = "position")
    private Integer position;

    // Is Primary
    @Column(name = "isPrimary")
    private boolean isPrimary;

    /*
     * CONSTRUCTORS
     */

    public ProductImage() {
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

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public boolean isIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(boolean isPrimary) {
        this.isPrimary = isPrimary;
    }

    /*
     * toString Method
     */

    @Override
    public String toString() {
        return "ProductImage [id=" + id + ", product=" + product + ", imageUrl=" + imageUrl + ", position=" + position
                + ", isPrimary=" + isPrimary + "]";
    }
}
