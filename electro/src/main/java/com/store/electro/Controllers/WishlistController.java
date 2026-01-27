package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.Entity.Wishlist;
import com.store.electro.Services.WishlistService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("${api.prefix}")
public class WishlistController {

    private final WishlistService wishlistService;

    public WishlistController(WishlistService wishlistService) {
        this.wishlistService = wishlistService;
    }

    // Get wishlist by user ID
    @GetMapping("/wishlist")
    public ResponseEntity<ApiResponse<List<Wishlist>>> getWishlistByUserId(@RequestParam Long userId) {
        List<Wishlist> wishlist = wishlistService.getWishlistByUserId(userId);
        return ResponseEntity.ok(ApiResponse.success("Wishlist retrieved successfully", wishlist));
    }

    // Get wishlist count by user ID
    @GetMapping("/wishlist/count")
    public ResponseEntity<ApiResponse<Long>> getWishlistCount(@RequestParam Long userId) {
        Long count = wishlistService.getWishlistCountByUserId(userId);
        return ResponseEntity.ok(ApiResponse.success("Wishlist count retrieved", count));
    }

    // Add product to wishlist
    @PostMapping("/wishlist")
    public ResponseEntity<ApiResponse<Wishlist>> addToWishlist(
            @RequestParam Long userId,
            @RequestParam Long productId) {
        Wishlist wishlist = wishlistService.addToWishlist(userId, productId);
        return ResponseEntity.status(201)
                .body(ApiResponse.success("Added to wishlist", wishlist));
    }

    // Remove product from wishlist
    @DeleteMapping("/wishlist")
    public ResponseEntity<ApiResponse<Void>> removeFromWishlist(
            @RequestParam Long userId,
            @RequestParam Long productId) {
        wishlistService.removeFromWishlist(userId, productId);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Removed from wishlist", null));
    }

    // Remove wishlist item by ID
    @DeleteMapping("/wishlist/{wishlistId}")
    public ResponseEntity<ApiResponse<Void>> removeWishlistById(@PathVariable Long wishlistId) {
        wishlistService.removeWishlistById(wishlistId);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Wishlist item removed", null));
    }
}
