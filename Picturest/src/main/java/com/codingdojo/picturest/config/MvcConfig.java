package com.codingdojo.picturest.config;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		Path photoUploadDir = Paths.get("./src/main/resources/static/pictures/");
		
		
		String photoUploadPath = photoUploadDir.toFile().getAbsolutePath();
		
		registry.addResourceHandler("./src/main/resources/static/pictures/**").addResourceLocations("file:/" + photoUploadPath + "/");
	}
	
	

}
