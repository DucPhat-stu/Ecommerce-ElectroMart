package com.store.electro.Services;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.store.electro.Exceptions.ResourceNotFoundException;
import com.store.electro.Models.DTOs.Request.ProductRequest.AddProductRequest;
import com.store.electro.Models.DTOs.Request.ProductRequest.UpdateProductRequest;
import com.store.electro.Models.Entity.Brand;
import com.store.electro.Models.Entity.Category;
import com.store.electro.Models.Entity.Product.Product;
import com.store.electro.Models.Entity.Product.ProductDetail;
import com.store.electro.Models.Entity.Product.ProductImage;
import com.store.electro.Models.Entity.Product.ProductOption;
import com.store.electro.Models.Entity.Product.ProductVariant;
import com.store.electro.Models.Entity.Product.VariantOption;
import com.store.electro.Repositories.BrandRepository;
import com.store.electro.Repositories.CategoryRepository;
import com.store.electro.Repositories.ProductOptionRepository;
import com.store.electro.Repositories.ProductRepository;

import jakarta.transaction.Transactional;

@Service
public class ProductService implements IProductService {

        private final ProductRepository productRepository;
        private final CategoryRepository categoryRepository;
        private final BrandRepository brandRepository;
        private final ProductOptionRepository productOptionRepository;

        public ProductService(
                        ProductRepository productRepository,
                        CategoryRepository categoryRepository,
                        BrandRepository brandRepository,
                        ProductOptionRepository productOptionRepository) {
                this.productRepository = productRepository;
                this.categoryRepository = categoryRepository;
                this.brandRepository = brandRepository;
                this.productOptionRepository = productOptionRepository;
        }

        // Creating a new product
        @Override
        @Transactional
        public Product addProduct(AddProductRequest request, FileStorageService fileStorageService) {

                Category category = categoryRepository.findById(request.getCategoryId())
                                .orElseThrow(
                                                () -> new ResourceNotFoundException("Category not found"));
                Brand brand = brandRepository.findById(request.getBrandId())
                                .orElseThrow(
                                                () -> new ResourceNotFoundException("Brand not found"));

                Product product = new Product();
                product.setName(request.getName());
                product.setShortDescription(request.getShortDescription());
                product.setDescription(request.getDescription());
                product.setStatus(request.getStatus());
                product.setCategory(category);
                product.setBrand(brand);

                // First save product to get ID
                product = productRepository.save(product);
                final Product savedProduct = product;
                final Long productId = product.getId();

                Set<ProductImage> images = Optional.ofNullable(request.getProductImages())
                                .orElse(List.of())
                                .stream()
                                .map(imgReq -> {
                                        ProductImage imgs = new ProductImage();
                                        
                                        // Handle file upload if imageFile is provided
                                        if (imgReq.getImageFile() != null && !imgReq.getImageFile().isEmpty()) {
                                                try {
                                                        String imageUrl = fileStorageService.saveProductImage(imgReq.getImageFile(), productId);
                                                        imgs.setImageUrl(imageUrl);
                                                } catch (IOException e) {
                                                        throw new RuntimeException("Failed to save image: " + e.getMessage());
                                                }
                                        } else if (imgReq.getImageUrl() != null && !imgReq.getImageUrl().isEmpty()) {
                                                // If imageUrl is provided directly, use it
                                                imgs.setImageUrl(imgReq.getImageUrl());
                                        }
                                        
                                        imgs.setIsPrimary(imgReq.isPrimary());
                                        imgs.setProduct(savedProduct);
                                        return imgs;
                                })
                                .collect(Collectors.toSet());
                product.setProductImages(images);

                Set<ProductDetail> details = Optional.ofNullable(request.getProductDetails())
                                .orElse(List.of())
                                .stream()
                                .map(detailReq -> {
                                        ProductDetail detail = new ProductDetail();
                                        detail.setAttributeName(detailReq.getAttributeName());
                                        detail.setAttributeValue(detailReq.getAttributeValue());

                                        detail.setProduct(savedProduct);
                                        return detail;
                                })
                                .collect(Collectors.toSet());
                product.setProductDetails(details);

                // Creating list of variants
                Set<ProductVariant> variants = Optional.ofNullable(request.getProductVariants())
                                .orElse(List.of())
                                .stream()
                                .map(variantReq -> {
                                        ProductVariant variant = new ProductVariant();
                                        variant.setProduct(savedProduct);
                                        variant.setBasePrice(variantReq.getBasePrice());
                                        variant.setDiscountPercent(variantReq.getDiscountPercent());
                                        variant.setStatus(variantReq.getStatus());

                                        // Creating list of options for variants
                                        Set<VariantOption> options = Optional.ofNullable(variantReq.getOptions())
                                                        .orElse(List.of())
                                                        .stream()
                                                        .map(optionReq -> {
                                                                ProductOption option = productOptionRepository
                                                                                .findById(optionReq.getOptionId())
                                                                                .orElseThrow(() -> new ResourceNotFoundException(
                                                                                                "Product option not found"));

                                                                VariantOption variantOption = new VariantOption();
                                                                variantOption.setOption(option);
                                                                variantOption.setValue(optionReq.getValue());
                                                                variantOption.setExtraPrice(optionReq.getExtraPrice());
                                                                variantOption.setVariant(variant);
                                                                return variantOption;
                                                        })
                                                        .collect(Collectors.toSet());

                                        variant.setOptions(options);
                                        return variant;
                                })
                                .collect(Collectors.toSet());
                product.setProductVariants(variants);

                return productRepository.save(product);
        }

