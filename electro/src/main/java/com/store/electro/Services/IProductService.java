package com.store.electro.Services;

import com.store.electro.Models.Entity.Product;
import com.store.electro.Request.AddProductRequest;
import com.store.electro.Request.ProductUpdateRequest;

import java.util.List;

public interface IProductService {
    Product addProduct(AddProductRequest product);

    Product updateProduct(ProductUpdateRequest product, Long productId );

    void deleteProduct(Long productId);

    Product getProductById(Long productId);

    List<Product> getAllProducts();

    List<Product> findByCategoryId(Long categoryId);

    Product findProductByName(String productName);
}
