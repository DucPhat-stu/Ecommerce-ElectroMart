package com.store.electro.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.store.electro.Models.User;

public interface UserRepository extends JpaRepository<User, Integer>{

}
