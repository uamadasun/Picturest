<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Picturest - My Profile</title>
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
    
    
    

	<div class="container">
	
		<!-- User's card info -->
		<div class="row">
			<div class="col text-center mt-3 user-card">
				<img class="user-profile-icon mb-3" src="https://cdn-icons-png.flaticon.com/512/8731/8731440.png" alt="user profile image" />
            	<h1 class="mb-3"><c:out value="${currentUser.firstName } ${currentUser.lastName }" /></h1>
            	<a class="btn btn-secondary add-img-btn text-light mb-5" href="/upload/menu">Add Image</a>
            	<h5>Created</h5>
            </div>
        </div>  
            <!-- User's Photo Gallery -->        
		<div class="row text-center">
				<c:forEach var = "eachPhoto" items = "${allPhotos}">
					<c:if test="${eachPhoto.user.id .equals(currentUser.id) }">
						<div class="col">
                        
                        <!-- SHOW IMAGES -->
                        
                        <c:if test="${eachPhoto.getPhotoURL() == null}">
                                <a href="/show/${eachPhoto.id }"><img class="img-prev" src="${eachPhoto.getPhotoImagePath() }" alt="" /></a> 
                            </c:if>
                            
                        <c:if test="${eachPhoto.getPhotoURL() != null}">
                            <a href="/show/${ eachPhoto.id }"><img class="img-prev" src="${ eachPhoto.getPhotoURL() }" alt=""></a>
                            </c:if>

                            
                        </div>
					</c:if>
				</c:forEach>
			 	
		</div>
	</div>

    
    
    
    

</body>
</html>