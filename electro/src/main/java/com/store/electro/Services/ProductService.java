package com.store.electro.Services;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.store.electro.Exceptions.ResourceNotFoundException;
import com.store.electro.Models.DTOs.Request.AddProductRequest;
import com.store.electro.Models.DTOs.Request.UpdateProductRequest;
import com.store.electro.Models.Entity.Brand;
import com.store.electro.Models.Entity.Category;
import com.store.electro.Models.Entity.Product.Product;
import com.store.electro.Models.Entity.Product.ProductImage;
import com.store.electro.Repositories.BrandRepository;
import com.store.electro.Repositories.CategoryRepository;
import com.store.electro.Repositories.ProductRepository;

@Service
public class ProductService implements IProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final BrandRepository brandRepository;

    public ProductService(
            ProductRepository productRepository,
            CategoryRepository categoryRepository,
            BrandRepository brandRepository)
    {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.brandRepository = brandRepository;
    }

    @Override
    public Product addProduct(AddProductRequest request) {
        Category category = categoryRepository.findById(request.getCategoryId())
                .orElseThrow(
                        () -> new ResourceNotFoundException("Category not found")
                );
        Brand brand = brandRepository.findById(request.getBrandId())
                .orElseThrow(
                        () -> new ResourceNotFoundException("Brand not found")
                );

        Product product = new Product();
                product.setName(request.getName());
                product.setShortDescription(request.getShortDescription());
                product.setDescription(request.getDescription());
                product.setStatus(request.getStatus());
                product.setCategory(category);


        Set<ProductImage> images = request.getProductImages()
                .stream()
                .map(imgReq -> {
                    ProductImage imgs = new ProductImage();
                    imgs.setImageUrl(imgReq.getImageUrl());
                    imgs.setIsPrimary(imgReq.isPrimary());

                    imgs.setProduct(product);
                    return imgs;
                })
                .collect(Collectors.toSet());
        product.setProductImages(images);


        // Set<ProductDetail> details = request.getProductDetails()
        //         .stream()
        //         .map(detailReq -> {
        //             ProductDetail detail = new ProductDetail();
        //             detail.setAttributeName(detailReq.getAttributeName());
        //             detail.setAttributeValue(detailReq.getAttributeValue());

        //             detail.setProduct(product);
        //             return detail;
        //         })
        //         .collect(Collectors.toSet());
        // product.setProductDetails(details);

//        Set<ProductVariant> variants = request.getProductVariants()
//                .steam()
//                .map(variantReq -> {
//                    ProductVariant variant = new ProductVariant();
//                    variant.setProduct(product);
//                    variant.setColor(variantReq.getColor());
//                })

        return productRepository.save(product);
    }

    @Override
    public Product updateProduct(UpdateProductRequest request, Long productId) {
        return productRepository.findById(productId)
                .map(existingProduct -> {
                    existingProduct.setName(request.getName());
                    existingProduct.setShortDescription(request.getShortDescription());
                    existingProduct.setDescription(request.getDescription());
                    Category category = categoryRepository.findById(request.getCategoryId())
                            .orElseThrow(() -> new ResourceNotFoundException(
                                    "Category not found with id: " + request.getCategoryId()));
                    existingProduct.setCategory(category);
                    return productRepository.save(existingProduct);
                })
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + productId));
    }

    @Override
    public void deleteProduct(Long productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + productId));
        productRepository.delete(product);
    }

    @Override
    public Product getProductById(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + productId));
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
                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));
    }
}
