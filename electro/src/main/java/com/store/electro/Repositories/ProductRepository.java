package com.store.electro.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.store.electro.Models.Entity.Product;


@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Find products list by category ID
    @Query("""
            SELECT p FROM Product p
            WHERE p.category.id =:categoryId
            """)
    List<Product> findByCategory(@RequestParam("categoryId") Long categoryId);

}
