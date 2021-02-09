<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.menu {
	width: 600px;
	border-radius: 10px;
	font-size: 24px;
	text-align: center;
	border: 1px solid lightgray;
	display: inline-block;
}

img {
	width: 300px;
	height: 300px;
	margin: 90px;
}

.font {
	font-size: 180%;
	margin: 20px;
	text-align: center;
}
</style>
</head>
<body>
	<!-- Navigation -->
	<%@ include file="../navbar_user.jsp"%>

	<div style="margin: 12% 2.5% 5% 23%" class="menu" onclick="javascript:window.location='menulist.do'">
		<img src="<spring:url value='/resources/img2/coffee.png'/>" />
		<p class="font">매장에서 식사</p>
	</div>

	<div style="margin: 5% 5% 2.5% 5%" class="menu" onclick="javascript:window.location='menulist.do'">
		<img src="<spring:url value='/resources/img2/take-away.png'/>" />
		<p class="font">포장</p>
	</div>

</body>
</html>