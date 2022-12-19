package com.codingdojo.picturest.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Size(min=3)
	private String firstName;
	
	@Size(min=3)
	private String lastName;
	
    @Email
    private String email;
	
	@Size(min=8)
	private String password;

	@Transient
	private String passwordConfirmation;
	
	@Column(updatable=false)
	private Date createdAt;
	private Date updatedAt;
	
	
	//RELATIONSHIPS
	@OneToMany(mappedBy="user", fetch = FetchType.LAZY)
	private List<Photo> photos;
	
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(
			name = "user_likes_photo",
			joinColumns = @JoinColumn(name="user_id"),
			inverseJoinColumns = @JoinColumn(name="photo_id")
			)
	private List<Photo> likedPhotos;
	
	//NEW ONE-TO-MANY
	@OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
	private List<Comment> userComments;
	
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			name="user_likes_comment",
			joinColumns = @JoinColumn(name="user_id"),
			inverseJoinColumns = @JoinColumn(name="comment_id")
			)
	private List<Comment> commentsUserLikes;
	
	@ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
        name = "users_roles", 
        joinColumns = @JoinColumn(name = "user_id"), 
        inverseJoinColumns = @JoinColumn(name = "role_id"))
    private List<Role> roles;
	
	
	


	//EMPTY CONSTRUCTOR
	public User() {}
	
	
	//HANDLING CREATED AT/UPDATED AT
	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getFirstName() {
		return firstName;
	}


	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	public String getLastName() {
		return lastName;
	}


	public void setLastName(String lastName) {
		this.lastName = lastName;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}


	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
	}


	public Date getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}


	public Date getUpdatedAt() {
		return updatedAt;
	}


	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}


	public List<Photo> getPhotos() {
		return photos;
	}


	public void setPhotos(List<Photo> photos) {
		this.photos = photos;
	}


	public List<Photo> getLikedPhotos() {
		return likedPhotos;
	}


	public void setLikedPhotos(List<Photo> likedPhotos) {
		this.likedPhotos = likedPhotos;
	}


	public List<Comment> getUserComments() {
		return userComments;
	}


	public void setUserComments(List<Comment> userComments) {
		this.userComments = userComments;
	}


	public List<Comment> getCommentsUserLikes() {
		return commentsUserLikes;
	}


	public void setCommentsUserLikes(List<Comment> commentsUserLikes) {
		this.commentsUserLikes = commentsUserLikes;
	}


	public List<Role> getRoles() {
		return roles;
	}


	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	 

}
