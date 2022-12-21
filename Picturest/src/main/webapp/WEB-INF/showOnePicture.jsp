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

                <!-- ms-auto to give space between brand name and the links -->
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0 gap-3">
                
                	<li>
                    	<a class="btn btn-secondary add-img-btn text-light mt-1" href="/images/new">Add Image</a>
                    </li>
                	
                	<!-- =========== dropdown nav item =============-->
                	<li class="nav-item dropdown">
          				<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            				Welcome: <c:out value="${ currentUser.firstName}" />
          				</a>
          				<ul class="dropdown-menu">
          					<!-- have to change the link below for showOneUser route -->
            				<li><a class="dropdown-item" href="/show/one/user">My Profile</a></li>
            				<li><a class="dropdown-item" href="/images/new">Add Image</a></li>
            				<li><hr class="dropdown-divider"></li>
            				<li>
            					<form id="logoutForm" method="POST" action="/logout">
        						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        						<input class="dropdown-item" type="submit" value="Logout" />
    							</form>
            				</li>
          				</ul>
        			</li>
        			<!-- ============End of dropdown nav item================ -->
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
  				
  					<!-- Left Side of the Card -->
    				<div class="col-md-5">
    				
	    				<c:if test="${photo.getPhotoURL() == null}">
	                        <img src="${photo.getPhotoImagePath() }"  class="img-fluid img-showOne" alt="..."/> 
	                   	</c:if>
	                            
	                    <c:if test="${photo.getPhotoURL() != null}">
	                        <img class="img-prev" src="${ photo.getPhotoURL() }"  class="img-fluid img-showOne" alt="...">
	                    </c:if>
   					 </div>
   					 
   					 <!-- Right Side of the Card -->
    				<div class="col-md-7">
    					<div class="d-flex justify-content-end align-items-center gap-4 ms-3">
    						<!-- Edit button -->
    						<c:if test="${photo.user.id == currentUser.id }">
							<a href="/edit/photo/${photo.getId()}" class="btn btn-info edit-btn">edit</a>
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
       						
       						<div class="d-flex gap-3 align-items-center">
       						
       						<!-- if user likes the photo, they will see this message instead of the like button; recommend making it a dislike button of some sort-->
       						<c:if test="${allLikes.contains(currentUser) }">
							<a href="/dislike/${photo.getId() }"><img class="like-btn" src="https://cdn-icons-png.flaticon.com/512/1634/1634504.png" alt="dislike button" /></a>
							</c:if>
							
							<!--  if the user hasn't yet liked the photo, they will see the like button-->
							<c:if test="${!allLikes.contains(currentUser) }">
							<div class="d-flex align-items-end gap-3 mb-2">
       							<a href="/like/${photo.getId() }"><img class="like-btn" src="https://cdn-icons-png.flaticon.com/512/456/456115.png" alt="" /></a> 
       						</div>
							</c:if>
							
							<!-- Likes counter -->
							<p class="card-text">Likes: <c:out value="${allLikes.size() }"/></p>
							</div>
     
       						
       						<!-- Comments from other users -->
       						<h4 class="comment-title me-2 mb-4">Comments</h4><img class="arrow-down" src="https://cdn-icons-png.flaticon.com/512/32/32195.png" alt="" />
       						
       						<!-- ========= below is where the comments should go =========  -->
       						
       						<c:forEach var = "eachComment" items = "${allCommentsByPhotoId}">
      							<div class="card-text d-flex gap-2 mb-4">
      							
      							<img class="user-comment-card" src="https://cdn-icons-png.flaticon.com/512/1053/1053244.png" alt="" />
      							
      							<div>
      							
      							<div class="mb-2">
      							<c:choose >
      								<c:when test = "${ editPressed == false }">
       									<c:out  value = "${eachComment.user.getFirstName()} says: ${ eachComment.getComment() }"></c:out>
       								</c:when>
       								<c:otherwise>
       									<span class="username">
                    						<c:out value="${eachComment.user.getFirstName()}"></c:out>:
                						</span>
                						<c:out value="${ eachComment.getComment()}"></c:out>
       								</c:otherwise>		
       							</c:choose>
       							</div>
       							
       							<!-- Heart Icon and like comment counter and Edit Delete button -->
       							<div class="d-flex align-items-center gap-3">
       							<c:out value = "Likes: ${ eachComment.usersWhoLikeComment.size() }"></c:out>
       							
       							
       							
       							<!--  -->
       							<c:choose> 
       							<c:when test = "${ editPressed == false }">
	       							<c:if test = "${ eachComment.user.getId() == currentUser.id }">
		       								<form:form action = "/delete/${eachComment.getId()}" method="delete">
											    <p class="submit">
											    	<input class="btn btn-danger del-cmt-btn" type="submit" value="Delete"/>
											    </p>
											</form:form>
											
											<form:form action = "/edit/comment/${eachComment.getId()}">
											    <p class="submit">
											    	<input class="btn btn-secondary edit-cmt-btn" type="submit" value="Edit"/>
											    </p>
											</form:form>
											<!-- Like a comment -->
											<c:if test="${!eachComment.usersWhoLikeComment.contains(currentUser)}">
											<form:form action = "/like/comment/${eachComment.getId()}">
											    <p class="submit">
											    	<input class="btn btn-secondary edit-cmt-btn" type="submit" value="Like"/>
											    </p>
											</form:form>
											<!-- Dislike/Unlike a comment -->											
											</c:if>
											<c:if test="${eachComment.usersWhoLikeComment.contains(currentUser)}">
											<form:form action = "/dislike/comment/${eachComment.getId()}">
											    <p class="submit">
											    	<input class="btn btn-secondary edit-cmt-btn" type="submit" value="Dislike"/>
											    </p>
											</form:form>
											</c:if>
																						
	       							</c:if>	
								</c:when>
								<c:otherwise>
								<!-- IGNORE: EDIT COMMENT IN PROGRESS -->
		       								<form:form action = "/edit/comment/${eachComment.getId()}">
											    <p class="submit">
											    	<input class="btn btn-danger del-cmt-btn" type="submit" value="Cancel Edit"/>
											    </p>
											</form:form>
											
											<form:form action = "/edit/comment/${eachComment.getId()}">
											    <p class="submit">
											    	<input class="btn btn-secondary edit-cmt-btn" type="submit" value="Submit Edit"/>
											    </p>
											</form:form>
								</c:otherwise>
								</c:choose>
       							</div>
       							
       							</div>	
       											
       							</div>
       						</c:forEach>
       						
       						
       						
       						
       					
      					</div>
      					
      					<!-- Comment Form -->
       					
      					<div class="card-footer">
      						<form action="/comment/${photo.getId() }" method="post">
  								<textarea name="comment" class="form-control comment-box" id="exampleFormControlTextarea1" rows="2" placeholder="Add a comment"></textarea>
								<input type="hidden" name="photo" value="${photo}">
								<input class="btn btn-secondary comment-btn mt-2" type="submit" />
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
  							</form>
  						</div>
  						
  						
  						
  						
  						
    				</div>
    				
  				</div>
			</div>
			
		</div>

	</div>







</body>
</html>