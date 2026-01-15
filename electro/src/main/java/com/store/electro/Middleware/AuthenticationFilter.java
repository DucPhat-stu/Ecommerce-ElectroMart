package com.store.electro.Middleware;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.store.electro.Services.UserService;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuthenticationFilter extends OncePerRequestFilter {

	private final UserService userService;

	public AuthenticationFilter(UserService userService) {
		this.userService = userService;
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
			response.getWriter().write("{\"success\": false, \"message\": \"Missing or invalid token\"}");
			return;
		}

		// Extract token
		String token = authHeader.substring(7);

		// Validate token
		if (!userService.validateToken(token)) {
			response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
			response.setContentType("application/json");
			response.getWriter().write("{\"success\": false, \"message\": \"Invalid token\"}");
			return;
		}

		// Extract user ID and add to request attributes
		Long userId = userService.extractUserIdFromToken(token);
		if (userId != null) {
			request.setAttribute("userId", userId);
		}

		filterChain.doFilter(request, response);
	}

	private boolean isPublicEndpoint(String path) {
		// Public endpoints that don't require authentication
		return path.contains("/api/v1/auth/login") || 
		       path.contains("/api/v1/auth/register") ||
		       path.contains("/api/v1/products") ||
		       path.contains("/api/v1/reviews");
	}
}