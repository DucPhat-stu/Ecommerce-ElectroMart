package com.store.electro.Services;

import java.util.List;

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
        Category category = categoryRepository.findById(newProduct.getCategory().getId())
                .orElseGet(() -> {
                    Category newCategory = new Category(
                            newProduct.getCategory().getName()
                    );
                    return categoryRepository.save(newCategory);
                });
        newProduct.setCategory(category);
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
        return productRepository.findById(productId)
                .map(existingProduct -> updateExistingProduct(existingProduct, request))
                .map(productRepository :: save)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + productId));
    }

    // Helper
    private Product updateExistingProduct(Product existingProduct, ProductUpdateRequest request) {
        existingProduct.setName(request.getName());
        existingProduct.setPrice(request.getPrice());
        existingProduct.setDiscountPercent(request.getDiscountPercent());
        existingProduct.setShortDescription(request.getShortDescription());
        existingProduct.setDescription(request.getDescription());
        existingProduct.setStatus(request.getStatus());

        Category category = categoryRepository.findById(request.getCategory().getId())
                        .orElseThrow(() -> new RuntimeException("Category not found"));
        existingProduct.setCategory(category);
        return productRepository.save(existingProduct);
    }

    @Override
    public void deleteProduct(Product product) {

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
    public List<Product> findByCategoryId(Long categoryId) {
        return productRepository.findByCategoryId(categoryId);
    }

    @Override
    public Product findProductByName(String productName) {
        return null;
    }
}
