package com.store.electro.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.store.electro.Models.Entity.Product.ProductVariant;

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
}
