package com.store.electro.Services;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Models.DTO.ProductRequest;
import com.store.electro.Models.Entity.Category;
import com.store.electro.Models.Entity.Product;
import com.store.electro.Repositories.ProductRepository;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Transactional
    public Product getProductById(Long id) {
        Product product = productRepository.findWithImages(id)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + id));

        // Trigger lazy loading
        product.getProductDetails().size();

        return product;
    }

    @Transactional
    public List<Product> getProductsByCategory(Long categoryId) {
        List<Product> products = productRepository.findByCategoryWithImages(categoryId);
        products.forEach(product -> product.getProductDetails().size());
        return products;
    }

    @Transactional
    public Product createProduct(ProductRequest request) {
        Product product = new Product();
        product.setName(request.getName());
        product.setPrice(request.getPrice());
        product.setDiscountPercent(request.getDiscountPercent());
        product.setShortDescription(request.getShortDescription());
        product.setDescription(request.getDescription());
        product.setStockQuantity(request.getStockQuantity());

        if (request.getCategoryId() != null) {
            Category category = new Category();
            category.setId(request.getCategoryId());
            product.setCategory(category);
        }

        return productRepository.save(product);
    }

    @Transactional
    public Product updateProduct(Long id, ProductRequest request) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + id));

        if (request.getName() != null) {
            product.setName(request.getName());
        }
        if (request.getPrice() != null) {
            product.setPrice(request.getPrice());
        }
        if (request.getDiscountPercent() != null) {
            product.setDiscountPercent(request.getDiscountPercent());
        }
        if (request.getShortDescription() != null) {
            product.setShortDescription(request.getShortDescription());
        }
        if (request.getDescription() != null) {
            product.setDescription(request.getDescription());
        }
        if (request.getStockQuantity() != null) {
            product.setStockQuantity(request.getStockQuantity());
        }
        if (request.getCategoryId() != null) {
            Category category = new Category();
            category.setId(request.getCategoryId());
            product.setCategory(category);
        }

        return productRepository.save(product);
    }

    @Transactional
    public void deleteProduct(Long id) {
        if (!productRepository.existsById(id)) {
            throw new RuntimeException("Product not found with id: " + id);
        }
        productRepository.deleteById(id);
    }
}