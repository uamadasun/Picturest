<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome Page 2</title>

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
    
    
   <!-- ============== MAIN BOX ==============  -->
	<div class="container">
        <div class="row">
            <div class="mainbox-dash col text-center align-self-center">

                <div class="container text-center">
                    <div class="row">
                    
                    	<c:forEach var = "eachPhoto" items = "${allPhotos}">
                        <div class="col">
                        
                        <!-- 12/18 UCHENNA ADDED A TAGS TO ROUTE TO SHOW ONE IMAGE ROUTE -->
                        <a href="/show/${ eachPhoto.id }"><img class="img-prev" src="${ eachPhoto.getPhotoURL() }" alt=""></a>
                            
                        </div>
                        </c:forEach>
                    	
                        <div class="col">
                            <img class="img-prev" src="https://assets.photographycourse.net/wp-content/uploads/2022/04/12225324/Portrait-vs-Landscape-Featured-Image-3.jpg" alt="">
                        </div>
                        <div class="col">
                            <img class="img-prev" src="https://d39l2hkdp2esp1.cloudfront.net/img/photo/170224/170224_00_2x.jpg" alt="">
                        </div>
                        <div class="col">
                            <img class="img-prev" src="https://shotkit.com/wp-content/uploads/2020/07/landscapevportrait_image002.jpg" alt="">
                        </div>
                        <div class="col">
                            <img class="img-prev" src="https://www.shutterstock.com/shutterstock/photos/1320880223/display_1500/stock-photo-probiotics-food-background-kimchi-beet-sauerkraut-sauerkraut-cottage-cheese-olives-bread-1320880223.jpg" alt="">
                        </div>
                        <div class="col">
                            <img class="img-prev" src="https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2017/09/Mt-Assiniboine.jpg?fit=750%2C575&ssl=1" alt="">
                        </div>
                        <div class="col">
                            <img class="img-prev" src="https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX18463883.jpg" alt="">
                        </div>
                        <div class="col">
                            <img class="img-prev" src="https://www.bwillcreative.com/wp-content/uploads/2020/05/portrait-orientation-zion-national-park.jpg" alt="">
                        </div>
                        <div class="col">
                            <img class="img-prev" src="https://wallpapershome.com/images/pages/pic_h/12115.jpg" alt="">
                        </div>
                        
                        
                    </div>

                </div>

            </div>
        </div>
	</div>













    
    
</body>
</html>
