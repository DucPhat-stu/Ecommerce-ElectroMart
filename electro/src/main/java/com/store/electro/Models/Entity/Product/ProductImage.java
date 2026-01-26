package com.store.electro.Models.Entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.persistence.*;

@JsonPropertyOrder({"id", "productId", "imageName", "imageUrl", "position", "isPrimary"})
@Entity
@Table(name = "product_images")
public class ProductImage {

    // Product Image ID
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Product ID
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    @JsonBackReference
    private Product product;

    // Image Name
    @Column(name = "image_name")
    private String imageName;

    // Image URL
    @Column(name = "image_url")
    private String imageUrl;

    // Position
    @Column(name = "position")
    private Integer position;

    // Is Primary
    @Column(name = "is_primary")
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

    public String getImageName() {
        return imageName;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    /*
     * toString Method
     */

    @Override
    public String toString() {
        return "ProductImage [id=" + id + ", imageUrl=" + imageUrl + ", position=" + position
                + ", isPrimary=" + isPrimary + "]";
    }
}
