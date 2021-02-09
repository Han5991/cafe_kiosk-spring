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
* {
	font-size: 25px;
}

.side {
	height: 96.3%;
	position: fixed;
	left: 85%;
	width: 15%;
	text-align: center;
	background: lightgray;
	vertical-align: middle;
}

.menu {
	width: 250px;
	border: 1px solid lightgray;
	border-radius: 10px;
	margin: 50px;
	font-size: 24px;
	float: left;
	text-align: center;
}

.menu:active {
	background-color: lightgray;
}

#pop {
	top: 20%;
	left: 35%;
	position: absolute;
	width: 350px;
	z-index: 5;
	box-shadow: 0 0 10px rgb(0 0 0/ 50%);
	background: #fff;
	border-radius: 10px;
	text-align: center;
	padding: 20px;
	box-sizing: border-box;
	transition: all 0.5s;
}

input {
	width: 200px;
	border: 0;
	font-weight: bold;
	text-align: center;
}

#oder>input {
	width: 150px;
	text-align: left;
	background-color: lightgray;
	font-size: 20px;
}
</style>
</head>
<body>
	<%@ include file="../navbar_user.jsp"%>
	<div class="side">
		<input type="button" value="커피" class="show1"> <input
			type="button" value="티" class="show4"> <input type="button"
			value="음료" class="show3"><br> <input type="button"
			value="블렌디드" class="show2"> <input type="button" value="디저트"
			class="show5"> <br> 총 합계 금액 : <br>
		<form action="Cart.do">
			<input type="text" name="sum" value="0"
				style="width: 100px; background-color: lightgray;"
				readonly="readonly">원<br>
			<div id="oder" style="text-align: left; padding: 10px;"></div>

			<br> <input type="button" value="메뉴 초기화"
				style="font-size: 30px;" onclick="re();"><br> <input
				type="submit" value="주문 하기" style="font-size: 30px;">
		</form>
	</div>
	<div style="width: 85%;">
		<div id="pop">
			<h2>옵션 선택</h2>
			<input type="button" value="X" id="exit"
				style="left: 85%; top: 5%; position: absolute; width: 40px;">
			<table>
				<tr>
					<th>메뉴이름</th>
				</tr>
				<tr>
					<th><img src="" height="200px" width="200px" id="img"><br>
						<input type="text" readonly="readonly" id="name"><br>
						<input type="text" readonly="readonly" id="price"></th>
				</tr>
				<tr>
					<th>수량</th>
				</tr>
				<tr>
					<td><input type="button" value="-" name="maineoseu"
						style="width: 40px;"> <input type="text" value="1"
						name="quantity" style="text-align: center;" readonly="readonly">
						<input type="button" value="+" name="plus" style="width: 40px;"></td>
				</tr>
				<tr>
					<td><input type="button" value="추가하기" onclick="add();"></td>
				</tr>
			</table>
		</div>

		<div class="coffee">
			<%
				ArrayList<MenuDto> menuDtos1 = MenuDao.getInstance().allmenuType("espresso");
			for (MenuDto menuDto : menuDtos1) {
			%>
			<div class="menu">
				<p>
					<img src="../showImage?key1=<%=menuDto.getName()%>" height="200px"
						width="200px" name="img">
				</p>
				<p>
					<input value="<%=menuDto.getName()%>" name="name1"
						readonly="readonly">
				</p>
				<p>
					<input value="<%=menuDto.getPrice()%>" name="price1"
						readonly="readonly">
				</p>
			</div>
			<%
				}
			%>
		</div>

		<div class="blended">
			<%
				ArrayList<MenuDto> menuDtos2 = MenuDao.getInstance().allmenuType("blended");
			for (MenuDto menuDto : menuDtos2) {
			%>
			<div class="menu">
				<p>
					<img src="../showImage?key1=<%=menuDto.getName()%>" height="200px"
						width="200px" name="img">
				</p>
				<p>
					<input value="<%=menuDto.getName()%>" name="name1"
						readonly="readonly">
				</p>
				<p>
					<input value="<%=menuDto.getPrice()%>" name="price1"
						readonly="readonly">
				</p>
			</div>
			<%
				}
			%>
		</div>

		<div class="etc">
			<%
				ArrayList<MenuDto> menuDtos3 = MenuDao.getInstance().allmenuType("etc");
			for (MenuDto menuDto : menuDtos3) {
			%>
			<div class="menu">
				<p>
					<img src="../showImage?key1=<%=menuDto.getName()%>" height="200px"
						width="200px" name="img">
				</p>
				<p>
					<input value="<%=menuDto.getName()%>" name="name1"
						readonly="readonly">
				</p>
				<p>
					<input value="<%=menuDto.getPrice()%>" name="price1"
						readonly="readonly">
				</p>
			</div>
			<%
				}
			%>
		</div>

		<div class="tea">
			<%
				ArrayList<MenuDto> menuDtos4 = MenuDao.getInstance().allmenuType("tea");
			for (MenuDto menuDto : menuDtos4) {
			%>
			<div class="menu">
				<p>
					<img src="../showImage?key1=<%=menuDto.getName()%>" height="200px"
						width="200px" name="img">
				</p>
				<p>
					<input value="<%=menuDto.getName()%>" name="name1"
						readonly="readonly">
				</p>
				<p>
					<input value="<%=menuDto.getPrice()%>" name="price1"
						readonly="readonly">
				</p>
			</div>
			<%
				}
			%>
		</div>

		<div class="dessert">
			<%
				ArrayList<MenuDto> menuDtos5 = MenuDao.getInstance().allmenuType("dessert");
			for (MenuDto menuDto : menuDtos5) {
				if (menuDto.getStock() > 0) {
			%>
			<div class="menu">
				<p>
					<img src="../showImage?key1=<%=menuDto.getName()%>" height="200px"
						width="200px" name="img">
				</p>
				<p>
					<input value="<%=menuDto.getName()%>" name="name1"
						readonly="readonly">
				</p>
				<p>
					<input value="<%=menuDto.getPrice()%>" name="price1"
						readonly="readonly">
				</p>
			</div>
			<%
				}
			}
			%>
		</div>
	</div>
