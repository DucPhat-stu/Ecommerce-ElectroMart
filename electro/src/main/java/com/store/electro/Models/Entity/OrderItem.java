package com.store.electro.Models.Entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
import jakarta.persistence.PrePersist;
import jakarta.persistence.Table;

@JsonPropertyOrder({ "id", "productId", "productName", "productPrice", "discountPercent", "quantity", "subtotal" })
@Entity
@Table(name = "order_items")
public class OrderItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "orderId", nullable = false)
    @JsonBackReference
    private Order order;

    @Column(name = "productId", nullable = false)
    private Long productId;

    @Column(name = "productName", nullable = false)
    private String productName;

    @Column(name = "productPrice", nullable = false)
    private BigDecimal productPrice;

    @Column(name = "discountPercent")
    private Integer discountPercent = 0;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "subtotal", nullable = false)
    private BigDecimal subtotal;

    @Column(name = "createdAt")
    private LocalDateTime createdAt;

    public OrderItem() {
    }

    public OrderItem(Long productId, String productName, BigDecimal productPrice, Integer discountPercent,
            Integer quantity, BigDecimal subtotal) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.discountPercent = discountPercent;
        this.quantity = quantity;
        this.subtotal = subtotal;
    }

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

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
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
    }

    public Integer getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
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

    @PrePersist
    public void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    @Override
    public String toString() {
        return "OrderItem [id=" + id + ", productName=" + productName + ", quantity=" + quantity + ", subtotal="
                + subtotal + "]";
    }
}