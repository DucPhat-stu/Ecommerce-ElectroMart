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

import com.store.electro.Models.Entity.Category;
import com.store.electro.Services.ICategoryService;
import com.store.electro.Utils.ApiResponse;

import jakarta.validation.Valid;

@RestController
@RequestMapping("${api.prefix}/category")
public class CategoryController {

    private final ICategoryService categoryService;

    public CategoryController(ICategoryService categoryService) {
        this.categoryService = categoryService;
    }

    // Get all categories
    @GetMapping("")
    public ResponseEntity<ApiResponse<List<Category>>> getAllCategories() {
        List<Category> categories = categoryService.getAllCategories();
        return ResponseEntity.ok(ApiResponse.success("Categories retrieved successfully", categories));
    }

    // Get category by ID
    @GetMapping("/{categoryId}")
    public ResponseEntity<ApiResponse<Category>> getCategoryById(@PathVariable Long categoryId) {
        Category category = categoryService.getCategoryById(categoryId);
        return ResponseEntity.ok(ApiResponse.success("Category found", category));
    }

    // Create new category
    @PostMapping("")
    public ResponseEntity<ApiResponse<Category>> createCategory(@Valid @RequestBody Category category) {
        Category createdCategory = categoryService.addCategory(category);
        return ResponseEntity.status(201)
                .body(ApiResponse.success("Category created successfully", createdCategory));
    }

    // Update category
    @PutMapping("/{categoryId}")
    public ResponseEntity<ApiResponse<Category>> updateCategory(
            @Valid @RequestBody Category category,
            @PathVariable Long categoryId) {
        Category updatedCategory = categoryService.updateCategory(category, categoryId);
        return ResponseEntity.ok(ApiResponse.success("Category updated successfully", updatedCategory));
    }

    // Delete category
    @DeleteMapping("/{categoryId}")
    public ResponseEntity<ApiResponse<Void>> deleteCategory(@PathVariable Long categoryId) {
        categoryService.deleteCategory(categoryId);
        return ResponseEntity.status(204)
                .body(ApiResponse.success("Category deleted successfully", null));
    }
}
