package com.store.electro.Services;

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
import com.store.electro.Models.Enums.ProductStatus;
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
        public Product addProduct(AddProductRequest request) {

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

                Set<ProductImage> images = Optional.ofNullable(request.getProductImages())
                                .orElse(List.of())
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

                Set<ProductDetail> details = Optional.ofNullable(request.getProductDetails())
                                .orElse(List.of())
                                .stream()
                                .map(detailReq -> {
                                        ProductDetail detail = new ProductDetail();
                                        detail.setAttributeName(detailReq.getAttributeName());
                                        detail.setAttributeValue(detailReq.getAttributeValue());

                                        detail.setProduct(product);
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
                                        variant.setProduct(product);
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
        public Product updateProduct(UpdateProductRequest request, Long productId) {

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
                Map<Long, ProductImage> dbImages = Optional.ofNullable(product.getProductImages())
                                .orElse(Set.of())
                                .stream()
                                .collect(Collectors.toMap(ProductImage::getId, i -> i));

                for (var imgReq : Optional.ofNullable(request.getProductImages()).orElse(List.of())) {
                        if (imgReq.getId() != null) {
                                ProductImage img = dbImages.remove(imgReq.getId());
                                if (img == null) {
                                        throw new ResourceNotFoundException(
                                                        "ProductImage not found with id: " + imgReq.getId());
                                }
                                img.setImageUrl(imgReq.getImageUrl());
                                img.setIsPrimary(imgReq.isPrimary());
                        } else {
                                ProductImage img = new ProductImage();
                                img.setImageUrl(imgReq.getImageUrl());
                                img.setIsPrimary(imgReq.isPrimary());
                                img.setProduct(product);
                                product.getProductImages().add(img);
                        }
                }
                dbImages.values().forEach(product.getProductImages()::remove);

                // ================= DETAILS =================
                Map<Long, ProductDetail> dbDetails = Optional.ofNullable(product.getProductDetails())
                                .orElse(Set.of())
                                .stream()
                                .collect(Collectors.toMap(ProductDetail::getId, d -> d));

                for (var dReq : Optional.ofNullable(request.getProductDetails()).orElse(List.of())) {
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
                Map<Long, ProductVariant> dbVariants = Optional.ofNullable(product.getProductVariants())
                                .orElse(Set.of())
                                .stream()
                                .collect(Collectors.toMap(ProductVariant::getId, v -> v));

                for (var vReq : Optional.ofNullable(request.getProductVariants()).orElse(List.of())) {

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
                        Map<Long, VariantOption> dbOptions = Optional.ofNullable(variant.getOptions())
                                        .orElse(Set.of())
                                        .stream()
                                        .collect(Collectors.toMap(VariantOption::getId, o -> o));

                        for (var oReq : Optional.ofNullable(vReq.getOptions()).orElse(List.of())) {
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

                // DEACTIVATE VARIANTS NOT IN REQUEST (Instead of deleting to preserve foreign keys)
                dbVariants.values().forEach(variant -> {
                        variant.setStatus(ProductStatus.INACTIVE);
                });

                return productRepository.save(product);
        }

        @Override
        public void deleteProduct(Long productId) {
                Product product = productRepository.findById(productId)
                                .orElseThrow(() -> new ResourceNotFoundException(
                                                "Product not found with id: " + productId));
                // Soft delete: Mark product and all variants as INACTIVE instead of deleting
                product.setStatus(ProductStatus.INACTIVE);
                product.getProductVariants().forEach(variant -> 
                        variant.setStatus(ProductStatus.INACTIVE)
                );
                productRepository.save(product);
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
