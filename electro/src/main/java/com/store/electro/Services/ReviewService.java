package com.store.electro.Services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.store.electro.Models.DTO.ReviewRequest;
import com.store.electro.Models.Entity.Review;
import com.store.electro.Repositories.ReviewRepository;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;

    public ReviewService(ReviewRepository reviewRepository) {
        this.reviewRepository = reviewRepository;
    }

    @Transactional
    public Review createReview(ReviewRequest request) {
        // Check if user already reviewed this product
        Optional<Review> existingReview = reviewRepository.findByProductIdAndUserId(
                request.getProductId(), request.getUserId());

        if (existingReview.isPresent()) {
            throw new RuntimeException("You have already reviewed this product");
        }

        // Validate rating
        if (request.getRating() < 1 || request.getRating() > 5) {
            throw new RuntimeException("Rating must be between 1 and 5");
        }

        Review review = new Review(
                request.getProductId(),
                request.getUserId(),
                request.getRating(),
                request.getComment());

        return reviewRepository.save(review);
    }

    public Map<String, Object> getProductReviews(Long productId) {
        List<Review> reviews = reviewRepository.findByProductIdOrderByCreatedAtDesc(productId);

        // Calculate statistics
        Double averageRating = reviewRepository.getAverageRating(productId);
        Long totalReviews = reviewRepository.countByProductId(productId);

        // Rating distribution
        Map<Integer, Long> distribution = new HashMap<>();
        for (int i = 1; i <= 5; i++) {
            distribution.put(i, reviewRepository.countByProductIdAndRating(productId, i));
        }

        Map<String, Object> result = new HashMap<>();
        result.put("reviews", reviews);
        result.put("summary", Map.of(
                "averageRating", averageRating != null ? averageRating : 0.0,
                "totalReviews", totalReviews,
                "ratingDistribution", distribution));

        return result;
    }

    @Transactional
    public Review updateReview(Long reviewId, ReviewRequest request) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found with id: " + reviewId));

        if (request.getRating() != null) {
            if (request.getRating() < 1 || request.getRating() > 5) {
                throw new RuntimeException("Rating must be between 1 and 5");
            }
            review.setRating(request.getRating());
        }

        if (request.getComment() != null) {
            review.setComment(request.getComment());
        }

        return reviewRepository.save(review);
    }

    @Transactional
    public void deleteReview(Long reviewId) {
        if (!reviewRepository.existsById(reviewId)) {
            throw new RuntimeException("Review not found with id: " + reviewId);
        }
        reviewRepository.deleteById(reviewId);
    }
}