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

import com.store.electro.Models.DTO.LoginRequest;
import com.store.electro.Models.DTO.LoginResponse;
import com.store.electro.Models.DTO.RegisterRequest;
import com.store.electro.Models.DTO.UserRequest;
import com.store.electro.Models.Entity.User;
import com.store.electro.Services.UserService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("/api/v1/auth")
public class UserController {

	private final UserService userService;

	public UserController(UserService userService) {
		this.userService = userService;
	}

	// ==================== AUTHENTICATION ENDPOINTS ====================

	@PostMapping("/register")
	public ResponseEntity<ApiResponse<User>> register(@RequestBody RegisterRequest request) {
		try {
			User user = userService.register(request);
			return ResponseEntity.status(201)
					.body(ApiResponse.success("User registered successfully", user));
		} catch (RuntimeException e) {
			return ResponseEntity.status(400)
					.body(ApiResponse.error("Registration failed", "REGISTRATION_ERROR", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Registration failed", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	@PostMapping("/login")
	public ResponseEntity<ApiResponse<LoginResponse>> login(@RequestBody LoginRequest request) {
		try {
			LoginResponse loginResponse = userService.login(request);
			return ResponseEntity.ok(ApiResponse.success("Login successful", loginResponse));
		} catch (RuntimeException e) {
			return ResponseEntity.status(401)
					.body(ApiResponse.error("Login failed", "INVALID_CREDENTIALS", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Login failed", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	// ==================== USER CRUD ENDPOINTS ====================

	@GetMapping("/users")
	public ResponseEntity<ApiResponse<List<User>>> getAllUsers() {
		try {
			List<User> users = userService.getAllUsers();
			return ResponseEntity.ok(ApiResponse.success("Users retrieved successfully", users));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Failed to retrieve users", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	@GetMapping("/users/{id}")
	public ResponseEntity<ApiResponse<User>> getUserById(@PathVariable Long id) {
		try {
			User user = userService.getUserById(id);
			return ResponseEntity.ok(ApiResponse.success("User found", user));
		} catch (RuntimeException e) {
			return ResponseEntity.status(404)
					.body(ApiResponse.error("User not found", "USER_NOT_FOUND", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Failed to retrieve user", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	@GetMapping("/users/username/{username}")
	public ResponseEntity<ApiResponse<User>> getUserByUsername(@PathVariable String username) {
		try {
			User user = userService.getUserByUsername(username);
			return ResponseEntity.ok(ApiResponse.success("User found", user));
		} catch (RuntimeException e) {
			return ResponseEntity.status(404)
					.body(ApiResponse.error("User not found", "USER_NOT_FOUND", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Failed to retrieve user", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	@GetMapping("/users/email/{email}")
	public ResponseEntity<ApiResponse<User>> getUserByEmail(@PathVariable String email) {
		try {
			User user = userService.getUserByEmail(email);
			return ResponseEntity.ok(ApiResponse.success("User found", user));
		} catch (RuntimeException e) {
			return ResponseEntity.status(404)
					.body(ApiResponse.error("User not found", "USER_NOT_FOUND", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Failed to retrieve user", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	@PutMapping("/users/{id}")
	public ResponseEntity<ApiResponse<User>> updateUser(@PathVariable Long id, @RequestBody UserRequest request) {
		try {
			User user = userService.updateUser(id, request);
			return ResponseEntity.ok(ApiResponse.success("User updated successfully", user));
		} catch (RuntimeException e) {
			if (e.getMessage().contains("not found")) {
				return ResponseEntity.status(404)
						.body(ApiResponse.error("User not found", "USER_NOT_FOUND", e.getMessage()));
			}
			return ResponseEntity.status(400)
					.body(ApiResponse.error("Failed to update user", "UPDATE_ERROR", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Failed to update user", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	@DeleteMapping("/users/{id}")
	public ResponseEntity<ApiResponse<Void>> deleteUser(@PathVariable Long id) {
		try {
			userService.deleteUser(id);
			return ResponseEntity.ok(ApiResponse.success("User deleted successfully", null));
		} catch (RuntimeException e) {
			return ResponseEntity.status(404)
					.body(ApiResponse.error("User not found", "USER_NOT_FOUND", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Failed to delete user", "INTERNAL_ERROR", e.getMessage()));
		}
	}

	@PostMapping("/users/{id}/change-password")
	public ResponseEntity<ApiResponse<User>> changePassword(@PathVariable Long id,
			@RequestBody java.util.Map<String, String> request) {
		try {
			String oldPassword = request.get("oldPassword");
			String newPassword = request.get("newPassword");

			if (oldPassword == null || newPassword == null) {
				throw new RuntimeException("Old password and new password are required");
			}

			User user = userService.changePassword(id, oldPassword, newPassword);
			return ResponseEntity.ok(ApiResponse.success("Password changed successfully", user));
		} catch (RuntimeException e) {
			return ResponseEntity.status(400)
					.body(ApiResponse.error("Failed to change password", "PASSWORD_ERROR", e.getMessage()));
		} catch (Exception e) {
			return ResponseEntity.status(500)
					.body(ApiResponse.error("Failed to change password", "INTERNAL_ERROR", e.getMessage()));
		}
	}
}
