<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Picturest - Sign Up</title>
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
            <a class="navbar-brand" href="/login"><img class="navbar-logo" src="https://cdn-icons-png.flaticon.com/512/7917/7917097.png"
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
                    
                    <li class="nav-item">
                        <a class="nav-link btn btn-primary text-light loginbtn px-3" href="/login">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
	

	


	<div class="container">
		<div class="row">
		
			<div class="col-lg-5 mx-auto signup-box shadow">
				<h1 class="">Sign up</h1>
				
				<p><form:errors path="user.*"/></p>
				<form:form method="POST" action="/registration" modelAttribute="user">
				<div class="mb-3">
					<form:label class="form-label" path="firstName">First Name:</form:label>
            		<form:input class="form-control" path="firstName"/>
				</div>
				<div class="mb-3">
					<form:label class="form-label" path="lastName">Last Name:</form:label>
            		<form:input class="form-control" path="lastName"/>
				</div>
				<div class="mb-3">
					<form:label class="form-label" path="email">Email:</form:label>
            		<form:input class="form-control" path="email"/>
				</div>
				<div class="mb-3">
					<form:label class="form-label" path="password">Password:</form:label>
            		<form:password class="form-control" path="password"/>
				</div>
				<div class="mb-3">
					<form:label class="form-label" path="passwordConfirmation">Password Confirmation:</form:label>
            		<form:password class="form-control" path="passwordConfirmation"/>
				</div>
				<input class="btn btn-secondary text-light signup-btn" type="submit" value="Register"/>
				</form:form>
			</div>
		
		</div>
		
	</div>










   
    
    
    
</body>
</html>
