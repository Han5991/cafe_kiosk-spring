<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
form {
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
</head>
<body style="text-align: center;">

	<!-- Navigation -->
	<%@ include file="../navbar_admin.jsp"%>

	<h1 style="text-align: center;">메뉴 추가 페이지</h1>
	<hr>
	<form action="admin_menuInsert.do" name="reg_frm" method="post"
		enctype="multipart/form-data">
		<div style="margin: 0 auto;">
			<p>
				<img src="" id="loadImg" width="300px" height="300px"
					style="margin-top: 20px;"
					onerror="this.src='<spring:url value='/resources/img2/default_img.jpg'/>'">
			</p>
			<p>
				<input type="file" id="imgAttach" name="image" onchange="LoadImg()"
					style="margin-left: 40px;" required="required" />
			</p>

			<p>
				<select name="category" required="required">
					<option value="type">select type</option>
					<option value="blended_">blended</option>
					<option value="dessert_">dessert</option>
					<option value="espresso_">espresso</option>
					<option value="etc_">etc</option>
					<option value="tea_">tea</option>
				</select>
			</p>

			<p>
				<input type="text" name="name" placeholder="name" autocomplete="off"
					required="required">
			</p>
			<p>
				<input type="text" name="price" placeholder="price"
					autocomplete="off" required="required">
			</p>
			<p>
				<input type="submit" value="추가" onclick="infoConfirm()">
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
		if (document.reg_frm.category.value == "type") {
			alert("타입은 필수 사항입니다.");
			reg_frm.type.focus();
			return;
		}
		document.reg_frm.submit();
	}
</script>
</html>