<%@page import="com.model.dao.MenuDao"%>
<%@page import="com.model.dto.MenuDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ArrayList<MenuDto> menuDtos = new ArrayList<MenuDto>();
menuDtos = MenuDao.getInstance().allmenuType("dessert%");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
.btnTab {
	margin-bottom: 0;
	border-radius: 0;
	border: none;
	height: 70px;
	font-size: 20px;
	background-color: lightgray;
	font-color: gray;
	line-height: 70px;
}

a:hover:not (.active ) {
	color: white;
}

#inventory {
	text-align: center;
	margin: auto;
	border:
}

footer {
	width: 100%;
	bottom: 0;
	position: fixed;
	background: lightgray;
	text-align: center;
}

input {
	text-align: center;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<!-- Navigation -->
	<%@ include file="../navbar_admin.jsp"%>
	<h1 style="text-align: center;">재고 관리 페이지</h1>
	<hr>
	<form action="inventoryUpdate.do">
		<table id=inventory>
			<tr>
				<td>품목</td>
				<td>판매가격</td>
				<td>입고(개)</td>
				<td>현재고(개)</td>
				<td>입고후재고(개)</td>
			</tr>
			<%
				for (MenuDto menuDto : menuDtos) {
			%>
			<tr>
				<td><%=menuDto.getName()%><input type="hidden"
					value="<%=menuDto.getName()%>" name="menu"></td>
				<td><%=menuDto.getPrice()%>원</td>
				<td><input type="button" value="-" name="maineoseu"><input
					type="text" value="0" class="stock1"><input type="button"
					value="+" name="plus"></td>
				<td><input type="text" value="<%=menuDto.getStock()%>"
					readonly="readonly" class="stock2"></td>
				<td><input type="text" readonly="readonly" name="stock3"
					value="<%=menuDto.getStock()%>"></td>
			</tr>
			<%
				}
			%>
		</table>

		<footer class="container-fluid text-center">
			<input type="reset" value="입고 취소" class="btn btn-warning"
				style="font-size: 30px;"><input type="submit" value="입고"
				class="btn btn-warning" style="font-size: 30px;">
		</footer>
	</form>
</body>
<script type="text/javascript">
	$('input[name=plus]').click(function() {
		var n = $('input[name=plus]').index(this);
		var num = $(".stock1:eq(" + n + ")").val();
		$(".stock1:eq(" + n + ")").val(++num);
		var n2 = $(".stock2:eq(" + n + ")").val();
		$("input[name=stock3]:eq(" + n + ")").val(num * 1 + n2 * 1);
	});

	$('input[name=maineoseu]').click(function() {
		var n = $('input[name=maineoseu]').index(this);
		var num = $(".stock1:eq(" + n + ")").val();
		if (num > 0) {
			$(".stock1:eq(" + n + ")").val(--num);
		}
		$("input[name=stock3]:eq(" + n + ")").val(num);
		var n2 = $(".stock2:eq(" + n + ")").val();
		$("input[name=stock3]:eq(" + n + ")").val(num * 1 + n2 * 1);
	});
</script>
</html>