package com.store.electro.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.store.electro.Models.Entity.User;

<<<<<<< HEAD
public interface UserRepository extends JpaRepository<User, Integer>{
=======
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
>>>>>>> af3adb4 (Update product, category, order models)

}
