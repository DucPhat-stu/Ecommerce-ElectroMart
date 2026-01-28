package com.store.electro.Controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.store.electro.Models.DTOs.Request.LoginRequest;
import com.store.electro.Models.DTOs.Request.RegisterRequest;
import com.store.electro.Models.DTOs.Response.LoginResponse;
import com.store.electro.Models.Entity.User;
import com.store.electro.Services.UserService;
import com.store.electro.Utils.ApiResponse;

@RestController
@RequestMapping("${api.prefix}/auth")
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<LoginResponse>> login(@RequestBody LoginRequest request) {
        try {
            LoginResponse res = userService.login(request);
            return ResponseEntity.ok(ApiResponse.success("Login successful", res));
        } catch (Exception e) {
            return ResponseEntity.status(401)
                    .body(ApiResponse.error("Login failed", "UNAUTHORIZED", e.getMessage()));
        }
    }

    @PostMapping("/register")
    public ResponseEntity<ApiResponse<User>> register(@RequestBody RegisterRequest request) {
        try {
            User user = userService.register(request);
            return ResponseEntity.status(201).body(ApiResponse.success("Register successful", user));
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.error("Register failed", "BAD_REQUEST", e.getMessage()));
        }
    }
}

