package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTOs.Request.ProductRequest.AddProductRequest;
import com.store.electro.Models.DTOs.Request.ProductRequest.UpdateProductRequest;
import com.store.electro.Models.DTOs.Request.StockUpdateRequest;
import com.store.electro.Models.DTOs.Response.ProductResponse;
import com.store.electro.Models.Entity.Product.Product;
import com.store.electro.Models.Entity.Product.ProductVariant;
import com.store.electro.Repositories.ProductVariantRepository;
import com.store.electro.Services.FileStorageService;
import com.store.electro.Services.IProductService;
import com.store.electro.Utils.ApiResponse;

import jakarta.validation.Valid;

@RestController
@RequestMapping("${api.prefix}")
public class ProductController {

    private final IProductService productService;
    private final FileStorageService fileStorageService;
    private final ProductVariantRepository productVariantRepository;

    public ProductController(IProductService productService, FileStorageService fileStorageService,
            ProductVariantRepository productVariantRepository) {
        this.productService = productService;
        this.fileStorageService = fileStorageService;
        this.productVariantRepository = productVariantRepository;
    }

    // Get all products
    @GetMapping("/products")
    public ResponseEntity<ApiResponse<List<ProductResponse>>> getAllProducts() {
        List<ProductResponse> products = productService.getAllProductsAsResponse();
        return ResponseEntity
                .ok(ApiResponse.success("Products retrieved successfully", products));
    }

    // Get product by ID
    @GetMapping("/product/{productId}")
    public ResponseEntity<ApiResponse<ProductResponse>> getProductById(@PathVariable Long productId) {
        ProductResponse product = productService.getProductByIdAsResponse(productId);
        return ResponseEntity
                .ok(ApiResponse.success("Product found", product));
    }

    // Get products by category
    @GetMapping("/products/category/{categoryId}")
    public ResponseEntity<ApiResponse<List<ProductResponse>>> getProductsByCategory(@PathVariable Long categoryId) {
        List<ProductResponse> products = productService.getProductsByCategoryAsResponse(categoryId);
        return ResponseEntity
                .ok(ApiResponse.success("Products retrieved successfully", products));
    }

    // Creating a new product
    @PostMapping("/product")
    public ResponseEntity<ApiResponse<Product>> createProduct(@ModelAttribute AddProductRequest request) {
        Product product = productService.addProduct(request, fileStorageService);
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
            @ModelAttribute UpdateProductRequest request,
            @PathVariable Long productId) {
        productService.updateProduct(request, productId, fileStorageService);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Product updated successfully", null));
    }

    // Admin: add more stock to a product variant
    @PostMapping("/admin/product/{variantId}/stock/add")
    public ResponseEntity<ApiResponse<ProductVariant>> addStock(
            @PathVariable Long variantId,
            @Valid @org.springframework.web.bind.annotation.RequestBody StockUpdateRequest request) {
        if (request.getQuantity() == null || request.getQuantity() <= 0) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error("Quantity must be > 0", "BAD_REQUEST", "Invalid quantity"));
        }
        ProductVariant variant = productVariantRepository.findById(variantId)
                .orElseThrow(() -> new RuntimeException("Product variant not found with id: " + variantId));
        int current = variant.getStock() != null ? variant.getStock() : 0;
        variant.setStock(current + request.getQuantity());
        productVariantRepository.save(variant);
        return ResponseEntity.ok(ApiResponse.success("Stock added", variant));
    }
}
