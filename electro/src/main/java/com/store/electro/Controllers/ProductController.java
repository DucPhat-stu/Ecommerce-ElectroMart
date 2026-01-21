package com.store.electro.Controllers;

import java.util.ArrayList;
import java.util.List;

import com.store.electro.Exceptions.ResourceNotFoundException;
import com.store.electro.Request.AddProductRequest;
import com.store.electro.Response.ApiResponse;
import com.store.electro.Services.ICategoryService;
import com.store.electro.Services.IProductService;
import com.store.electro.Services.ProductService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.store.electro.Models.Entity.Product;

@RestController
@RequestMapping("/api")
public class ProductController {

    private final IProductService productService;

    public ProductController(IProductService productService) {
        this.productService = productService;
    }

    @GetMapping("v1/category/products/{categoryId}")
    public ResponseEntity<List<Product>> getProducts(@PathVariable Long categoryId) {
        List<Product> products = productService.findByCategoryId(categoryId);
        return ResponseEntity.ok(products);
    }

    @GetMapping("v1/products")
    public ResponseEntity<ApiResponse> getAllProducts(){
        try {
            List<Product> products = productService.getAllProducts();
            return ResponseEntity.ok(new ApiResponse("success", products));
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse(e.getMessage(), null));
        }
    }

    @GetMapping("v1/product/{productId}")
    public ResponseEntity<ApiResponse> getProductById(@PathVariable Long productId) {

        try {
            Product product = productService.getProductById(productId);
            return ResponseEntity.ok(new ApiResponse("success", product));
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse(e.getMessage(), null));
        }
    }
}
