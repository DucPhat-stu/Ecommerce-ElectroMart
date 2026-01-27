package com.store.electro.Repositories;

import com.store.electro.Models.Entity.Product.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Find products list by category ID with images and details
    @Query("""
            SELECT DISTINCT p FROM Product p
            LEFT JOIN FETCH p.productImages
            LEFT JOIN FETCH p.productDetails
            WHERE p.category.id = :categoryId
            """)
    List<Product> findByCategoryId(@Param("categoryId") Long categoryId);

    @Query("""
            SELECT DISTINCT p FROM Product p
            LEFT JOIN FETCH p.productImages
            LEFT JOIN FETCH p.productDetails
            WHERE p.name = :productName
            """)
    Product findByName(@Param("productName") String productName);
}
