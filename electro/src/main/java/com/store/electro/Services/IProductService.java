package com.store.electro.Services;

import java.util.List;

import com.store.electro.Models.DTOs.Request.ProductRequest.AddProductRequest;
import com.store.electro.Models.DTOs.Request.ProductRequest.UpdateProductRequest;
import com.store.electro.Models.DTOs.Response.ProductResponse;
import com.store.electro.Models.Entity.Product.Product;

public interface IProductService {
    Product addProduct(AddProductRequest product, FileStorageService fileStorageService);

    Product updateProduct(UpdateProductRequest product, Long productId, FileStorageService fileStorageService);

    void deleteProduct(Long productId);

    Product getProductById(Long productId);

    ProductResponse getProductByIdAsResponse(Long productId);

    List<Product> getAllProducts();

    List<ProductResponse> getAllProductsAsResponse();

    List<Product> getProductsByCategory(Long categoryId);

    List<ProductResponse> getProductsByCategoryAsResponse(Long categoryId);

    Product findProductByName(String productName);
}
