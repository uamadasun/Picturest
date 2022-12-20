<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head th:replace="header :: html_head">
<meta charset="UTF-8">
<title>Upload Form</title>
<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="/css/bootstrap.css">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="/css/index.css">
	<!-- Bootstrap JS -->
	<script type="text/javascript" src="/js/bootstrap.js"></script>
	<!-- Custom JS -->
	<script type="text/javascript" src="/js/index.js"></script>
	<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
</head>
<body>




<section class="my-5">
    <div class="container">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <h2>Upload Image Example</h2>
                <p th:text="${message}" th:if="${message ne null}" class="alert alert-primary"></p>
                <form method="post" th:action="/upload" enctype="multipart/form-data">
                    <div class="form-group">
                        <input type="file" name="fileImage" accept="image/*" class="form-control-file">
                    </div>
                    
                    
                    <div class="form-group">
                    	<label for="imageTitle"> Image Title</label>
                        <input type="text" name="imageTitle" class="form-control-file">
                    </div>
                    
                    <div class="form-group">
                    <label for="imageDescription"> Image Description</label>
                        <input type="text" name="imageDescription" class="form-control-file">
                    </div>
                    
                    <div class="form-group">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </div>
                    
                    
                    
                    <button type="submit" class="btn btn-primary">Upload image</button>
                </form>
                <span th:if="${msg != null}" th:text="${msg}"></span>
            </div>
        </div>
    </div>
</section>








</body>
</html>