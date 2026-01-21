package com.store.electro.Services;

import com.store.electro.Models.Entity.Category;

import java.util.List;

public interface ICategoryService {

    Category getCategoryById(Long categoryId);

    List<Category> getAllCategories();

    Category addCategory(Category category);

    Category updateCategory(Category category, Long categoryId);

    void deleteCategory(Long categoryId);

}
