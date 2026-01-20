package com.store.electro.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.store.electro.Models.Entity.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findByUserIdOrderByCreatedAtDesc(Long userId);

    Optional<Order> findByOrderNumber(String orderNumber);

    @Query("""
            SELECT o FROM Order o
            LEFT JOIN FETCH o.orderItems
            WHERE o.id = :orderId
            """)
    Optional<Order> findByIdWithItems(@Param("orderId") Long orderId);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.userId = :userId")
    Long countByUserId(@Param("userId") Long userId);
}