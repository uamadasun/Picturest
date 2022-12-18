package com.codingdojo.picturest.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.repositories.PhotoRepository;

@Service
public class PhotoService {
	
	@Autowired
	private PhotoRepository photoRepo;
	
// ------------------------- SAVE PHOTO TO DB ------------------------- // 	
	public void savePhotoToDb(Photo photoToAdd) {
		photoRepo.save(photoToAdd);
	}

// ------------------------- GET ALL PHOTOS FROM THE DB ------------------------- // 
	public List<Photo> getAllPhotos(){
		return photoRepo.findAll();
	}
	
// ------------------------- SHOW ONE PHOTO FROM THE DB ------------------------- //
	public Photo showOnePhoto(Long id) {
		Optional<Photo> optionalPhoto = photoRepo.findById(id);
		if (optionalPhoto.isPresent()) {
			return optionalPhoto.get();
		}
		return null;
	}
	
// ------------------------- EDIT ONE PHOTO FROM THE DB ------------------------- //
	public Photo updatePhoto(Photo photo) {
		return photoRepo.save(photo);
	}




	
}
