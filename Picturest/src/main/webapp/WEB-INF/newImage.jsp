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
<title>Add Image</title>
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

<!-- ============= NAVBAR SECTION ============= -->

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
		
		
		<div class="row">
			<div class="col-lg-7 d-flex justify-content-evenly form-box py-4 shadow">
			
				<div class="col-lg-4 col-4 upload-box d-flex justify-content-center align-items-center">
					<p>Choose file to upload</p>
				</div>
				
				<div class="col-lg-5 col-5">
					<form:form action="/images/new" method="POST" modelAttribute="photo">
						<p class="text-danger"><form:errors path = "photoTitle"/></p>
						<p class="text-danger"><form:errors path = "photoDescription"/></p>
						<p class="text-danger"><form:errors path = "photoURL"/></p>
						
						
						<!-- Image title -->
						<div class="mb-3">
							<form:label path = "photoTitle" for="" class="form-label"><h3>Image Title</h3></form:label>
							<form:input path = "photoTitle" type="text" class="form-control" />
							
						</div>
						<!--  -->
						<div class="mb-3">
							<p>Image by: <c:out value="${currentUser.firstName}"></c:out></p>
						</div>
						<!-- Image Description -->
						<div class="mb-3">
  							<form:label path = "photoDescription" for="exampleFormControlTextarea1" class="form-label">Tell everyone what your image is about</form:label>
	   						<form:textarea path = "photoDescription" class="form-control" id="exampleFormControlTextarea1" rows="3"></form:textarea>
   						
						</div>
						
						<!-- Image URL -->
						<div class="mb-3">
							<form:label path = "photoURL" for="" class="form-label">Image url:</form:label>
							<form:input path = "photoURL" type="text" class="form-control" />
							
						</div>
						
						<!-- Binding user to form NEED TO DOUBLE CHECK PATH -->
						<p>
						<form:hidden path = "user" value = "${currentUser.id}"/>
						</p>
						<!-- Buttons for the form  -->
						<div class="d-flex justify-content-between">
						<button type="submit" class="btn btn-success loginbtn">Upload</button>
						<a class="btn btn-danger" href="/">Cancel</a>
						</div>
					</form:form>
				</div>
				
			</div>
		</div>
		
	</div>
	
	
	
	



</body>
</html>