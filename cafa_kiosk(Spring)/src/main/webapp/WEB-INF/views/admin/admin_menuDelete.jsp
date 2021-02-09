<%@page import="com.model.dto.MenuDto"%>
<%@page import="com.model.dao.MenuDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
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

	<h1 style="text-align: center;">메뉴 삭제 페이지</h1>
	<hr>
	<div style="margin: 0 auto;">
		<%
			ArrayList<MenuDto> menuDtos = MenuDao.getInstance().allmenu();
		for (MenuDto menu : menuDtos) {
		%>
		<form action="admin_menuDelete.do">
			<div class="menu">
				<p>
					<img src="../showImage?key1=<%=menu.getName()%>" />
				</p>
				<p><%=menu.getName()%></p>
				<p><%=menu.getPrice()%></p>
				<p>
					<input type="submit" value='삭제하기' class="delete"> <input
						type="hidden" value='<%=menu.getFilename()%>' name="name">
				</p>
			</div>
		</form>
		<%
			}
		%>
	</div>
	<script>
		$("input[class=delete]").click(function() {
			if (confirm("정말 삭제하시겠습니까 ?") == true) {
				alert("삭제되었습니다");
			} else {
				return;
			}
		});
	</script>
</body>
</html>