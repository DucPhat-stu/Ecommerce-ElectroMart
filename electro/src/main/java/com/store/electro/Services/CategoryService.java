package com.store.electro.Services;

import com.store.electro.Models.Entity.Category;
import com.store.electro.Repositories.CategoryRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryService implements ICategoryService{

    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public Category getCategoryById(Long categoryId) {
        return categoryRepository.findById(categoryId)
                .orElseThrow(() -> new EntityNotFoundException("Category not found with id: " + categoryId));
    }

    @Override
    public Category getCategoryByName(String name) {
        return categoryRepository.findByName(name)
                .orElseThrow(() -> new EntityNotFoundException("Category not found with name: " + name));
    }

    @Override
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    @Override
    public Category addCategory(Category category) {
        return categoryRepository.save(category);
    }

    @Override
    public Category updateCategory(Category category, Long categoryId) {
        return Optional.ofNullable(getCategoryById(categoryId))
                .map(oldCategory -> {
                    oldCategory.setName(category.getName());
                    return categoryRepository.save(oldCategory);
                })
                .orElseThrow(() -> new EntityNotFoundException("Category not found with id: " + categoryId));
    }

    @Override
    public void deleteCategory(Long categoryId) {
        categoryRepository.findById(categoryId)
                .ifPresentOrElse(categoryRepository::delete,
                        ()->{throw new EntityNotFoundException("Category not found with id: " + categoryId);});
    }
}
