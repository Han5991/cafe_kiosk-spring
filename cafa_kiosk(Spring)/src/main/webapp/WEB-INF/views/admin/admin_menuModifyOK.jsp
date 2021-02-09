<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.model.dao.MenuDao"%>
<%@page import="com.model.dto.MenuDto"%>
<%
	MenuDto menuDto = MenuDao.getInstance().oneMenu(request.getParameter("name"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#form {
	width: 500px;
	height: 800px;
	border: 3px solid lightgray;
	border-radius: 20px;
	margin: 40px auto;
}

.input-file-button {
	width: 250px;
	height: 300px;
	border-radius: 4px;
	border: 1px solid lightgray;
	background-color: lightgray;
	cursor: pointer;
}

img {
	border-radius: 20px;
}
</style>
<title>Insert title here</title>
</head>
<body style="text-align: center;">
	<!-- Navigation -->
	<%@ include file="../navbar_admin.jsp"%>
	<h1 style="text-align: center;">메뉴 수정 페이지</h1>
	<hr>
	<form action="admin_menuModifyOK.do" id="form" method="post"
		enctype="multipart/form-data">
		<div style="margin: 0 auto;">
			<p>
				<img src="../showImage?key1=<%=menuDto.getName()%>" id="loadImg"
					width="300px" height="300px" style="margin-top: 20px;">
			</p>
			<p>
				<input type="file" id="imgAttach" name="image" onchange="LoadImg()"
					style="margin-left: 40px;" required="required" />
			</p>

			<p>
				카테고리 : <select name="category" required="required">
					<option value="type">select type</option>
					<option value="blended_">blended</option>
					<option value="dessert_">dessert</option>
					<option value="espresso_">espresso</option>
					<option value="etc_">etc</option>
					<option value="tea_">tea</option>
				</select>
			</p>

			<p>
				메뉴 : <input type="text" name="name" placeholder="name"
					autocomplete="off" required="required"
					value="<%=menuDto.getName()%>">
			</p>
			<p>
				가격 : <input type="text" name="price" placeholder="price"
					autocomplete="off" required="required"
					value="<%=menuDto.getPrice()%>">
			</p>
			<p>
				<input type="hidden" value="<%=menuDto.getFilename()%>"
					name="filename"> <input type="submit" value="수정"
					onclick="infoConfirm()">
			</p>
		</div>
	</form>
</body>
<script type="text/javascript">
	/* 파일 삽입 시 이미지 미리보기 */
	function LoadImg() {
		var load = document.querySelector('img');
		var file = document.querySelector('input[type=file]').files[0];
		var reader = new FileReader();

		reader.addEventListener("load", function() {
			load.src = reader.result;
		}, false);

		if (file) {
			reader.readAsDataURL(file);
		}
	}
	function infoConfirm() {
		if (document.reg_frm.type.value == "type") {
			alert("타입은 필수 사항입니다.");
			reg_frm.type.focus();
			return;
		}
	}
</script>
</html>