package com.store.electro.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.store.electro.Models.DTO.ProductRequest;
import com.store.electro.Models.Entity.Category;
import com.store.electro.Models.Entity.Product;
import com.store.electro.Repositories.CategoryRepository;
import com.store.electro.Repositories.ProductRepository;

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
    public Product createProduct(ProductRequest request) {
        Category category = categoryRepository.findById(request.getCategoryId())
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + request.getCategoryId()));

        Product product = new Product(
                request.getName(),
                request.getPrice(),
                request.getDiscountPercent(),
                request.getShortDescription(),
                request.getDescription(),
                null,
                category
        );
        product.setStockQuantity(request.getStockQuantity());
        return productRepository.save(product);
    }

    @Override
    public Product updateProduct(Long productId, ProductRequest request) {
        return productRepository.findById(productId)
                .map(existingProduct -> {
                    existingProduct.setName(request.getName());
                    existingProduct.setPrice(request.getPrice());
                    existingProduct.setDiscountPercent(request.getDiscountPercent());
                    existingProduct.setShortDescription(request.getShortDescription());
                    existingProduct.setDescription(request.getDescription());
                    existingProduct.setStockQuantity(request.getStockQuantity());
                    Category category = categoryRepository.findById(request.getCategoryId())
                            .orElseThrow(() -> new RuntimeException("Category not found with id: " + request.getCategoryId()));
                    existingProduct.setCategory(category);
                    return productRepository.save(existingProduct);
                })
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + productId));
    }

    @Override
    public void deleteProduct(Long productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + productId));
        productRepository.delete(product);
    }

    @Override
    public Product getProductById(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public List<Product> getProductsByCategory(Long categoryId) {
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
