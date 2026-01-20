package com.store.electro.Models.Entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@JsonPropertyOrder({ "id", "productId", "productName", "productPrice", "discountPercent" ,"quantity", "subtotal", "createdAt" })
@Entity
@Table(name = "order_details")
public class OrderDetail {

    // ID
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Order ID Reference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    @JsonBackReference
    private Order order;

    // Product ID Reference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    @JsonBackReference
    private Product product;

    // Product Name
    @Column(name = "product_name", nullable = false)
    private String productName;

    // Product Price at the time of order
    @Column(name = "product_price", nullable = false)
    private BigDecimal productPrice;

    // Quantity
    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    // Subtotal
    @Column(name = "subtotal", nullable = false)
    private BigDecimal subtotal;

    // Created At
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    /*
     * CONSTRUCTORS
     */

    public OrderDetail() {
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

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
        calculateSubtotal();
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
        calculateSubtotal();
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    // Json Property
    @JsonProperty("productId")
    public Long getProductId() {
        return product != null ? product.getId() : null;
    }

    @JsonProperty("discountPercent")
    public Integer getDiscountPercent(){
        return product != null ? product.getDiscountPercent() : null;
    }

    /*
     * toString Method
     */
    @Override
    public String toString() {
        return "OrderItem{" +
                "id=" + id +
                ", productName='" + productName + '\'' +
                ", productPrice=" + productPrice +
                ", quantity=" + quantity +
                ", subtotal=" + subtotal +
                '}';
    }

    /*
     * Methods
     */

    @PrePersist
    public void onCreate() {
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }
        calculateSubtotal();
    }

    private void calculateSubtotal() {
        if (productPrice != null && quantity != null) {
            this.subtotal = productPrice.multiply(BigDecimal.valueOf(quantity));
        }
    }

}
