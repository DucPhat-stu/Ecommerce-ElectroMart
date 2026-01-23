package com.store.electro.Controllers;

import com.store.electro.Models.Entity.Product;
import com.store.electro.Request.AddProductRequest;
import com.store.electro.Request.ProductUpdateRequest;
import com.store.electro.Response.ApiResponse;
import com.store.electro.Services.IProductService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ProductController {

    private final IProductService productService;

    public ProductController(IProductService productService) {
        this.productService = productService;
    }

    // Lists of products by category ID
    @GetMapping("v1/category/products/{categoryId}")
    public ResponseEntity<ApiResponse> getAllProductByCategory(@PathVariable Long categoryId) {
        List<Product> products = productService.findByCategoryId(categoryId);
        return ResponseEntity.ok(new ApiResponse("success", products));
    }

    // Get a lists of all products
    @GetMapping("v1/products")
    public ResponseEntity<ApiResponse> getAllProducts(){
        List<Product> products = productService.getAllProducts();
        return ResponseEntity.ok(new ApiResponse("success", products));
    }

    // Find a product by product ID
    @GetMapping("v1/product/{productId}")
    public ResponseEntity<ApiResponse> getProductById(@PathVariable Long productId) {
        Product product = productService.getProductById(productId);
        return ResponseEntity.ok(new ApiResponse("success", product));
    }

    // Creating a new product
    @PostMapping("v1/product")
    public ResponseEntity<ApiResponse> addProduct(@Valid @RequestBody AddProductRequest addProductRequest) {
        Product newProduct = productService.addProduct(addProductRequest);
        return ResponseEntity.ok(new ApiResponse("Created success", newProduct));
    }

    // Deleting a product
    @DeleteMapping("v1/product/{productId}")
    public ResponseEntity<ApiResponse> deleteProductById(@PathVariable Long productId) {
        productService.deleteProduct(productId);
        return ResponseEntity.status(204).body(new ApiResponse("Deleted success", null));
    }

    // Updating a existing product
    @PutMapping("v1/product/{productId}")
    public ResponseEntity<ApiResponse> updateProduct
    (
            @Valid
            @RequestBody ProductUpdateRequest updateRequest,
            @PathVariable("productId") Long productId
    ) {
        productService.updateProduct(updateRequest, productId);
        return ResponseEntity.ok(new ApiResponse("Updated success", null));
    }
}
