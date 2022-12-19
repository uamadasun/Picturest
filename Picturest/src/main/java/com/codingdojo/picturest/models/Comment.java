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
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;


@Entity
@Table(name="user_comments_on_photo")
public class Comment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	private String comment;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="photo_id")
    private Photo photo;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			name="user_likes_comment",
			joinColumns = @JoinColumn(name="comment_id"),
			inverseJoinColumns = @JoinColumn(name="user_id")
			)
	private List<User> usersWhoLikeComment;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    
  //CREATE EMPTY CONSTRUCTOR
    public Comment() {}
    
    // create a comment with inputs: comment, user, photo
    public Comment(String comment, User user, Photo photo) {
    	this.comment = comment;
    	this.user = user;
    	this.photo = photo;
    }
    
    
  //HANDLING CREATED AT AND UPDATED AT
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


	public String getComment() {
		return comment;
	}


	public void setComment(String comment) {
		this.comment = comment;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public Photo getPhoto() {
		return photo;
	}


	public void setPhoto(Photo photo) {
		this.photo = photo;
	}


	public List<User> getUsersWhoLikeComment() {
		return usersWhoLikeComment;
	}


	public void setUsersWhoLikeComment(List<User> usersWhoLikeComment) {
		this.usersWhoLikeComment = usersWhoLikeComment;
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
