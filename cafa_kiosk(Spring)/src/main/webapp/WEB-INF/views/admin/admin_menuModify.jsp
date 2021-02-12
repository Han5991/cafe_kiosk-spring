<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.menu {
	width: 200px;
	border: 1px solid lightgray;
	border-radius: 10px;
	margin: 30px;
	font-size: 24px;
	display: inline-block;
	float: left;
}

img {
	width: 150px;
	height: 150px;
	margin-top: 5px;
	border-radius: 10px;
}
</style>
</head>
<body style="text-align: center;">

	<!-- Navigation -->
	<%@ include file="../navbar_admin.jsp"%>
	<h1 style="text-align: center;">메뉴 수정 페이지</h1>
	<hr>
	<div style="margin: 0 auto;">
		<c:forEach var="MenuDto" items="${menuDtos}">
			<form action="admin_menuModify.do">
				<div class="menu">
					<p>
						<img src="showImage?key1=<c:out value="${MenuDto.name}"/>" />
					</p>
					<p><c:out value="${MenuDto.name}"/></p>
					<p>
						<input type="submit" value="수정하기">
					</p>
					<input type="hidden" name="name" value="<c:out value="${MenuDto.name}"/>">
				</div>
			</form>
		</c:forEach>
	</div>
</body>
</html>