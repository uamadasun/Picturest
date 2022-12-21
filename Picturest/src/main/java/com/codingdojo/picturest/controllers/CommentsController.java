package com.codingdojo.picturest.controllers;

import java.security.Principal;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.picturest.models.Comment;
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

    	return "redirect:/show/" + thisId;
    	
    }
    
 // ========================== EDIT A COMMENT IN PLACE ========================== //
    
    @PostMapping("/edit/comment/page/{id}")
    public String editCommentPage(@PathVariable("id") Long id, Model model, HttpSession session) {
    	// get comment by id so you can get the photo by so  you can then redirect to show/{id}
    	//commentService.getPhotoByCommentId(id);
    	Photo thisPhoto = commentService.getPhotoByCommentId(id);
    	Long thisId  = thisPhoto.getId();
    	
		// ADD COMMENT ID TO EDIT TO SESSION clear session when actually editing
		session.setAttribute("commentId", id);
    	
//		if( (Boolean) session.getAttribute("editPressed") == false){
//			session.setAttribute("editPressed", true);
//		}
//		else{
//			session.setAttribute("editPressed", false);
//		}	

    	// flip boolean session attribute "editPressed"
    	System.out.println(session.getAttribute("editPressed"));
    	return "redirect:/show/" + thisId;
    	
    }
    
    
    @PutMapping("/edit/comment/{id}")
    public String editComment(@Valid @ModelAttribute("commentToEdit") Comment commentToEdit, BindingResult result, @PathVariable("id") Long id, HttpSession session) {
    	// get photo id
    	Photo thisPhoto = commentService.getPhotoByCommentId(id);
    	Long thisId  = thisPhoto.getId();
    	if(result.hasErrors()) {
    		System.out.println(result.getAllErrors());
    		return "redirect:/show/" + thisId;
    	}
    	commentService.editComment(commentToEdit);

    	// Remove commentId from session
    	session.removeAttribute("commentId");
    	return "redirect:/show/" + thisId;
    }
    
    @GetMapping("/cancel/edit/comment/{id}")
    public String cancelCommentEdit(@PathVariable("id") Long id, HttpSession session) {
    	// get photo id
    	Photo thisPhoto = commentService.getPhotoByCommentId(id);
    	Long thisId  = thisPhoto.getId();
    	System.out.println("WE HAVE CANCELLED!");
    	// Remove commentId from session
    	session.removeAttribute("commentId");
    	return "redirect:/show/" + thisId;
    }
    
 // ========================== LIKE A COMMENT ========================== // 
    @PostMapping("/like/comment/{id}")
    public String addLikeToComment(@PathVariable("id") Long commentId, Principal principal) {
    	// get photo object from comment id
    	Photo thisPhoto = commentService.getPhotoByCommentId(commentId);
    	// get photoId from photo object
    	Long photoId = thisPhoto.getId();
    	
    	// get user object from principal
    	User thisUser = userService.findByUsername(principal.getName());
    	
    	// pass comment id and user to add to usersWhoLikeComment
    	commentService.likeComment(commentId, thisUser);
    	
    	return "redirect:/show/" + photoId;
    }
    
    
 
       
 // ========================== DISLIKE A COMMENT ========================== //
    //dislikeComment
    @PostMapping("/dislike/comment/{id}")
    public String dislikeComment(@PathVariable("id") Long commentId, Principal principal) {
    	// get photo object from comment id
    	Photo thisPhoto = commentService.getPhotoByCommentId(commentId);
    	// get photoId from photo object
    	Long photoId = thisPhoto.getId();
    	
    	// get user object from principal
    	User thisUser = userService.findByUsername(principal.getName());
    	
    	// pass comment id and user to add to usersWhoLikeComment
    	commentService.dislikeComment(commentId, thisUser);
    	
    	return "redirect:/show/" + photoId;
    }
    

}