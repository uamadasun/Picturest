package com.codingdojo.picturest.services;

import java.util.List;

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

// =================== DELETE COMMENT BY COMMENT ID =================== //
    public Photo getPhotoByCommentId(Long id) {
    	Comment thisComment = commentRepo.findById(id).get();
    	Photo thisPhoto = thisComment.getPhoto();
    	return thisPhoto;
    }
    
}
