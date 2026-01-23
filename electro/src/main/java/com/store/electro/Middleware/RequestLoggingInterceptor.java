package com.store.electro.Middleware;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RequestLoggingInterceptor implements HandlerInterceptor {

	private static final Logger logger = LoggerFactory.getLogger(RequestLoggingInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		long startTime = System.currentTimeMillis();
		request.setAttribute("startTime", startTime);

		logger.info("REQUEST: {} {} from {}", request.getMethod(), request.getRequestURI(),
				request.getRemoteAddr());
		return true;
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) throws Exception {
		long startTime = (Long) request.getAttribute("startTime");
		long duration = System.currentTimeMillis() - startTime;

		logger.info("RESPONSE: {} {} - Status: {} - Duration: {}ms", request.getMethod(), request.getRequestURI(),
				response.getStatus(), duration);
	}
}