package com.codingdojo.picturest.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.picturest.models.Comment;

public interface CommentRepository extends CrudRepository<Comment, Long> {
	
	List<Comment> findAll();
	List<Comment> findAllCommentsByUserId(Long id);
	List<Comment> findAllCommentsByPhotoId(Long id);

}
