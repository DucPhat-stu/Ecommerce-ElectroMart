package com.store.electro.Controllers;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTO.ReviewRequest;
import com.store.electro.Models.Entity.Review;
import com.store.electro.Services.ReviewService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("/api/v1/reviews")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @PostMapping
    public ResponseEntity<ApiResponse<Review>> createReview(@RequestBody ReviewRequest request) {
        try {
            Review review = reviewService.createReview(request);
            return ResponseEntity.status(201).body(ApiResponse.success("Review created successfully", review));
        } catch (RuntimeException e) {
            if (e.getMessage().contains("already reviewed")) {
                return ResponseEntity.status(409)
                        .body(ApiResponse.error("You have already reviewed this product", "REVIEW_EXISTS",
                                e.getMessage()));
            } else if (e.getMessage().contains("Rating must be")) {
                return ResponseEntity.status(400)
                        .body(ApiResponse.error("Invalid rating", "INVALID_RATING", e.getMessage()));
            }
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to create review", "REVIEW_ERROR", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to create review", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @GetMapping("/product/{productId}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> getProductReviews(@PathVariable Long productId) {
        try {
            Map<String, Object> reviews = reviewService.getProductReviews(productId);
            return ResponseEntity.ok(ApiResponse.success("Reviews retrieved successfully", reviews));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to retrieve reviews", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @PutMapping("/{reviewId}")
    public ResponseEntity<ApiResponse<Review>> updateReview(@PathVariable Long reviewId,
            @RequestBody ReviewRequest request) {
        try {
            Review review = reviewService.updateReview(reviewId, request);
            return ResponseEntity.ok(ApiResponse.success("Review updated successfully", review));
        } catch (RuntimeException e) {
            if (e.getMessage().contains("not found")) {
                return ResponseEntity.status(404)
                        .body(ApiResponse.error("Review not found", "REVIEW_NOT_FOUND", e.getMessage()));
            } else if (e.getMessage().contains("Rating must be")) {
                return ResponseEntity.status(400)
                        .body(ApiResponse.error("Invalid rating", "INVALID_RATING", e.getMessage()));
            }
            return ResponseEntity.status(400)
                    .body(ApiResponse.error("Failed to update review", "REVIEW_ERROR", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to update review", "INTERNAL_ERROR", e.getMessage()));
        }
    }

    @DeleteMapping("/{reviewId}")
    public ResponseEntity<ApiResponse<Void>> deleteReview(@PathVariable Long reviewId) {
        try {
            reviewService.deleteReview(reviewId);
            return ResponseEntity.ok(ApiResponse.success("Review deleted successfully", null));
        } catch (RuntimeException e) {
            return ResponseEntity.status(404)
                    .body(ApiResponse.error("Review not found", "REVIEW_NOT_FOUND", e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(500)
                    .body(ApiResponse.error("Failed to delete review", "INTERNAL_ERROR", e.getMessage()));
        }
    }
}