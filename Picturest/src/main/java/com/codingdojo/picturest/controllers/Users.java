package com.codingdojo.picturest.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
    	userValidator.validate(user, result);
    	if (result.hasErrors()) {
            return "registrationPage.jsp";
        }
        userService.saveWithUserRole(user);
        return "redirect:/";
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
        model.addAttribute("allPhotos", photoService.getAllPhotos());
        return "homePage.jsp";
    }
    
    //    ======== new image form =======
    @GetMapping("/images/new")
    public String newImageForm(Principal principal, Model model, @ModelAttribute("photoToAdd") Photo photoToAdd) {
    	String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
    	return "newImage.jsp";
    }
    
}
