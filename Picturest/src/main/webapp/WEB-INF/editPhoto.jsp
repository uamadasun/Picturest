<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Photo</title>
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


<!-- ============== MAIN BOX ================ -->

<div class="container">
		
		<!-- New TESTING NEW EDIT FORM -->
	<div class="row">
		<div class="card mb-3 showOne-box shadow mx-auto p-3">
  			<div class="row g-3">
  			
  			<!-- Left Side of Card -->
    			<div class="col-md-5">
     				<img src="${ photo.getPhotoURL() }" class="img-fluid img-showOne" alt="current user uploaded image">
    			</div>
    		<!-- Right Side of Card -->
    			<div class="col-md-7 p-4">
      				<div class="card-body">
      					<form:form action="/edit/photo/success/${photo.id}" method="post" modelAttribute="photo">
 						<input type="hidden" name="_method" value="put"/>
 							<!-- Image title -->
 							<div class="mb-3">
								<form:label path = "photoTitle" for="" class="form-label edit-img-title">Edit image title</form:label>
								<form:input path = "photoTitle" type="text" class="form-control" />
								<form:errors path = "photoTitle"/>
							</div>
							<!-- Image Owner -->
							<div class="mb-3 d-flex gap-2 align-items-center">
								<img class="user-img-card" src="https://cdn-icons-png.flaticon.com/512/8731/8731440.png" alt="default user image" />
								<p class="user-img-name"><c:out value="${currentUser.firstName} ${currentUser.lastName }"></c:out></p>
							</div>
							<!-- Image Description -->
 							<div class="mb-3">
  								<form:label path = "photoDescription" for="exampleFormControlTextarea1" class="form-label edit-img-description">Tell everyone what your image is about</form:label>
	   							<form:textarea path = "photoDescription" class="form-control" id="exampleFormControlTextarea1" rows="3"></form:textarea>
   								<form:errors path = "photoDescription"/>
							</div>
							<!-- Image URL -->
							<div>
 								<form:input type="hidden" path = "photoURL" />
							</div>
							<!-- removed "value = "${currentUser.id}" -->
							<!-- need form:hidden for usersWhoLikePhoto, userCommentsOnPhoto -->
							<p>
 							<form:input type="hidden"  path = "user"/>
 							<form:input type="hidden"  path = "usersWhoLikePhoto"/>
 							<form:input type="hidden"  path = "comments"/>
							</p>
							
							<!-- Buttons for the form  -->
							<div class="d-flex justify-content-between">
							<button class="btn btn-secondary edit-confirm-btn px-3">Save</button>
							<a class="btn btn-warning cancel-btn text-light px-3" href="/">Cancel</a>
							</div>
        					
      					</form:form>
      				</div>
    			</div>
    			
  			</div>
		</div>
	</div>
		
		
		
</div>











</body>
</html>