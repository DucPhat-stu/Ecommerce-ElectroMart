package com.store.electro.Middleware;

import java.io.IOException;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class ValidationFilter extends OncePerRequestFilter {

	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
			FilterChain filterChain) throws ServletException, IOException {

		// Validate Content-Type for POST/PUT requests
		String method = request.getMethod();
		if ("POST".equals(method) || "PUT".equals(method)) {
			String contentType = request.getHeader("Content-Type");
			
			if (contentType == null || !contentType.contains("application/json")) {
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
				response.setContentType("application/json");
				response.getWriter()
						.write("{\"success\": false, \"message\": \"Content-Type must be application/json\"}");
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