package com.codingdojo.picturest.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.codingdojo.picturest.models.Comment;
import com.codingdojo.picturest.models.Photo;
import com.codingdojo.picturest.models.User;
import com.codingdojo.picturest.repositories.CommentRepository;
import com.codingdojo.picturest.repositories.RoleRepository;
import com.codingdojo.picturest.repositories.UserRepository;

@Service
public class UserService {
    private UserRepository userRepository;
    private RoleRepository roleRepository;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
    @Autowired
    private PhotoService photoService;
    
    // Bring in CommentRepository so "thisComment" can be saved to db
    @Autowired
    private CommentRepository commentRepo;
    
    public UserService(UserRepository userRepository, RoleRepository roleRepository, BCryptPasswordEncoder bCryptPasswordEncoder)     {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }
    
    
    // SAVE A USER WITH USER ROLE
    public void saveWithUserRole(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepository.findByName("ROLE_USER"));
        userRepository.save(user);
    }
     
     // SAVE A USER AS AN ADMIN
    public void saveUserWithAdminRole(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepository.findByName("ROLE_ADMIN"));
        userRepository.save(user);
    }    
    
    // FIND A USER BY THEIR EMAIL
    public User findByUsername(String email) {
        return userRepository.findByEmail(email);
    }
    
    //FIND A USER BY THEIR ID
    public User findUserById(Long id) {
    	Optional<User> optionalUser = userRepository.findById(id);
    	if (optionalUser != null) {
    		return optionalUser.get();
    	}
    	return null;
    }
    
    //USER TO LIKE A PHOTO
    public User likePhoto(User user, Photo photo) {
    	//find the user
    	User thisUser = this.findUserById(user.getId());
    	
    	//add the photo to the list of photos the user has liked
    	thisUser.getLikedPhotos().add(photo);
    	return userRepository.save(thisUser);
    }
    
    //USER TO REMOVE THEIR LIKE FROM A PHOTO
    public User removePhotoLike(User user, Photo photo) {
    	//find the user
    	User thisUser = this.findUserById(user.getId());
    	
    	//remove the photo from the user's liked photos
    	thisUser.getLikedPhotos().remove(photo);
    	
    	return userRepository.save(thisUser);
    }
    

    

   
    
    
}
