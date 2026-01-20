package com.store.electro.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.store.electro.Models.Entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long>{

}
