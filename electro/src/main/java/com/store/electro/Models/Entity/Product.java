package com.store.electro.Models.Entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.store.electro.Models.Enums.ProductStatus;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

@JsonPropertyOrder({ "id", "name", "price", "discountPercent", "shortDescription", "description", "stockQuantity",
        "status", "createdAt", "updatedAt", "category", "productImages", "productDetails" })
@Entity
@Table(name = "products")
public class Product {

    // Product ID
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Product Name
    @Column(name = "name", nullable = false)
    private String name;

    // Product Price
    @Column(name = "price", nullable = false)
    private BigDecimal price;

    // Product Discount Percent
    @Column(name = "discountPercent")
    private Integer discountPercent = 0;

    // Product Short Description
    @Column(name = "shortDescription")
    private String shortDescription;

    // Product Description
    @Column(name = "description")
    private String description;

    // Product Stock Quantity
    @Column(name = "stockQuantity", nullable = false)
    private Integer stockQuantity = 0;

    // Product Status
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private ProductStatus status;

    // Created At
    @Column(name = "createdAt")
    private LocalDateTime createdAt;

    // Updated At
    @Column(name = "updatedAt")
    private LocalDateTime updatedAt;

    // Product Category
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "categoryId")
    @JsonManagedReference
    private Category category;

    // Product Images
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private Set<ProductImage> productImages = new HashSet<>();

    // Product Details
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    @JsonManagedReference
    private Set<ProductDetail> productDetails = new HashSet<>();

    /*
     * CONSTRUCTORS
     */

    public Product() {
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
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

    public Integer getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(Integer stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public ProductStatus getStatus() {
        return status;
    }

    public void setStatus(ProductStatus status) {
        this.status = status;
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

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Set<ProductImage> getProductImages() {
        return productImages;
    }

    public void setProductImages(Set<ProductImage> productImages) {
        this.productImages = productImages;
    }

    public Set<ProductDetail> getProductDetails() {
        return productDetails;
    }

    public void setProductDetails(Set<ProductDetail> productDetails) {
        this.productDetails = productDetails;
    }

    /*
     * toString Method
     */

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", stockQuantity=" + stockQuantity +
                ", status=" + status +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                '}';
    }

    /*
     * Methods
     */
    @PrePersist
    @PreUpdate
    public void onCreate() {
        this.updatedAt = LocalDateTime.now();
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }

        if (this.stockQuantity == null || this.stockQuantity <= 0) {
            this.status = ProductStatus.OUT_OF_STOCK;
        } else if (this.status == null || this.status == ProductStatus.OUT_OF_STOCK) {
            this.status = ProductStatus.ACTIVE;
        }
    }

    // Check if the product is available for sale
    public boolean isAvailable() {
        return this.status == ProductStatus.ACTIVE;
    }

    // Check if the product is in stock
    public boolean isInStock() {
        return this.stockQuantity != null && this.stockQuantity > 0 && this.status != ProductStatus.OUT_OF_STOCK;
    }

    // Check if the product has a discount
    public boolean hasDiscount() {
        return this.discountPercent != null && this.discountPercent > 0;
    }
}
