package com.codingdojo.picturest.controllers;

//import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.codingdojo.picturest.models.Comment;
import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.repositories.PhotoRepository;
import com.codingdojo.picturest.services.CommentService;
import com.codingdojo.picturest.services.PhotoService;
import com.codingdojo.picturest.services.UserService;

@Controller
public class PhotosController {
	
	@Autowired
	private PhotoService photoService;
	@Autowired 
	private PhotoRepository photoRepository;
	
	//bringing in user service for liking and commenting on photo
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommentService commentService;
	
	
	
	// ------------------------- NEW IMAGE FORM ------------------------- //
	@GetMapping("/images/new")
	public String newImageForm(Principal principal, Model model) {
		String email = principal.getName();
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		model.addAttribute("photo", new Photo());
		return "newImage.jsp";
	}
	
// ------------------------- SAVE PHOTO TO DB ------------------------- //
	//GET IMAGE FROM FORM:FORM AND SAVE TO DB
	@PostMapping("/images/new")
	private String addImageToDb(@Valid @ModelAttribute("photo") Photo photo, BindingResult result, Principal principal, Model model) {		
		if(result.hasErrors()) {
			model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
			return "newImage.jsp";
		}
		photoService.savePhotoToDb(photo);
		return "redirect:/home";
	}
	
	
// ================ UPLOAD A PHOTO =================
	@GetMapping("/upload")
	public String uploadPhotoForm(Principal principal, Model model) {
		// 1
        String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        model.addAttribute("photo", new Photo());
        return "uploadPhoto.jsp";
	}
	
	@PostMapping("/upload")
	public String uploadPhoto(@Valid @ModelAttribute("photo") Photo photo, BindingResult result, @RequestParam("fileImage") MultipartFile multipartFile, Principal principal, Model model) throws IOException {

		// 1
        String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        
        String fileName = StringUtils.cleanPath(multipartFile.getOriginalFilename());
        
        photo.setPhotoFileName(fileName);
        
        if (photo.getPhotoFileName().length()<1) {
        	result.rejectValue("photoFileName", "missing", "Must upload a file");
        }
        
        //save new photo
        if(result.hasErrors()) {
        	model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
			return "uploadPhoto.jsp";
        }
        Photo savedPhoto = photoRepository.save(photo);
        
        //create upload directory
        String uploadDir = "./src/main/resources/static/pictures/" + savedPhoto.getId();
        Path uploadPath = Paths.get(uploadDir);
        
        if (!Files.exists(uploadPath)) {
        	Files.createDirectories(uploadPath);
        }
        
        try (InputStream inputStream = multipartFile.getInputStream()) {
        	Path filePath = uploadPath.resolve(fileName);
//        	System.out.println(filePath.toFile().getAbsolutePath());
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
        	throw new IOException("Could not save uploaded file: " + fileName);
        }
        
        return "redirect:/home";
		
	}
	

// ------------------------- SHOW ONE PHOTO ------------------------- //
	@GetMapping("/show/{id}")
	private String showOnePhoto(@PathVariable("id") Long photoId, Model model, Principal principal) {
		model.addAttribute("photo", photoService.showOnePhoto(photoId));
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		
		//add the list of users who like this photo
		model.addAttribute("allLikes", photoService.showOnePhoto(photoId).getUsersWhoLikePhoto());
		
		//add all of the comments on the photo - get all comments by photoId?
		model.addAttribute("allCommentsByPhotoId", commentService.getCommentsByPhotoId(photoId));
		return "showOnePicture.jsp";
		
	}
	

// ------------------------- EDIT ONE PHOTO ------------------------- //
	// TAKE USER TO EDIT PHOTO PAGE. NEED MODEL ATTRIBUTE FOR THE FORM:FORM BIND INFORMATION
	@GetMapping("/edit/photo/{id}")
	private String editPhotoPage(@PathVariable("id") Long photoId, Model model, Principal principal) {
		// ADD CURRENT USER TO MODEL (STOLEN FROM SHOW ONE PHOTO ROUTE)
		model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
		// RETRIEVE PHOTO FROM DB TO DISPLAY ON EDIT PAGE USING ID FROM PATH
		Photo photo = photoService.showOnePhoto(photoId);
		// ADD PHOTO TO EDIT TO MODEL
		model.addAttribute("photo", photo);
		return "editPhoto.jsp";
	}
	
	//PUTMAPPING
	@PutMapping("/edit/photo/success/{id}")
	public String editPhoto(@Valid @ModelAttribute("photo") Photo photo, BindingResult result, @PathVariable("id") Long id, Model model, Principal principal ) {
		if(result.hasErrors()) {
			model.addAttribute("photo", photo);
			model.addAttribute("currentUser", userService.findByUsername(principal.getName()));
			return "editPhoto.jsp";
		}
		else {
			photoService.updatePhoto(photo);
			return "redirect:/show/{id}";			
		}
	}

	
	// ================ SHOW ONE USER PHOTOS =================
	@GetMapping("/show/one/user")
	public String showOneUser(Principal principal, Model model) {
        // 1
        String email = principal.getName();
        model.addAttribute("currentUser", userService.findByUsername(email));
        // Adding all photos to model 
        model.addAttribute("allPhotos", photoService.getAllPhotos());
     
        return "showOneUser.jsp";
    }
	
	
	
		
	// ================ DELETE A PHOTO =================
	@DeleteMapping("/delete/photo/{id}")
	public String deletePhoto(@PathVariable("id") Long id, Principal principal) {
		//find all the comments on this photo and delete it from photo
		for(Comment comment:commentService.getCommentsByPhotoId(id)) {
			commentService.deleteComment(comment.getId());
		}
		photoService.deletePhoto(id);
		return "redirect:/home";
	}
	
	
	
	
	
	
	

}
