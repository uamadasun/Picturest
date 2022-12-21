package com.codingdojo.picturest.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.picturest.models.Comment;
import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.models.User;
import com.codingdojo.picturest.repositories.CommentRepository;

@Service
public class CommentService {
	
	@Autowired
	private CommentRepository commentRepo;
	
	// =================== GET ALL COMMENTs BY PHOTO ID =================== //
    public List<Comment> getCommentsByPhotoId(Long id){
    	List<Comment> CommentsByPhotoId = commentRepo.findAllCommentsByPhotoId(id);
    	if(CommentsByPhotoId == null) {
    		return null;
    	}
    	return CommentsByPhotoId;
    	}
    
 // =================== ADD COMMENT TO USER'S "usersWhoLikeComment" =================== //
    public void addComment(String thisComment, Photo thisPhoto, User thisUser) {
    	Comment newComment = new Comment(thisComment,thisUser,  thisPhoto);
    	commentRepo.save(newComment);
    }
    

// =================== DELETE COMMENT BY COMMENT ID =================== //
    public void deleteComment(Long id) {
    	commentRepo.deleteById(id);
    }

// =================== GET PHOTO BY COMMENT ID =================== //
    public Photo getPhotoByCommentId(Long id) {
    	Comment thisComment = commentRepo.findById(id).get();
    	Photo thisPhoto = thisComment.getPhoto();
    	return thisPhoto;
    }
 
 // =================== LIKE A COMMENT =================== //
    public void likeComment(Long commentId, User thisUser) {
    	// find comment object by comment id
    	Optional optionalComment =  commentRepo.findById(commentId);
    	if(optionalComment.isPresent()) {
    		// "get" comment
    		Comment thisComment = (Comment) optionalComment.get();
    		// add user to to UsersWhoLikeComment list
    		thisComment.getUsersWhoLikeComment().add(thisUser);
    		commentRepo.save(thisComment);
    	}	
    }
    
 // =================== LIKE A COMMENT =================== //
    public void dislikeComment(Long commentId, User thisUser) {
    	// find comment object by comment id
    	Optional optionalComment =  commentRepo.findById(commentId);
    	if(optionalComment.isPresent()) {
    		// "get" comment
    		Comment thisComment = (Comment) optionalComment.get();
    		// add user to to UsersWhoLikeComment list
    		thisComment.getUsersWhoLikeComment().remove(thisUser);
    		commentRepo.save(thisComment);
    	}
    }
    
// =================== EDIT A COMMENT =================== //
    
    public Comment editComment(Comment commentToEdit){
    	
    	return commentRepo.save(commentToEdit);
    }

    
}