</body>
<script type="text/javascript">
	$('.coffee').show();
	$('.blended').hide();
	$('.etc').hide();
	$('.tea').hide();
	$('.dessert').hide();
	$('#pop').hide();

	$('.show1').click(function() {
		$('.coffee').show();
		$('.blended').hide();
		$('.etc').hide();
		$('.tea').hide();
		$('.dessert').hide();
		return false;
	});
	$('.show2').click(function() {
		$('.coffee').hide();
		$('.blended').show();
		$('.etc').hide();
		$('.tea').hide();
		$('.dessert').hide();
		return false;
	});
	$('.show3').click(function() {
		$('.coffee').hide();
		$('.blended').hide();
		$('.etc').show();
		$('.tea').hide();
		$('.dessert').hide();
		return false;
	});
	$('.show4').click(function() {
		$('.coffee').hide();
		$('.blended').hide();
		$('.etc').hide();
		$('.tea').show();
		$('.dessert').hide();
		return false;
	});
	$('.show5').click(function() {
		$('.coffee').hide();
		$('.blended').hide();
		$('.etc').hide();
		$('.tea').hide();
		$('.dessert').show();
		return false;
	});

	$('#exit').click(function() {
		$('#pop').hide();
	});

	$('input[name=plus]').click(function() {
		var num = $("input[name=quantity]").val();
		$("input[name=quantity]").val(++num);
	});

	$('input[name=maineoseu]').click(function() {
		var n = $('input[name=maineoseu]').index(this);
		var num = $("input[name=quantity]").val();
		if (num > 0) {
			$("input[name=quantity]").val(--num);
		}
	});

	$('.menu').click(function() {
		var n = $('.menu').index(this);
		var name = $("input[name=name1]:eq(" + n + ")").val();
		var price = $("input[name=price1]:eq(" + n + ")").val();
		var src = $("img[name=img]:eq(" + n + ")").attr('src');

		$('#name').val(name);
		$('#price').val(price);
		$('#img').attr('src', src);
		$('#pop').show();
	});
	function add() {
		var img = $('#img').attr('src');
		var add = "<img src='"+img+"' height='110px' width='110px'>"
		var quantity = $('input[name=quantity]').val();
		var price = $('#price').val();
		var name = "<input value='" + $('#name').val()
				+ "'name='name'readonly='readonly'>";
		var sum = $('input[name=sum]').val();

		$('input[name=sum]').val(sum * 1 + (quantity * 1 * price));
		$('#oder')
				.append(
						add
								+ name
								+ ' '
								+ "<input value='"+quantity+"'name='quantity1'readonly='readonly'style='width: 20px'>"
								+ '<br>'
								+ "<input type='hidden'value='"+price+"'name='price'>");
		$('#pop').hide();
		$('input[name=quantity]').val(1);
	};
	function re() {
		$('#oder').html('');
		$('input[name=sum]').val(0);
	};
</script>
</html>