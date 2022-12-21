<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="header :: html_head">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Picturest Log In</title>
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
                        <a class="nav-link btn btn-warning text-light signup-btn px-3" href="/registration">Sign Up</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


	<div class="container">
		<div class="row mainbox mx-auto">
		
			<!-- Left Column -->
			<div class="col-lg-5 mb-5">
				<c:if test="${logoutMessage != null}">
        			<p class="text-danger"><c:out value="${logoutMessage}"></c:out></p>
    			</c:if>
    			<h1 class="login-title">Login</h1>
    			<c:if test="${errorMessage != null}">
        			<p class="text-danger"><c:out value="${errorMessage}"></c:out></p>
    			</c:if>
    			<form method="POST" action="/login">
    				<div class="mb-3">
    				<label class="form-label" for="email">Email</label>
            		<input class="form-control" type="text" id="email" name="email"/>
            		</div>
            		
            		<div class="mb-3">
            		<label class="form-label" for="password">Password</label>
            		<input class="form-control" type="password" id="password" name="password"/>
    				</div>
    				
    				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        			<input class="btn btn-primary btn-lg loginbtn" type="submit" value="Login"/>
    			
    			</form>
			</div>

			<!-- (Right Column) -->
			<div class="col-lg-7 text-center mb-5">
				<h1 class="title-text">A community where</h1>
                <h1 class="title-text teal">you can share your world!</h1> <br>
                <a class="btn btn-warning btn-lg signup-btn text-light" href="/registration">Sign Up</a>
			</div>
			
			
			
			
		</div>
	</div>











    
    
    
    
</body>
</html>