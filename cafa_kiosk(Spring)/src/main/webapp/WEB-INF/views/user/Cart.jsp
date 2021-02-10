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
img {
	height: 150px;
	width: 150px;
	border-radius: 10px;
}

span {
	height: 96.3%;
	position: fixed;
	left: 85%;
	width: 15%;
	text-align: center;
	background: lightgray;
	vertical-align: middle;
}

table {
	margin: 50px auto;
	text-align: center;
}
</style>
</head>
<body>

	<!-- Navigation -->
	<%@ include file="../navbar_user.jsp"%>
	<span> 총 합계 금액 : <br> <c:out value="${sum}"/>원 <br>
		<br> <input type="button" value="메뉴 다시선택"
		style="font-size: 30px;" onclick="back();"><br> <br>
		<input type="button" value="주문 하기" style="font-size: 30px;"
		onclick="go();"></span>
	<table>
		<tr>
			<td>메뉴</td>
			<td>상품명</td>
			<td>수량</td>
			<td>가격</td>
			<td>메뉴당 가격</td>
		</tr>
		<c:forEach var="oderDto" items="${oderlist}">
			<tr>
				<td><img src="showImage?key1=<c:out value="${oderDto.menu}"/>"
					height="200px"></td>
				<td><c:out value="${oderDto.menu}" /></td>
				<td><c:out value="${oderDto.quantity}" /></td>
				<td><c:out value="${oderDto.price}" /></td>
				<td><c:out value="${oderDto.price*oderDto.quantity}" /></td>
			</tr>
		</c:forEach>
	</table>
</body>
<script type="text/javascript">
	function go() {
		location.href = "oder.do";
	}
	function back() {
		history.back();
	}
</script>
</html>