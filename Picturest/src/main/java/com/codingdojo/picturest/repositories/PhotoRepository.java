package com.codingdojo.picturest.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.picturest.models.Photo;

@Repository
public interface PhotoRepository extends CrudRepository<Photo, Long> {

	List<Photo> findAll();
	
//	@Query("SELECT photos.id, photo_description, photo_title, photourl,COUNT(user_likes_photo.photo_id) FROM photos JOIN user_likes_photo ON photos.id = user_likes_photo.photo_id GROUP BY photos.id")
//	List<Photo> findAllByLikesCount();
//	List<Photo> findAllByOrderByUsersWhoLikePhotoDesc();
	
	
}
