package com.codingdojo.picturest.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.models.User;
import com.codingdojo.picturest.services.CommentService;
import com.codingdojo.picturest.services.PhotoService;
import com.codingdojo.picturest.services.UserService;

@Controller
public class CommentsController {
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private PhotoService photoService;
	
	@Autowired
	private UserService userService;
	

	
// ========================== ADD COMMENT ROUTE ========================== //
    // Validations?
    @PostMapping("/comment/{id}")
    public String addComment(@PathVariable("id") Long id, @RequestParam("photo") String photo, @RequestParam("comment") String comment, Principal principal, Model model) {
    	// get photoId, get userId, get comment string
    	Photo thisPhoto = photoService.showOnePhoto(id);
    	User thisUser = userService.findByUsername(principal.getName());
    	commentService.addComment(comment, thisPhoto, thisUser);
    	//adding "editPressed" boolean to model to be able to toggle edit form
    	Boolean editPressed = false;
    	model.addAttribute("editPressed", editPressed);
    	return "redirect:/show/{id}";
    }
    
    
// ========================== DELETE COMMENT ROUTE ========================== //

    @DeleteMapping("/delete/{id}")
    public String deleteComment(@PathVariable("id") Long id, Model model) {
    	// get comment by id so you can get the photo by so  you can then redirect to show/{id}
    	//commentService.getPhotoByCommentId(id);
    	Photo thisPhoto = commentService.getPhotoByCommentId(id);
    	Long thisId  = thisPhoto.getId();
    	commentService.deleteComment(id);
    	//adding "editPressed" boolean to model to be able to toggle edit form
    	Boolean editPressed = false;
    	model.addAttribute("editPressed", editPressed);
    	return "redirect:/show/" + thisId;
    	
    }
    
 // ========================== EDIT A COMMENT IN PLACE ========================== //
    
    @GetMapping("/edit/{id}")
    public String editComment(@PathVariable("id") Long id, Model model) {
    	// get comment by id so you can get the photo by so  you can then redirect to show/{id}
    	//commentService.getPhotoByCommentId(id);
    	Photo thisPhoto = commentService.getPhotoByCommentId(id);
    	Long thisId  = thisPhoto.getId();
    	Boolean editPressed = true;
    	model.addAttribute("editPressed", editPressed);
    	return "redirect:/show/" + thisId;
    	
    }
    
    

}
