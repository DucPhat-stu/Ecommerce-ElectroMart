package com.store.electro.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.store.electro.Models.Entity.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query("""
            SELECT DISTINCT p FROM Product p
            LEFT JOIN FETCH p.productImages
            WHERE p.category.id = :categoryId
            """)
    List<Product> findByCategoryWithImages(@Param("categoryId") Long categoryId);

    @Query("""
                SELECT p FROM Product p
                LEFT JOIN FETCH p.productImages
                WHERE p.id = :id
            """)
    Optional<Product> findWithImages(@Param("id") Long id);

    @Query("""
                SELECT p FROM Product p
                LEFT JOIN FETCH p.productDetails
                WHERE p.id = :id
            """)
    Optional<Product> findWithDetails(@Param("id") Long id);

}
