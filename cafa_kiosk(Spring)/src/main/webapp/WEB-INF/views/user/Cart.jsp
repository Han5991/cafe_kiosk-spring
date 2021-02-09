<%@page import="com.model.dto.oderDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String menu[] = request.getParameterValues("name");
String quantity[] = request.getParameterValues("quantity1");
String price[] = request.getParameterValues("price");
String sum = request.getParameter("sum");
ArrayList<oderDto> oderDtos = new ArrayList<oderDto>();
for (int i = 0; i < menu.length; i++)
	oderDtos.add(new oderDto(menu[i], quantity[i], price[i]));
session.setAttribute("oderlist", oderDtos);
session.setAttribute("sum", sum);
%>
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
	<span> 총 합계 금액 : <br><%=sum%>원 <br> <br> <input
		type="button" value="메뉴 다시선택" style="font-size: 30px;" onclick="back();"><br>
		<br> <input type="button" value="주문 하기" style="font-size: 30px;"
		onclick="go();"></span>
	<table>
		<tr>
			<td>메뉴</td>
			<td>상품명</td>
			<td>수량</td>
			<td>가격</td>
			<td>메뉴당 가격</td>
		</tr>
		<%
			for (oderDto oderdto : oderDtos) {
			int Quantity = Integer.parseInt(oderdto.getQuantity());
			int Price = Integer.parseInt(oderdto.getPrice());
		%>
		<tr>
			<td><img src="../showImage?key1=<%=oderdto.getMenu()%>"
				height="200px"></td>
			<td><%=oderdto.getMenu()%></td>
			<td><%=Quantity%></td>
			<td><%=Price%></td>
			<td><%=Quantity * Price%></td>
		</tr>
		<%
			}
		%>
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