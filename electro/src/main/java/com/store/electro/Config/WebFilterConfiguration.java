package com.store.electro.Config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.store.electro.Middleware.AuthenticationFilter;
import com.store.electro.Middleware.ValidationFilter;
import com.store.electro.Services.UserService;

@Configuration
public class WebFilterConfiguration {

	private final UserService userService;

	public WebFilterConfiguration(UserService userService) {
		this.userService = userService;
	}

	@Bean
	public FilterRegistrationBean<ValidationFilter> validationFilter() {
		FilterRegistrationBean<ValidationFilter> registrationBean = new FilterRegistrationBean<>();
		registrationBean.setFilter(new ValidationFilter());
		registrationBean.addUrlPatterns("/api/*");
		registrationBean.setOrder(1);
		return registrationBean;
	}

	@Bean
	public FilterRegistrationBean<AuthenticationFilter> authenticationFilter() {
		FilterRegistrationBean<AuthenticationFilter> registrationBean = new FilterRegistrationBean<>();
		registrationBean.setFilter(new AuthenticationFilter(userService));
		registrationBean.addUrlPatterns("/api/*");
		registrationBean.setOrder(2);
		return registrationBean;
	}
}
