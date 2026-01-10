package com.store.electro.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/*
 * Controller testing endpoint nginx reverse proxy 
 * 
 * */
@RestController
@RequestMapping("api/")
public class TestController {


	@GetMapping("v1/hello")
	public String Hello() {
		return "Hello from backend service";
	}

}
