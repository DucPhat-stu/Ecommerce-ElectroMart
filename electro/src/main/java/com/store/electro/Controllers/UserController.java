package com.store.electro.Controllers;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.User;
import com.store.electro.Repositories.UserRepository;

/*
 * Controller testing endpoint nginx reverse proxy 
 * 
 * */
@RestController
@RequestMapping("api/")
public class UserController {

	private final UserRepository repo;

	public UserController(UserRepository repo){
		this.repo = repo;
	}

	@GetMapping("v1/users")
	public List<User> getUsers() {
		return repo.findAll();
	}

}
