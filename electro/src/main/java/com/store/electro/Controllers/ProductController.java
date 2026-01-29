package com.store.electro.Controllers;

import java.util.List;

import com.store.electro.Models.DTOs.Request.ProductRequest.UpdateProductRequest;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.store.electro.Models.DTOs.Request.ProductRequest.AddProductRequest;
import com.store.electro.Models.Entity.Product.Product;
import com.store.electro.Services.IProductService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("${api.prefix}")
public class ProductController {

    private final IProductService productService;

    public ProductController(IProductService productService) {
        this.productService = productService;
    }

    // Get all products
    @GetMapping("/products")
    public ResponseEntity<ApiResponse<List<Product>>> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        return ResponseEntity
                .ok(ApiResponse.success("Products retrieved successfully", products));
    }

    // Get product by ID
    @GetMapping("/products/{productId}")
    public ResponseEntity<ApiResponse<Product>> getProductById(@PathVariable Long productId) {
        Product product = productService.getProductById(productId);
        return ResponseEntity
                .ok(ApiResponse.success("Product found", product));
    }

    // Get products by category
    @GetMapping("/products/category/{categoryId}")
    public ResponseEntity<ApiResponse<List<Product>>> getProductsByCategory(@PathVariable Long categoryId) {
        List<Product> products = productService.getProductsByCategory(categoryId);
        return ResponseEntity
                .ok(ApiResponse.success("Products retrieved successfully", products));
    }

    // Creating a new product
    @PostMapping("/products")
    public ResponseEntity<ApiResponse<Product>> createProduct(@RequestBody AddProductRequest request) {
        Product product = productService.addProduct(request);
        return ResponseEntity.status(201)
                .body(ApiResponse.success("Product created successfully", product));
    }

    // Deleting a product
    @DeleteMapping("/products/{productId}")
    public ResponseEntity<ApiResponse<Void>> deleteProductById(@PathVariable Long productId) {
        productService.deleteProduct(productId);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Product deleted successfully", null));
    }

    // Updating existing product
    @PutMapping("/products/{productId}")
    public ResponseEntity<ApiResponse<Product>> updateProduct(
            @Valid
            @RequestBody UpdateProductRequest request,
            @PathVariable Long productId) {
        productService.updateProduct(request, productId);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Product updated successfully", null));
    }
}
