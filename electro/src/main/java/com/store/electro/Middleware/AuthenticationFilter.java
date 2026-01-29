package com.store.electro.Middleware;

import java.io.IOException;

import org.springframework.web.filter.OncePerRequestFilter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.store.electro.Services.UserService;
import com.store.electro.Utils.ApiResponse;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AuthenticationFilter extends OncePerRequestFilter {

	private final UserService userService;
	private final ObjectMapper objectMapper;

	public AuthenticationFilter(UserService userService) {
		this.userService = userService;
		this.objectMapper = new ObjectMapper();
		this.objectMapper.registerModule(new JavaTimeModule());
	}

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
			FilterChain filterChain) throws ServletException, IOException {

		// Skip authentication for public endpoints
		String requestPath = request.getRequestURI();
		if (isPublicEndpoint(requestPath)) {
			filterChain.doFilter(request, response);
			return;
		}

		// Get Authorization header
		String authHeader = request.getHeader("Authorization");
		if (authHeader == null || !authHeader.startsWith("Bearer ")) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.setContentType("application/json");
			String errorResponse = objectMapper.writeValueAsString(
				ApiResponse.error("Missing or invalid token", "UNAUTHORIZED", "Bearer token is required")
			);
			response.getWriter().write(errorResponse);
			return;
		}

		// Extract token
		String token = authHeader.substring(7);

		// Validate token
		if (!userService.validateToken(token)) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.setContentType("application/json");
			String errorResponse = objectMapper.writeValueAsString(
				ApiResponse.error("Invalid or expired token", "INVALID_TOKEN", "Token validation failed")
			);
			response.getWriter().write(errorResponse);
			return;
		}

		// Extract user ID and add to request attributes
		Long userId = userService.extractUserIdFromToken(token);
		String username = userService.extractUsernameFromToken(token);
		if (userId != null) {
			request.setAttribute("userId", userId);
			request.setAttribute("username", username);
		}

		filterChain.doFilter(request, response);
	}

	private boolean isPublicEndpoint(String path) {
		// Public endpoints that don't require authentication
		return path.contains("/api/v1/auth/login") || 
		       path.contains("/api/v1/auth/register") ||
		       path.contains("/api/v1/products") ||  // public access for testing
				path.contains("/api/v1/product") ||  // public access for testing
				path.contains("/api/v1/cart") ||
				path.contains("/api/v1/orders") ||
				path.contains("/api/v1/category") ||
		       path.contains("/api/v1/dashboard") || // admin dashboard public access
		       path.contains("/api/v1/admin") ||    // admin endpoints public access
		       path.contains("/api/v1/categories") || // categories for frontend/admin
		       path.contains("/api/v1/category/name") || // get category by name (public)
		       path.contains("/api/v1/brands") || // brands for frontend/admin
		       path.contains("/api/v1/reviews");
	}
}