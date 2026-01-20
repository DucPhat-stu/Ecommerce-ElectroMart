package com.store.electro.Services;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Models.DTO.CartRequest;
import com.store.electro.Models.DTO.CartResponse;
import com.store.electro.Models.DTO.CartResponse.CartItemDTO;
import com.store.electro.Models.DTO.CartResponse.ProductInfo;
import com.store.electro.Models.Entity.Cart;
import com.store.electro.Models.Entity.Product;
import com.store.electro.Repositories.CartRepository;
import com.store.electro.Repositories.ProductRepository;

@Service
public class CartService {

    private final CartRepository cartRepository;
    private final ProductRepository productRepository;

    public CartService(CartRepository cartRepository, ProductRepository productRepository) {
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
    }

    @Transactional
    public CartResponse getUserCart(Long userId) {
        List<Cart> cartItems = cartRepository.findByUserId(userId);

        List<CartItemDTO> items = cartItems.stream().map(cart -> {
            Product product = cart.getProduct();

            // Calculate final price
            BigDecimal finalPrice = product.getPrice();
            if (product.getDiscountPercent() != null && product.getDiscountPercent() > 0) {
                BigDecimal discount = BigDecimal.valueOf(product.getDiscountPercent())
                        .divide(BigDecimal.valueOf(100));
                finalPrice = product.getPrice().multiply(BigDecimal.ONE.subtract(discount));
            }

            // Get primary image
            String imageUrl = product.getProductImages().stream()
                    .filter(img -> img.isIsPrimary())
                    .findFirst()
                    .map(img -> img.getImageUrl())
                    .orElse(null);

            ProductInfo productInfo = new ProductInfo();
            productInfo.setId(product.getId());
            productInfo.setName(product.getName());
            productInfo.setPrice(product.getPrice());
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

    @Transactional
    public Cart addToCart(CartRequest request) {
        // Validate product exists
        Product product = productRepository.findById(request.getProductId())
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + request.getProductId()));

        // Check stock
        if (product.getStockQuantity() < request.getQuantity()) {
            throw new RuntimeException(
                    "Insufficient stock. Available: " + product.getStockQuantity() + ", Requested: "
                            + request.getQuantity());
        }

        // Check if product already in cart
        Optional<Cart> existingCart = cartRepository.findByUserIdAndProductId(request.getUserId(),
                request.getProductId());

        if (existingCart.isPresent()) {
            // Update quantity
            Cart cart = existingCart.get();
            int newQuantity = cart.getQuantity() + request.getQuantity();

            if (product.getStockQuantity() < newQuantity) {
                throw new RuntimeException(
                        "Insufficient stock. Available: " + product.getStockQuantity() + ", Requested: "
                                + newQuantity);
            }

            cart.setQuantity(newQuantity);
            return cartRepository.save(cart);
        } else {
            // Create new cart item
            Cart cart = new Cart(request.getUserId(), product, request.getQuantity());
            return cartRepository.save(cart);
        }
    }

    @Transactional
    public Cart updateCartItem(Long cartId, Integer quantity) {
        Cart cart = cartRepository.findById(cartId)
                .orElseThrow(() -> new RuntimeException("Cart item not found with id: " + cartId));

        Product product = cart.getProduct();

        if (product.getStockQuantity() < quantity) {
            throw new RuntimeException(
                    "Insufficient stock. Available: " + product.getStockQuantity() + ", Requested: " + quantity);
        }

        cart.setQuantity(quantity);
        return cartRepository.save(cart);
    }

    @Transactional
    public void removeFromCart(Long cartId) {
        if (!cartRepository.existsById(cartId)) {
            throw new RuntimeException("Cart item not found with id: " + cartId);
        }
        cartRepository.deleteById(cartId);
    }

    @Transactional
    public void clearUserCart(Long userId) {
        cartRepository.deleteByUserId(userId);
    }
}