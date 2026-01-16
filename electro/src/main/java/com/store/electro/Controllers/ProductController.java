package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.Entity.Product;
import com.store.electro.Repositories.ProductRepository;

import jakarta.persistence.EntityNotFoundException;


@RestController
@RequestMapping("/api")
public class ProductController {

    private final ProductRepository repo;

    public ProductController(ProductRepository repo) {
        this.repo = repo;
    }

    @GetMapping("v1/products/{id}")
    public ResponseEntity<Product> getProduct(@PathVariable Long id) {
        Product p = repo.findById(id)
            .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + id));
        
        // Trigger lazy load images and details
        p.getProductImages().size();
        p.getProductDetails().size();

        return ResponseEntity.ok(p);
    }
    

    @GetMapping("v1/category/products/{categoryId}")
    public ResponseEntity<List<Product>> getProducts(@PathVariable Long categoryId) {
        List<Product> products = repo.findByCategory(categoryId);
        products.forEach(product -> {
            // Trigger lazy load Images and Details
            product.getProductDetails().size();
            product.getProductImages().size();
        });
        return ResponseEntity.ok(products);
    }

}
