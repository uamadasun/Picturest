package com.codingdojo.picturest.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.models.User;
import com.codingdojo.picturest.services.PhotoService;
import com.codingdojo.picturest.services.UserService;

@Controller
public class PhotosController {
	
	@Autowired
	private PhotoService photoService;
	
	//bringing in user service for liking and commenting on photo
	@Autowired
	private UserService userService;
	
	
// ------------------------- SAVE PHOTO TO DB ------------------------- //
	//GET IMAGE FROM FORM:FORM AND SAVE TO DB
	@PostMapping("/add/photo")
	private String addImageToDb(@ModelAttribute("photoToAdd") Photo photoToAdd, Principal principal) {
		photoService.savePhotoToDb(photoToAdd);
		return "redirect:/home";
	}
	
	//REDIRECT USER BACK TO ADD ANOTHER PHOTO
	
	
	
// ------------------------- SHOW ONE PHOTO ------------------------- //
	@GetMapping("/show/{id}")
	private String showOnePhoto(@PathVariable("id") Long photoId, Model model, Principal principal) {
		model.addAttribute("photo", photoService.showOnePhoto(photoId));
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		return "showOnePicture.jsp";
		
	}
	
	
// ------------------------- TODO EDIT ONE PHOTO ------------------------- //


}
