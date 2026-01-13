package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.Entity.Product;
import com.store.electro.Repositories.ProductRepository;

import jakarta.transaction.Transactional;

@RestController
@RequestMapping("/api")
public class ProductController {

    private final ProductRepository repo;

    public ProductController(ProductRepository repo) {
        this.repo = repo;
    }

    @GetMapping("v1/products/{id}")
    @Transactional
    public ResponseEntity<Product> getProduct(@PathVariable Long id) {
        // Lấy Product với Images
        Product product = repo.findWithImages(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        // Trigger lazy load Details
        product.getProductDetails().size();

        return ResponseEntity.ok(product);
    }

    @GetMapping("v1/products/category/{categoryId}")
    public ResponseEntity<List<Product>> getProducts(@PathVariable Long categoryId) {
        List<Product> products = repo.findByCategoryWithImages(categoryId);
        products.forEach(product -> {
            // Trigger lazy load Details
            product.getProductDetails().size();
        });
        return ResponseEntity.ok(products);
    }

}
