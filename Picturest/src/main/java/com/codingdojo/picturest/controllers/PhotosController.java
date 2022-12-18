package com.codingdojo.picturest.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.codingdojo.picturest.models.Photo;
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
	

	
	
	
// ------------------------- SHOW ONE PHOTO ------------------------- //
	@GetMapping("/show/{id}")
	private String showOnePhoto(@PathVariable("id") Long photoId, Model model, Principal principal) {
		model.addAttribute("photo", photoService.showOnePhoto(photoId));
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		
		//add the list of users who like this photo
		model.addAttribute("allLikes", photoService.showOnePhoto(photoId).getUsersWhoLikePhoto());
		return "showOnePicture.jsp";
		
	}
	
	
// ------------------------- EDIT ONE PHOTO ------------------------- //
	// TAKE USER TO EDIT PHOTO PAGE. NEED MODEL ATTRIBUTE FOR THE FORM:FORM BIND INFORMATION
	@GetMapping("/edit/photo/{id}")
	private String editPhotoPage(@PathVariable("id") Long photoId, Model model, Principal principal) {
		// ADD CURRENT USER TO MODEL (STOLEN FROM SHOW ONE PHOTO ROUTE)
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		// RETRIEVE PHOTO FROM DB TO DISPLAY ON EDIT PAGE USING ID FROM PATH
		Photo photo = photoService.showOnePhoto(photoId);
		// ADD PHOTO TO EDIT TO MODEL
		model.addAttribute("photo", photo);
		return "editPhoto.jsp";
	}
	
	//PUTMAPPING
	@PutMapping("/edit/photo/success/{id}")
	public String editPhoto(@Valid @ModelAttribute("photo") Photo photo, BindingResult result, @PathVariable("id") Long id, Model model ) {
		if(result.hasErrors()) {
			model.addAttribute("photo", photo);
			return "editPhoto.jsp";
		}
		else {
			photoService.updatePhoto(photo);
			return "redirect:/home";			
		}
	}


}
