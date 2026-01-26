package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.Entity.Discount;
import com.store.electro.Services.DiscountService;
import com.store.electro.Utils.ApiResponse;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/v1")
public class DiscountController {

    private final DiscountService discountService;

    public DiscountController(DiscountService discountService) {
        this.discountService = discountService;
    }

    // Get all discounts
    @GetMapping("/discounts")
    public ResponseEntity<ApiResponse<List<Discount>>> getAllDiscounts() {
        List<Discount> discounts = discountService.getAllDiscounts();
        return ResponseEntity.ok(ApiResponse.success("Discounts retrieved successfully", discounts));
    }

    // Get discount by ID
    @GetMapping("/discount/{discountId}")
    public ResponseEntity<ApiResponse<Discount>> getDiscountById(@PathVariable Long discountId) {
        Discount discount = discountService.getDiscountById(discountId);
        return ResponseEntity.ok(ApiResponse.success("Discount found", discount));
    }

    // Get discount by code
    @GetMapping("/discount/code/{code}")
    public ResponseEntity<ApiResponse<Discount>> getDiscountByCode(@PathVariable String code) {
        Discount discount = discountService.getDiscountByCode(code);
        return ResponseEntity.ok(ApiResponse.success("Discount found", discount));
    }

    // Create new discount
    @PostMapping("/discount")
    public ResponseEntity<ApiResponse<Discount>> createDiscount(@Valid @RequestBody Discount discount) {
        Discount createdDiscount = discountService.createDiscount(discount);
        return ResponseEntity.status(201)
                .body(ApiResponse.success("Discount created successfully", createdDiscount));
    }

    // Update discount
    @PutMapping("/discount/{discountId}")
    public ResponseEntity<ApiResponse<Discount>> updateDiscount(
            @Valid @RequestBody Discount discount,
            @PathVariable Long discountId) {
        Discount updatedDiscount = discountService.updateDiscount(discountId, discount);
        return ResponseEntity.ok(ApiResponse.success("Discount updated successfully", updatedDiscount));
    }

    // Delete discount
    @DeleteMapping("/discount/{discountId}")
    public ResponseEntity<ApiResponse<Void>> deleteDiscount(@PathVariable Long discountId) {
        discountService.deleteDiscount(discountId);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Discount deleted successfully", null));
    }
}
