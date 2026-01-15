package com.store.electro.Middleware;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.store.electro.Services.UserService;

@Configuration
public class FilterConfiguration implements WebMvcConfigurer {

	private final UserService userService;

	public FilterConfiguration(UserService userService) {
		this.userService = userService;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new RequestLoggingInterceptor())
				.addPathPatterns("/api/**");
	}
}