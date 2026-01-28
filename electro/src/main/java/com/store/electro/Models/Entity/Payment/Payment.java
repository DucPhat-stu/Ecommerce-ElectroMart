package com.store.electro.Models.Entity.Payment;

import com.store.electro.Models.Entity.Order;
import com.store.electro.Models.Enums.PaymentMethod;
import com.store.electro.Models.Enums.PaymentStatus;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;


@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Order Reference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    // Payment Method
    @Enumerated(EnumType.STRING)
    @Column(name = "method", length = 30, nullable = false)
    private PaymentMethod method;

    // Amount
    @Column(name = "amount", nullable = false)
    private BigDecimal amount;

    // Status
    @Enumerated(EnumType.STRING)
    @Column(name = "status", length = 30)
    private PaymentStatus status;

    // Transaction ID
    @Column(name = "transaction_id")
    private String transactionId;

    // Created At
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @PrePersist
    public void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.status = PaymentStatus.INITIATED;
    }

    /*
     * CONSTRUCTORS
     */

    public Payment() {
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

    public PaymentMethod getMethod() {
        return method;
    }

    public void setMethod(PaymentMethod method) {
        this.method = method;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public PaymentStatus getStatus() {
        return status;
    }

    public void setStatus(PaymentStatus status) {
        this.status = status;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    /*
     * Methods
     */

}
