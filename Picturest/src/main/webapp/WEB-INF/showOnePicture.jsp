

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ page isErrorPage="true" %>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Picturest - Image Details</title>
	<!-- Favicon -->
	<link rel="icon" type="image/x-icon" href="https://cdn-icons-png.flaticon.com/512/7917/7917097.png" />
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
                		<!-- Added a new route -->
                    	<a class="btn btn-secondary add-img-btn text-light mt-1" href="/upload/menu">Add Image</a>
                    </li>
                	
                	<!-- =========== dropdown nav item =============-->
                	<li class="nav-item dropdown">
          				<a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            				Welcome: <c:out value="${ currentUser.firstName}" />
          				</a>
          				<ul class="dropdown-menu">
          					<!-- have to change the link below for showOneUser route -->
            				<li><a class="dropdown-item" href="/show/one/user">My Profile</a></li>
            				<li><a class="dropdown-item" href="/upload/menu">Add Image</a></li>
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
	                        <img src="${ photo.getPhotoURL() }"  class="img-fluid img-showOne" alt="...">
	                    </c:if>
   					 </div>
   					 
   					 <!-- Right Side of the Card -->
    				<div class="col-md-7">
    					<div class="d-flex justify-content-end align-items-center gap-4 me-4">
    						<!-- Edit button -->
    						<c:if test="${photo.user.id == currentUser.id }">
							<a href="/edit/photo/${photo.getId()}" class="btn btn-info edit-btn text-light">Edit</a>
							<form action="/delete/photo/${photo.getId()}" method="post">
									<input type="hidden" name="_method" value="delete">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
									<input class="btn btn-danger delete-img-btn" type="submit" value="Delete Photo"/>
								</form>
							</c:if>
							
      						<!-- Share button - will add later in the future -->
      						<!-- <img class="sharebtn me-3" src="https://cdn-icons-png.flaticon.com/512/1968/1968777.png" alt="share button" /> -->
      					</div>
    				
      					<div class="card-body">
      						
      						<!-- Title -->
        					<h1 class="card-title mb-2 img-card-title"><c:out value="${photo.photoTitle }"/></h1>
        					<!-- Description -->
       						<p class="card-text img-card-desc"><c:out value="${photo.photoDescription }"/></p>
        					<!-- Photo by: -->
        					<div class="mb-3 d-flex gap-2 align-items-center">
								<img class="user-img-card" src="https://cdn-icons-png.flaticon.com/512/8731/8731440.png" alt="default user image" />
								<p class="user-img-name username"><c:out value="${photo.user.firstName} ${photo.user.lastName }"></c:out></p>
							</div>
        					
       						
       						<!-- ======= Like button and counter =========== -->
       						
       					<div class="d-flex gap-3 align-items-end mb-3">
       						
       						
							
							<!--  if the user hasn't yet liked the photo, they will see the like button-->
							<c:if test="${!allLikes.contains(currentUser) }">
       							<a href="/like/${photo.getId() }"><img class="like-btn" src="https://cdn-icons-png.flaticon.com/512/880/880554.png" alt="" /></a> 
							</c:if>
							
							<!-- if user likes the photo, they will see this message instead of the like button; recommend making it a dislike button of some sort-->
       						<c:if test="${allLikes.contains(currentUser) }">
								<a href="/dislike/${photo.getId() }"><img class="like-btn" src="https://cdn-icons-png.flaticon.com/512/880/880452.png" alt="dislike button" /></a>
							</c:if>
							
							<!-- Likes counter -->
							<p class="card-text"><c:out value="${allLikes.size() }"/></p>
						</div>
     
       						
       						<!-- Comments from other users -->
       						<h4 class="comment-title me-2 mb-4">Comments</h4><img class="arrow-down" src="https://cdn-icons-png.flaticon.com/512/32/32195.png" alt="" />
       						
       						<!-- ========= below is where the comments should go =========  -->
       						
       						
       						<c:forEach var = "eachComment" items = "${allCommentsByPhotoId}">
      							<div class="card-text d-flex gap-2 mb-2">
      							
      							<img class="user-comment-card" src="https://cdn-icons-png.flaticon.com/512/1053/1053244.png" alt="" />
      							
      							<div>
      							
      							<div class="mb-1">
      							<c:choose >
      								<c:when test = "${ eachComment.getId() != commentId }">
      									<span class="username"><c:out value="${eachComment.user.getFirstName()}"></c:out>: </span>
       									<c:out  value = "${ eachComment.getComment() }"></c:out>
       									
       								</c:when>
       								<c:otherwise>
										<p class="username"> Edit your comment: </p>
       								</c:otherwise>		
       							</c:choose>
       							</div>
       							
       							<!-- Heart Icon and like comment counter and Edit Delete button -->
       							<div class="d-flex align-items-center gap-2">
       							
       							<!-- Likes comment button -->
       							
       							<!-- Like a comment -->
									<c:if test="${!eachComment.usersWhoLikeComment.contains(currentUser)}">
										<form:form action = "/like/comment/${eachComment.getId()}">
											<p class="submit">
												<input class="heart-icon" type="image" src="https://cdn-icons-png.flaticon.com/512/2589/2589197.png"/>
											</p>
										</form:form>
									</c:if>	
								<!-- Dislike/Unlike a comment -->											
									<c:if test="${eachComment.usersWhoLikeComment.contains(currentUser)}">
										<form:form action = "/dislike/comment/${eachComment.getId()}">
											<p class="submit">
												<input class="heart-icon" type="image" src="https://cdn-icons-png.flaticon.com/512/2589/2589175.png"/>
											</p>
										</form:form>
									</c:if>
       							
       							<!-- Like counter -->
       							<p class="me-1"><c:out value = "${ eachComment.usersWhoLikeComment.size() }"></c:out></p>
       							
       							
       							
       							
       							<!--  -->
								<!-- (A AND !B) OR (!A AND B) -->
								<!-- car.isDiesel() ^ car.isManual() -->	
							<c:if test = "${ eachComment.getId() != commentId }">
								  
	       							<c:if test = "${ eachComment.user.getId() == currentUser.id }">
		       								<form:form action = "/delete/${eachComment.getId()}" method="delete">
											    <p class="submit">
											    	<input class="btn btn-danger del-cmt-btn" type="submit" value="Delete"/>
											    </p>
											</form:form>
											
											<form:form action = "/edit/comment/page/${eachComment.getId()}">
											    <p class="submit">
											    	<input class="btn btn-secondary edit-cmt-btn" type="submit" value="Edit"/>
											    </p>

											</form:form>
																						
	       							</c:if>
	       						</c:if>
	       						
	       							
	       							
								
								

								<!-- IGNORE: EDIT COMMENT IN PROGRESS -->
								<div class="d-flex justify-content-between align-items-center ms-2">
								<c:if test = "${ eachComment.getId() == commentId  }" >
									
											<form:form action = "/edit/comment/${eachComment.getId()}" method="post" modelAttribute="commentToEdit">
											<input type="hidden" name="_method" value="put"/>
											
											<p>
												<textarea class="form-control" name="comment" rows="3" cols="40" >${eachComment.comment }</textarea>
												<form:errors path = "comment"/>
											</p>
											<p>
												<form:input type="hidden" path="user" value="${ eachComment.user.id }"/>
												<form:input type="hidden" path="photo" value="${ eachComment.photo.id }"/>	
																						
											</p>												
												
												<div class="d-flex align-items-start gap-2">
											    	<p class="submit">
											    		<input class="btn btn-secondary edit-cmt-btn" type="submit" value="Submit Edit"/>
											    	</p>
													<!-- need cancel edit button/route - clear session! -->
 													<a href="/cancel/edit/comment/${eachComment.getId()}" class="btn btn-secondary edit-cmt-btn"> Cancel Edit</a>
												</div>
												
											</form:form>
											
										
								</c:if>
								</div>
								
								
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





</body>
</html>