        // Updating an existing product
        @Override
        @Transactional
        public Product updateProduct(UpdateProductRequest request, Long productId, FileStorageService fileStorageService) {

                Product product = productRepository.findById(productId)
                                .orElseThrow(() -> new ResourceNotFoundException("Product not found"));

                Category category = categoryRepository.findById(request.getCategoryId())
                                .orElseThrow(() -> new ResourceNotFoundException("Category not found"));

                Brand brand = brandRepository.findById(request.getBrandId())
                                .orElseThrow(() -> new ResourceNotFoundException("Brand not found"));

                // ================= BASIC INFO =================
                product.setName(request.getName());
                product.setShortDescription(request.getShortDescription());
                product.setDescription(request.getDescription());
                product.setStatus(request.getStatus());
                product.setCategory(category);
                product.setBrand(brand);

                // ================= IMAGES =================
                Map<Long, ProductImage> dbImages = product.getProductImages()
                                .stream()
                                .collect(Collectors.toMap(ProductImage::getId, i -> i));

                for (var imgReq : request.getProductImages()) {
                        if (imgReq.getId() != null) {
                                ProductImage img = dbImages.remove(imgReq.getId());
                                if (img == null) {
                                        throw new ResourceNotFoundException(
                                                        "ProductImage not found with id: " + imgReq.getId());
                                }
                                
                                // Handle file upload if new file is provided
                                if (imgReq.getImageFile() != null && !imgReq.getImageFile().isEmpty()) {
                                        try {
                                                String imageUrl = fileStorageService.saveProductImage(imgReq.getImageFile(), productId);
                                                img.setImageUrl(imageUrl);
                                        } catch (IOException e) {
                                                throw new RuntimeException("Failed to save image: " + e.getMessage());
                                        }
                                } else if (imgReq.getImageUrl() != null && !imgReq.getImageUrl().isEmpty()) {
                                        // If imageUrl is provided, update it
                                        img.setImageUrl(imgReq.getImageUrl());
                                }
                                
                                img.setIsPrimary(imgReq.isPrimary());
                        } else {
                                ProductImage img = new ProductImage();
                                
                                // Handle file upload for new image
                                if (imgReq.getImageFile() != null && !imgReq.getImageFile().isEmpty()) {
                                        try {
                                                String imageUrl = fileStorageService.saveProductImage(imgReq.getImageFile(), productId);
                                                img.setImageUrl(imageUrl);
                                        } catch (IOException e) {
                                                throw new RuntimeException("Failed to save image: " + e.getMessage());
                                        }
                                } else if (imgReq.getImageUrl() != null && !imgReq.getImageUrl().isEmpty()) {
                                        img.setImageUrl(imgReq.getImageUrl());
                                }
                                
                                img.setIsPrimary(imgReq.isPrimary());
                                img.setProduct(product);
                                product.getProductImages().add(img);
                        }
                }
                dbImages.values().forEach(product.getProductImages()::remove);

                // ================= DETAILS =================
                Map<Long, ProductDetail> dbDetails = product.getProductDetails()
                                .stream()
                                .collect(Collectors.toMap(ProductDetail::getId, d -> d));

                for (var dReq : request.getProductDetails()) {
                        if (dReq.getId() != null) {
                                ProductDetail detail = dbDetails.remove(dReq.getId());
                                if (detail == null) {
                                        throw new ResourceNotFoundException(
                                                        "ProductDetail not found with id: " + dReq.getId());
                                }
                                detail.setAttributeName(dReq.getAttributeName());
                                detail.setAttributeValue(dReq.getAttributeValue());
                        } else {
                                ProductDetail detail = new ProductDetail();
                                detail.setAttributeName(dReq.getAttributeName());
                                detail.setAttributeValue(dReq.getAttributeValue());
                                detail.setProduct(product);
                                product.getProductDetails().add(detail);
                        }
                }
                dbDetails.values().forEach(product.getProductDetails()::remove);

                // ================= VARIANTS =================
                Map<Long, ProductVariant> dbVariants = product.getProductVariants()
                                .stream()
                                .collect(Collectors.toMap(ProductVariant::getId, v -> v));

                for (var vReq : request.getProductVariants()) {

                        ProductVariant variant;

                        if (vReq.getId() != null) {
                                variant = dbVariants.remove(vReq.getId());
                                if (variant == null) {
                                        throw new ResourceNotFoundException(
                                                        "ProductVariant not found with id: " + vReq.getId());
                                }
                        } else {
                                variant = new ProductVariant();
                                variant.setProduct(product);
                                product.getProductVariants().add(variant);
                        }

                        variant.setBasePrice(vReq.getBasePrice());
                        variant.setDiscountPercent(vReq.getDiscountPercent());
                        variant.setStatus(vReq.getStatus());

                        // -------- VARIANT OPTIONS (CHUẨN) --------
                        Map<Long, VariantOption> dbOptions = variant.getOptions()
                                        .stream()
                                        .collect(Collectors.toMap(VariantOption::getId, o -> o));

                        for (var oReq : vReq.getOptions()) {
                                VariantOption option;

                                // UPDATE
                                if (oReq.getId() != null) {
                                        option = dbOptions.remove(oReq.getId());
                                        if (option == null) {
                                                throw new ResourceNotFoundException(
                                                                "VariantOption not found with id: " + oReq.getId());
                                        }
                                }
                                // INSERT
                                else {
                                        ProductOption productOption = productOptionRepository
                                                        .findById(oReq.getOptionId())
                                                        .orElseThrow(() -> new ResourceNotFoundException(
                                                                        "ProductOption not found with id: "
                                                                                        + oReq.getOptionId()));

                                        option = new VariantOption();
                                        option.setOption(productOption);
                                        option.setVariant(variant);
                                        variant.getOptions().add(option);
                                }

                                option.setValue(oReq.getValue());
                                option.setExtraPrice(oReq.getExtraPrice());
                        }

                        // DELETE OPTIONS NOT IN REQUEST
                        dbOptions.values().forEach(variant.getOptions()::remove);
                }

                // DELETE VARIANTS NOT IN REQUEST
                dbVariants.values().forEach(product.getProductVariants()::remove);

                return productRepository.save(product);
        }

        @Override
        public void deleteProduct(Long productId) {
                Product product = productRepository.findById(productId)
                                .orElseThrow(() -> new ResourceNotFoundException(
                                                "Product not found with id: " + productId));
                productRepository.delete(product);
        }

        @Override
        public Product getProductById(Long productId) {
                return productRepository.findById(productId)
                                .orElseThrow(() -> new ResourceNotFoundException(
                                                "Product not found with id: " + productId));
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
