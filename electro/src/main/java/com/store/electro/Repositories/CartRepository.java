package com.store.electro.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.store.electro.Models.Entity.Cart;

public interface CartRepository extends JpaRepository<Cart, Long> {

    List<Cart> findByUserId(Long userId);

    @Query("SELECT c FROM Cart c WHERE c.userId = :userId AND c.product.id = :productId")
    Optional<Cart> findByUserIdAndProductId(@Param("userId") Long userId, @Param("productId") Long productId);

    void deleteByUserId(Long userId);

    @Query("SELECT COUNT(c) FROM Cart c WHERE c.userId = :userId")
    Long countByUserId(@Param("userId") Long userId);
}