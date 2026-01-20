package com.store.electro.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.store.electro.Models.Entity.OrderItem;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {

}