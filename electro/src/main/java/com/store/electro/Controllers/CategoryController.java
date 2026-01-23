package com.store.electro.Controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.Entity.Category;
import com.store.electro.Repositories.CategoryRepository;
import com.store.electro.Utils.ApiResponse;


@RestController
@RequestMapping("/api")
public class CategoryController {

    private final CategoryRepository categoryRepo;

    public CategoryController(CategoryRepository categoryRepo) {
        this.categoryRepo = categoryRepo;
    }

    @GetMapping("/v1/category/{categoryName}")
    public ResponseEntity<ApiResponse<java.util.Optional<Category>>> getCategoryName(@PathVariable String categoryName) {
        try {
            return ResponseEntity.ok(ApiResponse.success("success", categoryRepo.findByName(categoryName)));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


    
}
