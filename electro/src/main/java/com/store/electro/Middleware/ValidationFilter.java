package com.store.electro.Middleware;

import java.io.IOException;

import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ValidationFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
			FilterChain filterChain) throws ServletException, IOException {

		// Skip CORS preflight requests
		if ("OPTIONS".equals(request.getMethod())) {
			filterChain.doFilter(request, response);
			return;
		}

		// Validate Content-Type for POST/PUT requests
		String method = request.getMethod();
		if ("POST".equals(method) || "PUT".equals(method)) {
			String contentType = request.getHeader("Content-Type");
			
			if (contentType == null || 
				(!contentType.contains("application/json") && !contentType.contains("multipart/form-data"))) {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				response.setContentType("application/json");
				response.getWriter()
						.write("{\"success\": false, \"message\": \"Content-Type must be application/json or multipart/form-data\"}");
				return;
			}
		}

		// Validate request size (max 10MB)
		long contentLength = request.getContentLengthLong();
		if (contentLength > 10 * 1024 * 1024) { // 10MB
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.setContentType("application/json");
			response.getWriter()
					.write("{\"success\": false, \"message\": \"Request body too large (max 10MB)\"}");
			return;
		}

		filterChain.doFilter(request, response);
	}
}