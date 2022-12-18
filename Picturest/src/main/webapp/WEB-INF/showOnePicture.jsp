<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Image Details</title>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="/css/index.css">
	<!-- Bootstrap JS -->
	<script type="text/javascript" src="/js/bootstrap.js"></script>
	<!-- Custom JS -->
	<script type="text/javascript" src="/js/index.js"></script>
</head>
<body>

	<!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="/"><img class="navbar-logo" src="https://cdn-icons-png.flaticon.com/512/7917/7917097.png"
                    alt="logo camera image">Picturest</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">

                <!-- Change to ms-auto to give space between brand name and the links -->
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 gap-3">
                    <!-- <li class="nav-item">
                        <a class="nav-link btn btn-secondary text-light" href="#">Log In</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-primary text-light" href="#">Register</a>
                    </li> -->
                    <li>
                    	<a class="btn btn-warning" href="/images/new">Add Image</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" href="#">Welcome: <c:out value="${currentUser.firstName}"></c:out></a>
                    </li>
                    <li class="nav-item">
                    	<form id="logoutForm" method="POST" action="/logout">
        					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        					<input class="btn btn-secondary" type="submit" value="Logout" />
    					</form>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


	<!-- Main Content -->
	
	<div class="container">
	
		<div class="row">
		
			<!-- WHOLE CARD SECTION -->
			<div class="card mb-3 p-3 mx-auto showOne-box shadow">
  				<div class="row g-3">
  				
  					<!-- Right Side of the Card -->
    				<div class="col-md-5">
      					<img src="${ photo.getPhotoURL() }" class="img-fluid img-showOne" alt="...">
   					 </div>
   					 
   					 <!-- Left Side of the Card -->
    				<div class="col-md-7">
    					<div class="d-flex justify-content-end align-items-center gap-4 ms-3">
    						<!-- Edit button -->
    						<c:if test="${photo.user.id == currentUser.id }">
							<a href="/edit/${photo.getId()}" class="btn btn-info edit-btn">edit</a>
							</c:if>
							
      						
      						<img class="sharebtn me-3" src="https://cdn-icons-png.flaticon.com/512/1968/1968777.png" alt="share button" />
      					</div>
    				
      					<div class="card-body">
      						
      						<!-- Title -->
        					<h1 class="card-title mb-2"><c:out value="${photo.photoTitle }"/></h1>
        					<!-- Photo by: -->
        					<p class="card-text">Photo by: <c:out value="${photo.user.firstName }"/></p>
        					<!-- Description -->
       						<p class="card-text"><c:out value="${photo.photoDescription }"/></p>
       						
       						<!-- ======= Like button and counter =========== -->
       						<div class="d-flex align-items-end gap-3 mb-2">
       							<a href="/like/${photo.getId() }"><img class="like-btn" src="https://cdn-icons-png.flaticon.com/512/456/456115.png" alt="" /></a> 
       							<p class="card-text">Likes: </p>
       						</div>
       						
       						<!-- Comments from other users -->
       						<h4 class="comment-title me-2 mb-3">Comments</h4><img class="arrow-down" src="https://cdn-icons-png.flaticon.com/512/32/32195.png" alt="" />
       						
       						<!-- ========= below is where the comments should go =========  -->
       						<p class="card-text"></p>
       						
       						
       					
      					</div>
      					
      					<!-- Comment Form -->
       					
      					<div class="card-footer">
      						<form action="/comment/${photo.getId() }" method="post">
  								<textarea class="form-control comment-box" id="exampleFormControlTextarea1" rows="2" placeholder="Add a comment"></textarea>
  								<input type="hidden" name="user" value="${currentUser}">
								<input type="hidden" name="photo" value="${photo}">
								<input class="btn btn-secondary comment-btn mt-2" type="submit" />
  							</form>
  						</div>
  						
  						
  						
  						
  						
    				</div>
    				
  				</div>
			</div>
			
		</div>

	</div>







</body>
</html>