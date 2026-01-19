package com.store.electro.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
<<<<<<< HEAD

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
=======
import org.springframework.stereotype.Repository;

import com.store.electro.Models.Entity.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Find products list by category ID with images
    @Query("""
            SELECT DISTINCT p FROM Product p
            LEFT JOIN FETCH p.productImages
            WHERE p.category.id = :categoryId
            """)
    List<Product> findByCategoryWithImages(@Param("categoryId") Long categoryId);

    // Find product by ID with images
    @Query("""
            SELECT p FROM Product p
            LEFT JOIN FETCH p.productImages
            WHERE p.id = :id
            """)
>>>>>>> af3adb4 (Update product, category, order models)
    Optional<Product> findWithImages(@Param("id") Long id);

}
