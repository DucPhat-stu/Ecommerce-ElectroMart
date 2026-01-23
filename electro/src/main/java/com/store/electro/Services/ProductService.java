package com.store.electro.Services;

import java.util.List;
import java.util.Optional;

import com.store.electro.Exceptions.ResourceNotFoundException;
import org.springframework.stereotype.Service;

import com.store.electro.Models.Entity.Category;
import com.store.electro.Models.Entity.Product;
import com.store.electro.Repositories.CategoryRepository;
import com.store.electro.Repositories.ProductRepository;
import com.store.electro.Request.AddProductRequest;
import com.store.electro.Request.ProductUpdateRequest;

import jakarta.persistence.EntityNotFoundException;

@Service
public class ProductService implements IProductService{

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;

    public ProductService(ProductRepository productRepository,  CategoryRepository categoryRepository) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
    }

    @Override
    public Product addProduct(AddProductRequest newProduct) {
        Category category = categoryRepository.findById(newProduct.getCategoryId())
                        .orElseThrow(
                                () -> new ResourceNotFoundException("Category not found")
                        );
        newProduct.setCategoryId(category.getId());
        return productRepository.save(createProduct(newProduct, category));
    }

    // Helper
    private Product createProduct(AddProductRequest request, Category category) {
        return new Product(
                request.getName(),
                request.getPrice(),
                request.getDiscountPercent(),
                request.getShortDescription(),
                request.getDescription(),
                request.getStatus(),
                category
        );
    }

    @Override
    public Product updateProduct(ProductUpdateRequest request, Long productId) {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(
                        () -> new ResourceNotFoundException("Product not found")
                );
        updateExistingProduct(existingProduct, request);
        return productRepository.save(existingProduct);
    }

    // Helper
    private void updateExistingProduct(Product existingProduct, ProductUpdateRequest request) {
        existingProduct.setName(request.getName());
        existingProduct.setPrice(request.getPrice());
        existingProduct.setDiscountPercent(request.getDiscountPercent());
        existingProduct.setShortDescription(request.getShortDescription());
        existingProduct.setDescription(request.getDescription());
        existingProduct.setStatus(request.getStatus());

        Category category = categoryRepository.findById(request.getCategoryId())
                        .orElseThrow(() -> new ResourceNotFoundException("Category not found"));
        existingProduct.setCategory(category);
    }

    @Override
    public void deleteProduct(Long productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(
                        () -> new ResourceNotFoundException("Product not found")
                );
        productRepository.delete(product);
    }

    @Override
    public Product getProductById(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
    }

    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public List<Product> findByCategoryId(Long categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }

    @Override
    public Product findProductByName(String productName) {
        return Optional.ofNullable(productRepository.findByName(productName))
                .orElseThrow(
                        () -> new ResourceNotFoundException("Product not found")
                );
    }
}
