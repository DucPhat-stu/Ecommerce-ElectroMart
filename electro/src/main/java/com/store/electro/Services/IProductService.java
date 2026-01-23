package com.store.electro.Services;

import java.util.List;

import com.store.electro.Models.DTO.ProductRequest;
import com.store.electro.Models.Entity.Product;

public interface IProductService {

    Product createProduct(ProductRequest request);

    Product updateProduct(Long productId, ProductRequest request);

    void deleteProduct(Long productId);

    Product getProductById(Long productId);

    List<Product> getAllProducts();

    List<Product> getProductsByCategory(Long categoryId);

    Product findProductByName(String productName);
}
