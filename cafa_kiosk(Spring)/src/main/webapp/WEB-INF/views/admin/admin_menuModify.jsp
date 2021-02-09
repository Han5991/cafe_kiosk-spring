<%@page import="com.model.dao.MenuDao"%>
<%@page import="com.model.dto.MenuDto"%>
<%@page import="java.util.ArrayList"%>
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
.row.content {
	height: 1119px;
	text-align: center;
	vertical-align: middle;
}

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
		<%
			ArrayList<MenuDto> menuDtos = MenuDao.getInstance().allmenu();
		for (MenuDto menu : menuDtos) {
		%>
		<form action="admin_menuModify.do">
			<div class="menu">
				<p>
					<img src="../showImage?key1=<%=menu.getName()%>" />
				</p>
				<p><%=menu.getName()%></p>
				<p>
					<input type="submit" value="수정하기">
				</p>
				<input type="hidden" name="name" value="<%=menu.getName()%>">
			</div>
		</form>
		<%
			}
		%>
	</div>
</body>
</html>