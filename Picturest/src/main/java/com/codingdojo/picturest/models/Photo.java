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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;

import org.springframework.format.annotation.DateTimeFormat;


@Entity
@Table(name="photos")
public class Photo {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty
	private String photoURL;
	@NotEmpty
	private String photoTitle;
	@NotEmpty
	private String photoDescription;
	//will add tags later
	
	
	//RELATIONSHIPS
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			name="user_likes_photo",
			joinColumns = @JoinColumn(name="photo_id"),
			inverseJoinColumns = @JoinColumn(name="user_id")
			)
	private List<User> usersWhoLikePhoto;
	
	//NEW ONE-TO-MANY
	@OneToMany(mappedBy="photo", fetch = FetchType.LAZY)
	private List<Comment> comments;
	
	//CREATED AND UPDATED AT
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
	
    
	//EMPTY CONSTRUCTOR
	public Photo() {}
	
	
	//HANDLING CREATED AT/UPDATED AT
	@PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

    
  //GETTERS AND SETTERS
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getPhotoURL() {
		return photoURL;
	}


	public void setPhotoURL(String photoURL) {
		this.photoURL = photoURL;
	}


	public String getPhotoTitle() {
		return photoTitle;
	}


	public void setPhotoTitle(String photoTitle) {
		this.photoTitle = photoTitle;
	}


	public String getPhotoDescription() {
		return photoDescription;
	}


	public void setPhotoDescription(String photoDescription) {
		this.photoDescription = photoDescription;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public List<User> getUsersWhoLikePhoto() {
		return usersWhoLikePhoto;
	}


	public void setUsersWhoLikePhoto(List<User> usersWhoLikePhoto) {
		this.usersWhoLikePhoto = usersWhoLikePhoto;
	}


	public List<Comment> getComments() {
		return comments;
	}


	public void setComments(List<Comment> comments) {
		this.comments = comments;
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

    
    
    


}
