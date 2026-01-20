package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTO.ProductRequest;
import com.store.electro.Models.Entity.Product;
import com.store.electro.Services.ProductService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("/api/v1")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/products")
    public ResponseEntity<ApiResponse<List<Product>>> getAllProducts() {
        try {
            List<Product> products = productService.getAllProducts();
            return ResponseEntity.ok(ApiResponse.success("Products retrieved successfully", products));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to retrieve products", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @GetMapping("/products/{id}")
    public ResponseEntity<ApiResponse<Product>> getProduct(@PathVariable Long id) {
        try {
            Product product = productService.getProductById(id);
            return ResponseEntity.ok(ApiResponse.success("Product found", product));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404)
                    .body(ApiResponse.error("Product not found", "PRODUCT_NOT_FOUND", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to retrieve product", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @GetMapping("/products/category/{categoryId}")
    public ResponseEntity<ApiResponse<List<Product>>> getProductsByCategory(@PathVariable Long categoryId) {
        try {
            List<Product> products = productService.getProductsByCategory(categoryId);
            return ResponseEntity.ok(ApiResponse.success("Products retrieved successfully", products));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to retrieve products", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @PostMapping("/products")
    public ResponseEntity<ApiResponse<Product>> createProduct(@RequestBody ProductRequest request) {
        try {
            Product product = productService.createProduct(request);
            return ResponseEntity.status(201).body(ApiResponse.success("Product created successfully", product));
        } catch (Exception e) {
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to create product", "VALIDATION_ERROR", e.getMessage()));
        }
    }

    @PutMapping("/products/{id}")
    public ResponseEntity<ApiResponse<Product>> updateProduct(@PathVariable Long id,
            @RequestBody ProductRequest request) {
        try {
            Product product = productService.updateProduct(id, request);
            return ResponseEntity.ok(ApiResponse.success("Product updated successfully", product));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404)
                    .body(ApiResponse.error("Product not found", "PRODUCT_NOT_FOUND", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to update product", "VALIDATION_ERROR", e.getMessage()));
        }
    }

    @DeleteMapping("/products/{id}")
    public ResponseEntity<ApiResponse<Void>> deleteProduct(@PathVariable Long id) {
        try {
            productService.deleteProduct(id);
            return ResponseEntity.ok(ApiResponse.success("Product deleted successfully", null));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404)
                    .body(ApiResponse.error("Product not found", "PRODUCT_NOT_FOUND", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to delete product", "INTERNAL_ERROR", e.getMessage()));
        }
    }
}
