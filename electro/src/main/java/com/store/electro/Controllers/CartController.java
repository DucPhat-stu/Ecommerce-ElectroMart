package com.store.electro.Controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTO.CartRequest;
import com.store.electro.Models.DTO.CartResponse;
import com.store.electro.Models.Entity.Cart;
import com.store.electro.Services.CartService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("/api/v1/cart")
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping("/{userId}")
    public ResponseEntity<ApiResponse<CartResponse>> getUserCart(@PathVariable Long userId) {
        try {
            CartResponse cart = cartService.getUserCart(userId);
            return ResponseEntity.ok(ApiResponse.success("Cart retrieved successfully", cart));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to retrieve cart", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Cart>> addToCart(@RequestBody CartRequest request) {
        try {
            Cart cart = cartService.addToCart(request);
            return ResponseEntity.status(201).body(ApiResponse.success("Product added to cart", cart));
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                return ResponseEntity.status(404)
                        .body(ApiResponse.error("Product not found", "PRODUCT_NOT_FOUND", e.getMessage()));
            } else if (e.getMessage().contains("Insufficient stock")) {
                return ResponseEntity.status(400)
                        .body(ApiResponse.error("Insufficient stock", "INSUFFICIENT_STOCK", e.getMessage()));
            }
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to add to cart", "CART_ERROR", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to add to cart", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @PutMapping("/{cartId}")
    public ResponseEntity<ApiResponse<Cart>> updateCartItem(@PathVariable Long cartId,
            @RequestBody CartRequest request) {
        try {
            Cart cart = cartService.updateCartItem(cartId, request.getQuantity());
            return ResponseEntity.ok(ApiResponse.success("Cart updated successfully", cart));
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                return ResponseEntity.status(404)
                        .body(ApiResponse.error("Cart item not found", "CART_ITEM_NOT_FOUND", e.getMessage()));
            } else if (e.getMessage().contains("Insufficient stock")) {
                return ResponseEntity.status(400)
                        .body(ApiResponse.error("Insufficient stock", "INSUFFICIENT_STOCK", e.getMessage()));
            }
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to update cart", "CART_ERROR", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to update cart", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @DeleteMapping("/{cartId}")
    public ResponseEntity<ApiResponse<Void>> removeFromCart(@PathVariable Long cartId) {
        try {
            cartService.removeFromCart(cartId);
            return ResponseEntity.ok(ApiResponse.success("Item removed from cart", null));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404)
                    .body(ApiResponse.error("Cart item not found", "CART_ITEM_NOT_FOUND", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to remove from cart", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @DeleteMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<Void>> clearUserCart(@PathVariable Long userId) {
        try {
            cartService.clearUserCart(userId);
            return ResponseEntity.ok(ApiResponse.success("Cart cleared successfully", null));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to clear cart", "INTERNAL_ERROR", e.getMessage()));
        }
    }
}