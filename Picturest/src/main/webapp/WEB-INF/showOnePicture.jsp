<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<img class="img-prev" src="${ photo.getPhotoURL() }" alt="">
<a href="/like/${photo.getId() }">Like</a>

<form action="/comment/${photo.getId() }" method="post">
	<label for="comment">Comment</label>
	<textarea name="comment" rows="5" cols="33"> </textarea>
	<input type="hidden" name="user" value="${currentUser}">
	<input type="hidden" name="photo" value="${photo}">
	<input type="submit" />
</form>

<c:if test="${photo.user.id == currentUser.id }">
<a href="/edit/${photo.getId()}" class="btn btn-info">edit</a>
</c:if>


</body>
</html>