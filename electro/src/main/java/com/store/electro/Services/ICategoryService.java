package com.store.electro.Services;

import java.util.List;

import com.store.electro.Models.Entity.Category;

public interface ICategoryService {

    Category getCategoryById(Long categoryId);

    Category getCategoryByName(String name);

    List<Category> getAllCategories();

    Category addCategory(Category category);

    Category updateCategory(Category category, Long categoryId);

    void deleteCategory(Long categoryId);
}
