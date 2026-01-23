package com.store.electro.Services;

import java.util.List;

import com.store.electro.Models.Entity.Product;
import com.store.electro.Models.DTOs.Request.AddProductRequest;
import com.store.electro.Models.DTOs.Request.ProductUpdateRequest;

public interface IProductService {
    Product addProduct(AddProductRequest product);

    Product updateProduct(ProductUpdateRequest product, Long productId );

    void deleteProduct(Long productId);

    Product getProductById(Long productId);

    List<Product> getAllProducts();

    List<Product> getProductsByCategory(Long categoryId);

    Product findProductByName(String productName);
}
