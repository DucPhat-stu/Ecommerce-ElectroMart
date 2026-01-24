package com.store.electro.Models.Entity;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.persistence.Version;

@JsonPropertyOrder({ "id", "productId", "totalQuantity", "reservedQuantity", "availableQuantity" })
@Entity
@Table(name = "inventories")
public class Inventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_variant_id", nullable = false)
    private ProductVariant productVariant;

    @Column(name = "total_quantity", nullable = false)
    private Integer totalQuantity;

    @Column(name = "reserved_quantity", nullable = false)
    private Integer reservedQuantity;

    @Version
    private Long version;

    /*
     * CONSTRUCTORS
     */

    public Inventory() {
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

    public Integer getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(Integer totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    @Transient
    public Integer getAvailableQuantity() {
        return this.totalQuantity - this.reservedQuantity;
    }

    public Integer getReservedQuantity() {
        return reservedQuantity;
    }

    public void setReservedQuantity(Integer reservedQuantity) {
        this.reservedQuantity = reservedQuantity;
    }

    public ProductVariant getProductVariant() {
        return productVariant;
    }

    public void setProductVariant(ProductVariant productVariant) {
        this.productVariant = productVariant;
    }

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    

    /*
     * toString Method
     */

    @Override
    public String toString() {
        return "Inventory [id=" + id + ", productVariant=" + productVariant + ", totalQuantity=" + totalQuantity
                + ", reservedQuantity=" + reservedQuantity + "]";
    }

    /*
     * Methods
     */

    @PrePersist
    @PreUpdate
    public void validateState() {
        if (totalQuantity < 0 || reservedQuantity < 0) {
            throw new IllegalStateException("Inventory quantity cannot be negative");
        }
        if (reservedQuantity > totalQuantity) {
            throw new IllegalStateException("Reserved exceeds total quantity");
        }
    }

    // Checking if requested quantity is available
    public void checkAvailable(Integer requestedQuantity) {
        // Validate requested quantity
        if ((getAvailableQuantity()) < requestedQuantity) {
            throw new IllegalArgumentException("Insufficient inventory available.");
        }
    }

    // Reserve inventory for an order
    public void reserve(Integer quantity) {
        validateQuantity(quantity);
        checkAvailable(quantity);
        this.reservedQuantity += quantity;
    }

    // Release reserved inventory (e.g., on order cancellation)
    public void release(Integer quantity) {
        validateQuantity(quantity);
        if (quantity > this.reservedQuantity) {
            throw new IllegalArgumentException("Release exceeds reserved quantity");
        }
        this.reservedQuantity -= quantity;
    }

    // Deduct inventory upon order fulfillment
    public void deduct(Integer quantity) {
        validateQuantity(quantity);
        if (quantity > this.reservedQuantity || quantity > this.totalQuantity) {
            throw new IllegalArgumentException("Deduct exceeds reserved quantity");
        }
        this.reservedQuantity -= quantity;
        this.totalQuantity -= quantity;
    }

    // Validate requested quantity
    public void validateQuantity(Integer quantity) {
        if (quantity <= 0)
            throw new IllegalArgumentException("Quantity must be greater than zero");
    }

}
