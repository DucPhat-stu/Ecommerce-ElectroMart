package com.store.electro.Middleware;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class FilterConfiguration implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new RequestLoggingInterceptor())
				.addPathPatterns("/api/**");
	}

	@Override
	public void addCorsMappings(CorsRegistry registry) {
		registry.addMapping("/**")
				.allowedOrigins(
					"http://localhost:5500",
					"http://127.0.0.1:5500",
					"http://localhost:3000",
					"http://127.0.0.1:3000"
				)
				.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH", "HEAD")
				.allowedHeaders("*")
				.allowCredentials(false)
				.maxAge(3600);
	}
}