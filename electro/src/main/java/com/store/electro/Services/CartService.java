package com.store.electro.Services;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Exceptions.ResourceNotFoundException;
import com.store.electro.Models.DTOs.Request.CartRequest;
import com.store.electro.Models.DTOs.Response.CartResponse;
import com.store.electro.Models.DTOs.Response.CartResponse.CartItemDTO;
import com.store.electro.Models.DTOs.Response.CartResponse.ProductInfo;
import com.store.electro.Models.Entity.Cart;
import com.store.electro.Models.Entity.Product.ProductVariant;
import com.store.electro.Repositories.CartRepository;
import com.store.electro.Repositories.ProductVariantRepository;

@Service
public class CartService implements ICartService {

    private final CartRepository cartRepository;
    private final ProductVariantRepository productVariantRepository;

    public CartService(CartRepository cartRepository, ProductVariantRepository productVariantRepository) {
        this.cartRepository = cartRepository;
        this.productVariantRepository = productVariantRepository;
    }

    @Override
    @Transactional
    public CartResponse getUserCart(Long userId) {
        List<Cart> cartItems = cartRepository.findByUserId(userId);

        List<CartItemDTO> items = cartItems.stream().map(cart -> {
            ProductVariant product = cart.getProduct();

            // Calculate final price
            BigDecimal finalPrice = product.calculatePrice();

            // Get primary image from the related product
            String imageUrl = product.getProduct().getProductImages().stream()
                    .filter(img -> img.isIsPrimary())
                    .findFirst()
                    .map(img -> img.getImageUrl())
                    .orElse(null);

            ProductInfo productInfo = new ProductInfo();
            productInfo.setId(product.getId());
            productInfo.setName(product.getProduct().getName());
            productInfo.setPrice(product.getBasePrice());
            productInfo.setDiscountPercent(product.getDiscountPercent());
            productInfo.setFinalPrice(finalPrice);
            productInfo.setImageUrl(imageUrl);

            BigDecimal subtotal = finalPrice.multiply(BigDecimal.valueOf(cart.getQuantity()));

            return new CartItemDTO(cart.getId(), productInfo, cart.getQuantity(), subtotal);
        }).collect(Collectors.toList());

        Integer totalItems = items.stream()
                .mapToInt(CartItemDTO::getQuantity)
                .sum();

        BigDecimal totalAmount = items.stream()
                .map(CartItemDTO::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        return new CartResponse(userId, items, totalItems, totalAmount);
    }
    
    @Override
    @Transactional
    public Cart addToCart(CartRequest request) {
        // Validate product variant exists
        ProductVariant productVariant = productVariantRepository.findById(request.getProductId())
                .orElseThrow(
                        () -> new ResourceNotFoundException("Product variant not found with id: " + request.getProductId()));

        // Check if product already in cart
        Optional<Cart> existingCart = cartRepository.findByUserIdAndProductId(request.getUserId(),
                request.getProductId());

        if (existingCart.isPresent()) {
            // Update quantity
            Cart cart = existingCart.get();
            int newQuantity = cart.getQuantity() + request.getQuantity();

            cart.setQuantity(newQuantity);
            return cartRepository.save(cart);
        } else {
            // Create new cart item
            Cart cart = new Cart(request.getUserId(), productVariant, request.getQuantity());
            return cartRepository.save(cart);
        }
    }

    @Override
    @Transactional
    public Cart updateCartItem(Long cartId, Integer quantity) {
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new ResourceNotFoundException("Cart item not found with id: " + cartId));

        cart.setQuantity(quantity);
        return cartRepository.save(cart);
    }

    @Override
    @Transactional
    public void removeFromCart(Long cartId) {
        if (!cartRepository.existsById(cartId)) {
            throw new ResourceNotFoundException("Cart item not found with id: " + cartId);
        }
        cartRepository.deleteById(cartId);
    }

    @Override
    @Transactional
    public void clearUserCart(Long userId) {
        cartRepository.deleteByUserId(userId);
    }
}