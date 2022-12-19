package com.codingdojo.picturest.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.picturest.models.Photo;

@Repository
public interface PhotoRepository extends CrudRepository<Photo, Long> {

	List<Photo> findAll();
	
//	List<Photo> findByUserNameIdIs(Long id);
	
}
