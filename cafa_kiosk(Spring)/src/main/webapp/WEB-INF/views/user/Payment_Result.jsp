<%@page import="com.model.dao.OderDao"%>
<%@page import="com.model.dto.oderDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	ArrayList<oderDto> oderDtos = new ArrayList<oderDto>();
oderDtos = (ArrayList<oderDto>) session.getAttribute("oderlist");
String sum = (String) session.getAttribute("sum");

int odernum = OderDao.getInstance().insertOder(oderDtos, sum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
.jumbotron {
	margin-bottom: 0px;
	background-color: white;
	padding: 0;
}

.table {
	text-align: left;
	font-size: 20px;
}

img {
	object-fit: cover
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
</style>
<title>결제 정보</title>
</head>
<body>
	<%@ include file="../navbar_user.jsp"%>
	<div id="pop">
		<input type="hidden" name="odernum" value="<%=odernum%>"> <input
			id="btn-submit" type="submit" value="카드를 뽑아주세요"
			onclick="javascript:document.location.href='menulist.do'">
	</div>

	<div class="jumbotron" style="padding: 40px 0 0 0;">
		<div class="container text-center">
			<table class="table">
				<thead style="font-size: 60px; text-align: center">
					<tr>
						<td><sup><%=odernum%>번 결제가 성공적으로 완료되었습니다.</sup></td>
					</tr>
				</thead>
				<tr>
					<td style="font-size: 30px;">결제/주문 내역</td>
				</tr>
			</table>
		</div>
	</div>

	<div style="padding: 0; margin: 0 auto; width: 50%;">
		<div class="jumbotron" style="float: left; width: 50%">
			<div class="container text-center">
				<table class="table">
					<thead style="font-size: 30px;">
						<tr>
							<td><sup><span class="glyphicon glyphicon-stop"></span>결제
									금액</sup></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>일반제품</td>
							<td><%=sum%>원</td>
						</tr>
						<tr>
							<td>총 합계 금액</td>
							<td><%=sum%>원</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="jumbotron" style="float: left; width: 50%">
			<div class="container text-center">
				<table class="table">
					<thead style="font-size: 30px;">
						<tr>
							<td><sup><span class="glyphicon glyphicon-stop"></span>결제
									수단</sup></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>신용카드</td>
						</tr>
						<tr>
							<td>참고사항 - 주문 결제 이후 3분 이내 취소 가능하며, 제품 조리시는 취소 및 환불이 불가능합니다.
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="jumbotron" style="float: left; width: 100%">
			<div class="container text-center">
				<table class="table">
					<tr>
						<td>
							<div>
								<table class="table">
									<%
										for (oderDto dto : oderDtos) {
										int price = Integer.parseInt(dto.getPrice());
										int Quantity = Integer.parseInt(dto.getQuantity());
									%>
									<tr>
										<td><img src="../showImage?key1=<%=dto.getMenu()%>"
											width="150" height="150" /></td>
										<td><%=dto.getMenu()%></td>
										<td><%=Quantity%></td>
										<td><%=price * Quantity%></td>
									</tr>
									<%
										}
									%>
								</table>
							</div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td>총 주문 금액</td>
						<td><%=sum%>원</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<div class="jumbotron">
		<div class="container text-center">
			<div style="width: 100%; float: left; margin: 0 0 40px 0">
				<input type="button" value="홈으로" class="btn btn-warning"
					onclick="javascript:document.location.href='menulist.do'">
			</div>
		</div>
	</div>
	<%
		session.removeAttribute("oderlist");
	session.removeAttribute("sum");
	%>
</body>
<script type="text/javascript">
	if (
<%=odernum%>
	== 0) {
		alert("결제에 실패하였습니다.");
		history.back();
	}
	var webSocket = new WebSocket('ws://localhost:8080/webChatServer');
	webSocket.onerror = function(e) {
		onError(e);
	};
	webSocket.onopen = function(e) {
		onOpen(e);
	};
	webSocket.onmessage = function(e) {
		onMessage(e);
	};

	function onMessage(e) {
	}

	function onOpen(e) {
	}

	function onError(e) {
		alert(e.data);
	}
	function send() {
		var chatMsg = $('input[name=odernum]').val();
		webSocket.send(chatMsg);
	}
	$('#btn-submit').click(function() {
		send();
		$('#pop').hide();
	});
</script>
</html>