package com.store.electro.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.store.electro.Models.Entity.ProductVariant;

@Repository
public interface ProductVariantRepository extends JpaRepository<ProductVariant, Long> {

    // Find variants by product ID
    @Query("""
            SELECT pv FROM ProductVariant pv
            WHERE pv.product.id = :productId
            """)
    List<ProductVariant> findByProductId(@Param("productId") Long productId);

    // Find variants by product ID with available status
    @Query("""
            SELECT pv FROM ProductVariant pv
            WHERE pv.product.id = :productId
            AND pv.status = 'ACTIVE'
            """)
    List<ProductVariant> findAvailableByProductId(@Param("productId") Long productId);

    // Find variant by product ID, color and storage size
    @Query("""
            SELECT pv FROM ProductVariant pv
            WHERE pv.product.id = :productId
            AND pv.color = :color
            AND pv.storageSize = :storageSize
            """)
    ProductVariant findByProductIdAndColorAndStorageSize(
            @Param("productId") Long productId,
            @Param("color") String color,
            @Param("storageSize") String storageSize
    );
}
