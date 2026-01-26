package com.store.electro.Models.Entity.Product;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
import jakarta.persistence.Version;

@JsonPropertyOrder({
        "product",
        "storageSize",
        "discountPercent",
        "finalPrice",
        "status",
        "createdAt",
        "updatedAt"
})
@Entity
@Table(name = "product_variants")
public class ProductVariant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    @JsonBackReference
    private Product product;

    @Column(name = "price", nullable = false)
    private BigDecimal basePrice;

    @Column(name = "discount_percent")
    private Integer discountPercent = 0;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private ProductStatus status;

    @OneToMany(mappedBy = "variant", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<VariantOption> options = new HashSet<>();

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @Version
    private Long version;

    /*
     * CONSTRUCTORS
     */

    public ProductVariant() {
    }

    public ProductVariant(Product product, BigDecimal price, Integer discountPercent,
            ProductStatus status) {
        this.product = product;
        this.basePrice = price;
        this.discountPercent = discountPercent != null ? discountPercent : 0;
        this.status = status;
    }

    /*
     * GETTERS AND SETTERS
     */

    @JsonIgnore
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public BigDecimal getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent != null ? discountPercent : 0;
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

    public Set<VariantOption> getOptions() {
        return options;
    }

    public void setOptions(Set<VariantOption> options) {
        this.options = options;
    }

    @JsonIgnore
    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    /*
     * Json Property - Final Price after discount
     */
    @JsonProperty("finalPrice")
    public BigDecimal getFinalPrice() {
        return calculatePrice();
    }

    /*
     * toString Method
     */

    @Override
    public String toString() {
        return "ProductVariant{" +
                "id=" + id +
                ", price=" + basePrice +
                ", discountPercent=" + discountPercent +
                ", status=" + status +
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
        if (this.status == null) {
            this.status = ProductStatus.INACTIVE;
        }
        if (this.discountPercent == null) {
            this.discountPercent = 0;
        }
    }

    // Check if the variant is available for sale
    public boolean isAvailable() {
        return this.status == ProductStatus.ACTIVE;
    }

    // Check if the variant has a discount
    public boolean hasDiscount() {
        return this.discountPercent != null && this.discountPercent > 0;
    }

    // Calculate the final price after applying discount
    public BigDecimal calculatePrice() {
        if (status != ProductStatus.ACTIVE) {
            return BigDecimal.ZERO;
        }

        BigDecimal optionExtra = options.stream()
                .map(o ->
                        o.getExtraPrice() == null
                                ? BigDecimal.ZERO
                                : o.getExtraPrice())
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        BigDecimal price = basePrice.add(optionExtra);

        if (discountPercent == null || discountPercent == 0) {
            return price;
        }

        return price.multiply(
                BigDecimal.valueOf(100 - discountPercent)
        ).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
    }
}
