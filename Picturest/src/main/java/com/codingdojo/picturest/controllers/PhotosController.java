package com.codingdojo.picturest.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.services.PhotoService;

@Controller
public class PhotosController {
	
	@Autowired
	private PhotoService photoService;
	
	
// ------------------------- SAVE PHOTO TO DB ------------------------- //
	//GET IMAGE FROM FORM:FORM AND SAVE TO DB
	@PostMapping("/add/photo/{id}")
	private String addImageToDb(@ModelAttribute("photoToAdd") Photo photoToAdd) {
		photoService.savePhotoToDb(photoToAdd);
		return "redirect:/home";
	}
	
	//REDIRECT USER BACK TO ADD ANOTHER PHOTO

}
