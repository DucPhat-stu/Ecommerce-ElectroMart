package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.Entity.Category;
import com.store.electro.Repositories.CategoryRepository;


@RestController
@RequestMapping("/api")
public class CategoryController {

    private final CategoryRepository categoryRepo;

    public CategoryController(CategoryRepository categoryRepo) {
        this.categoryRepo = categoryRepo;
    }

    @GetMapping("/v1/category")
    public ResponseEntity<List<Category>> getMethodName() {
        List<Category> categories = categoryRepo.findAll();
        return ResponseEntity.ok(categories);
    }
    
}
