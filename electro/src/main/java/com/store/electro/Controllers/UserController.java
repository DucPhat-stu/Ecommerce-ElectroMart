package com.store.electro.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTOs.Request.UserRequest;
import com.store.electro.Models.Entity.User;
import com.store.electro.Services.UserService;
import com.store.electro.Utils.ApiResponse;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/v1")
public class UserController {

	private final UserService userService;

	public UserController(UserService userService){
		this.userService = userService;
	}

	// Get all users
	@GetMapping("/users")
	public ResponseEntity<ApiResponse<List<User>>> getAllUsers() {
		List<User> users = userService.getAllUsers();
		return ResponseEntity.ok(ApiResponse.success("Users retrieved successfully", users));
	}

	// Get user by ID
	@GetMapping("/user/{userId}")
	public ResponseEntity<ApiResponse<User>> getUserById(@PathVariable Long userId) {
		User user = userService.getUserById(userId);
		return ResponseEntity.ok(ApiResponse.success("User found", user));
	}

	// Create new user
	@PostMapping("/user")
	public ResponseEntity<ApiResponse<User>> createUser(@Valid @RequestBody UserRequest request) {
		User createdUser = userService.createUser(request);
		return ResponseEntity.status(201)
				.body(ApiResponse.success("User created successfully", createdUser));
	}

	// Update user
	@PutMapping("/user/{userId}")
	public ResponseEntity<ApiResponse<User>> updateUser(
			@Valid @RequestBody UserRequest request,
			@PathVariable Long userId) {
		User updatedUser = userService.updateUser(userId, request);
		return ResponseEntity.ok(ApiResponse.success("User updated successfully", updatedUser));
	}

	// Delete user
	@DeleteMapping("/user/{userId}")
	public ResponseEntity<ApiResponse<Void>> deleteUser(@PathVariable Long userId) {
		userService.deleteUser(userId);
		return ResponseEntity.status(204)
				.body(ApiResponse.success("User deleted successfully", null));
	}

}
