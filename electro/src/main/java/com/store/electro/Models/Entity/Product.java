package com.store.electro.Models.Entity;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonProperty;
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

@JsonPropertyOrder({ "id", "name", "price", "discountPercent", "finalPrice", "shortDescription", "description",
        "status", "createdAt", "updatedAt", "categoryName", "productImages", "productDetails" })
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
    @Column(name = "discount_percent")
    private Integer discountPercent = 0;

    // Product Short Description
    @Column(name = "short_description")
    private String shortDescription;

    // Product Description
    @Column(name = "description")
    private String description;

    // Product Status
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private ProductStatus status;

    // Created At
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    // Updated At
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Product Category
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
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

    public Product(String name, BigDecimal price, Integer discountPercent, String shortDescription, String description, ProductStatus status, Category category) {
        this.name = name;
        this.price = price;
        this.discountPercent = discountPercent;
        this.shortDescription = shortDescription;
        this.description = description;
        this.status = status;
        this.category = category;
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

    @JsonIgnore
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

    // Json Property
    @JsonProperty("categoryName")
    public String getCategoryName() {
        return category != null ? category.getName() : null;
    }

    // GETTER for applying discount for finalPrice
    @JsonProperty("finalPrice")
    public BigDecimal getFinalPrice() {
        return calculatePrice();
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
            if (this.status == null) {
                this.status = ProductStatus.INACTIVE;
            }
        }
    }

    // Check if the product is available for sale
    public boolean isAvailable() {
        return this.status == ProductStatus.ACTIVE;
    }

    // Check if the product has a discount
    public boolean hasDiscount() {
        return this.discountPercent != null && this.discountPercent > 0;
    }

    // Calculate the final price after applying discount
    public BigDecimal calculatePrice() {
        if (this.price == null || !isAvailable()) {
            return BigDecimal.ZERO;
        }

        if (!hasDiscount()) {
            return this.price;
        }

        BigDecimal discountPer = BigDecimal.valueOf(discountPercent);
        BigDecimal hundred = BigDecimal.valueOf(100);

        return price
                .multiply(hundred.subtract(discountPer))
                .divide(hundred, 2, RoundingMode.HALF_UP);
    }

}
