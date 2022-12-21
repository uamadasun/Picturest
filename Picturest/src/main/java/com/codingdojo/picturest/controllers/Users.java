package com.codingdojo.picturest.controllers;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.models.User;
import com.codingdojo.picturest.services.PhotoService;
import com.codingdojo.picturest.services.UserService;
import com.codingdojo.picturest.validator.UserValidator;

@Controller
public class Users {
	
	private UserService userService;
	private UserValidator userValidator;
	
	// Bringing in PhotoService so we can make use of "getAllPhotos"
	@Autowired
	private PhotoService photoService;
    
	
	public Users(UserService userService, UserValidator userValidator) {
        this.userService = userService;
        this.userValidator = userValidator;
    }
    
    @RequestMapping("/registration")
    public String registerForm(@Valid @ModelAttribute("user") User user) {
        return "registrationPage.jsp";
    }
    
    @PostMapping("/registration")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model, RedirectAttributes redirAttrs) {
    	userValidator.validate(user, result);
    	if (result.hasErrors()) {
            return "registrationPage.jsp";
        }
        userService.saveWithUserRole(user);
        return "redirect:/login";
    }
    
    
    @RequestMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model) {
        if(error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(logout != null) {
            model.addAttribute("logoutMessage", "Logout Successful!");
        }
        
        return "loginPage.jsp";
    }
    
    @RequestMapping(value = {"/", "/home"})
    public String home(Principal principal, Model model) {
        // 1
        String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        // Adding all photos to model 
        List<Photo> allPhotos = photoService.getAllPhotos();
        
        allPhotos.sort((Photo s1, Photo s2)->s2.getUsersWhoLikePhoto().size() - s1.getUsersWhoLikePhoto().size()); 
        model.addAttribute("allPhotos", allPhotos);
     
        return "homePage.jsp";
    }
    
    
    
    //  ======== User to like a photo =======
    @GetMapping("/like/{id}")
    public String likePhoto(@PathVariable("id") Long photoId, Principal principal, Model model) {
    	//find the photo object
    	Photo thisPhoto = photoService.showOnePhoto(photoId);
    	
    	//find the user object
    	User thisUser = userService.findByUsername(principal.getName());
    	
    	//call the likePhoto method in the userService
    	userService.likePhoto(thisUser, thisPhoto);

    	//adding "editPressed" boolean to model to be able to toggle edit form

    	return "redirect:/show/{id}";
    	
    }
    
//  ======== User to remove their like from a photo =======
    @GetMapping("/dislike/{id}")
    public String dislikePhoto(@PathVariable("id") Long photoId, Principal principal, Model model) {
    	//find the photo object
    	Photo thisPhoto = photoService.showOnePhoto(photoId);
    	
    	//find the user object
    	User thisUser = userService.findByUsername(principal.getName());
    	
    	userService.removePhotoLike(thisUser, thisPhoto);
    	
    	//adding "editPressed" boolean to model to be able to toggle edit form

    	return "redirect:/show/{id}";
    	
    }
    

    
    
    
    
    
    
    
    
}
