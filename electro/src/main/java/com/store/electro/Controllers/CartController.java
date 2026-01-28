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

import com.store.electro.Models.DTOs.Request.CartRequest;
import com.store.electro.Models.DTOs.Response.CartResponse;
import com.store.electro.Models.Entity.Cart;
import com.store.electro.Services.CartService;
import com.store.electro.Utils.ApiResponse;

import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("${api.prefix}/cart")
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    private Long requireAuthUserId(HttpServletRequest request) {
        Object userId = request.getAttribute("userId");
        if (userId instanceof Long) {
            return (Long) userId;
        }
        throw new SecurityException("Unauthorized");
    }

    private void requireSameUser(Long pathOrBodyUserId, Long authUserId) {
        if (pathOrBodyUserId == null || !pathOrBodyUserId.equals(authUserId)) {
            throw new SecurityException("Forbidden");
        }
    }

    /**
     * Preferred endpoint: get current user's cart.
     */
    @GetMapping("/me")
    public ResponseEntity<ApiResponse<CartResponse>> getMyCart(HttpServletRequest request) {
        Long userId = requireAuthUserId(request);
        CartResponse cart = cartService.getUserCart(userId);
        return ResponseEntity.ok(ApiResponse.success("Cart retrieved successfully", cart));
    }

    /**
     * Legacy endpoint (avoid using): get cart by userId.
     * Kept for backward compatibility but now enforces userId == token userId.
     */
    @GetMapping("/{userId}")
    public ResponseEntity<ApiResponse<CartResponse>> getUserCart(
            @PathVariable Long userId,
            HttpServletRequest request) {
        Long authUserId = requireAuthUserId(request);
        requireSameUser(userId, authUserId);
        CartResponse cart = cartService.getUserCart(userId);
        return ResponseEntity.ok(ApiResponse.success("Cart retrieved successfully", cart));
    }

    /**
     * Preferred endpoint: add/update cart item for current user.
     */
    @PostMapping("/items")
    public ResponseEntity<ApiResponse<Cart>> addToMyCart(
            @RequestBody CartRequest requestBody,
            HttpServletRequest request) {
        Long authUserId = requireAuthUserId(request);
        requestBody.setUserId(authUserId); // do NOT trust client userId
        Cart cart = cartService.addToCart(requestBody);
        return ResponseEntity.status(201).body(ApiResponse.success("Product added to cart", cart));
    }

    /**
     * Legacy endpoint (avoid using): add/update cart item by passing userId in body.
     * Kept for backward compatibility but now enforces body.userId == token userId.
     */
    @PostMapping
    public ResponseEntity<ApiResponse<Cart>> addToCart(
            @RequestBody CartRequest requestBody,
            HttpServletRequest request) {
        Long authUserId = requireAuthUserId(request);
        if (requestBody.getUserId() != null) {
            requireSameUser(requestBody.getUserId(), authUserId);
        }
        requestBody.setUserId(authUserId); // force correct userId
        Cart cart = cartService.addToCart(requestBody);
        return ResponseEntity.status(201).body(ApiResponse.success("Product added to cart", cart));
    }

    @PutMapping("/{cartId}")
    public ResponseEntity<ApiResponse<Cart>> updateCartItem(@PathVariable Long cartId,
            @RequestBody CartRequest request) {
        Cart cart = cartService.updateCartItem(cartId, request.getQuantity());
        return ResponseEntity.ok(ApiResponse.success("Cart updated successfully", cart));
    }

    @DeleteMapping("/{cartId}")
    public ResponseEntity<ApiResponse<Void>> removeFromCart(@PathVariable Long cartId) {
        cartService.removeFromCart(cartId);
        return ResponseEntity.ok(ApiResponse.success("Item removed from cart", null));
    }

    @DeleteMapping("/user/{userId}")
    public ResponseEntity<ApiResponse<Void>> clearUserCart(
            @PathVariable Long userId,
            HttpServletRequest request) {
        Long authUserId = requireAuthUserId(request);
        requireSameUser(userId, authUserId);
        cartService.clearUserCart(userId);
        return ResponseEntity.ok(ApiResponse.success("Cart cleared successfully", null));
    }

    /**
     * Preferred endpoint: clear current user's cart.
     */
    @DeleteMapping("/me")
    public ResponseEntity<ApiResponse<Void>> clearMyCart(HttpServletRequest request) {
        Long userId = requireAuthUserId(request);
        cartService.clearUserCart(userId);
        return ResponseEntity.ok(ApiResponse.success("Cart cleared successfully", null));
    }
}