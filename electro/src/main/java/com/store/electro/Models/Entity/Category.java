package com.store.electro.Models.Entity;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.store.electro.Models.Enums.CategoryStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;

@JsonPropertyOrder({ "id", "name", "parentId", "status", "createdAt" })
@Entity
@Table(name = "categories")
public class Category {

    // Category ID
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Category Name
    @Column(name = "name")
    private String name;

    // Parent Category ID
    @Column(name = "parentId")
    private Long parentId;

    // Category Status
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private CategoryStatus status;

    // Creation Timestamp
    @Column(name = "createdAt")
    private LocalDateTime createdAt;

    /*
     * CONSTRUCTORS
     */
    public Category() {
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

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public CategoryStatus getStatus() {
        return status;
    }

    public void setStatus(CategoryStatus status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    /*
     * toString Method
     */

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", parentId=" + parentId +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }

    /*
     * Methods
     */

    // Automatically set createdAt and default status before persisting or updating
    @PrePersist
    @PreUpdate
    public void onCreate() {
        // Set createdAt nếu chưa có
        if (this.createdAt == null) {
            this.createdAt = LocalDateTime.now();
        }

        // Nếu status null, mặc định ACTIVE
        if (this.status == null) {
            this.status = CategoryStatus.ACTIVE;
        }
    }

    // Check if the category is a leaf (no parent)
    public boolean isLeaf() {
        return this.parentId != null;
    }

}
