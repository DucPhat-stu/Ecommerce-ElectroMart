package com.store.electro.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.store.electro.Models.Entity.Cart;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

}
