package com.codingdojo.picturest.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
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
    public String addComment(@PathVariable("id") Long id, @RequestParam("photo") String photo, @RequestParam("comment") String comment, Principal principal) {
    	// get photoId, get userId, get comment string
    	Photo thisPhoto = photoService.showOnePhoto(id);
    	User thisUser = userService.findByUsername(principal.getName());
    	commentService.addComment(comment, thisPhoto, thisUser);
    	return "redirect:/show/{id}";
    }
    
    
// ========================== DELETE COMMENT ROUTE ========================== //

    @DeleteMapping("/delete/{id}")
    public String deleteComment(@PathVariable("id") Long id) {
    	// get photo id so you can redirect to show/{id}
    	//commentService.getPhotoByCommentId(id);
    	
    	commentService.deleteComment(id);
    	return "redirect:/home";
    	
    }
    
    

}
