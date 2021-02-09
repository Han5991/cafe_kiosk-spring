<%@page import="com.model.dto.*"%>
<%@page import="com.model.dao.OderDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
ul {
	list-style: none;
}

#ul>li {
	width: 270px;
	height: 500px;
	margin: 5px;
	float: left;
	border: 3px solid lightgray;
	border-radius: 20px;
	text-align: left;
	padding: 5px;
}

#ul>li:active {
	background-color: lightgray;
}

footer {
	width: 100%;
	bottom: 0;
	position: fixed;
	background: lightgray;
	text-align: center;
}

.oderdetail {
	border-radius: 10px;
	border: 0px;
}
</style>
</head>
<body>
	<!-- Navigation -->
	<%@ include file="../navbar_admin.jsp"%>
	<%
		ArrayList<oderlistDto> alloder = new ArrayList<oderlistDto>();
	alloder = OderDao.getInstance().allOder("조리전");
	%>
	<h1 style="text-align: center; font-family: hzStyleFont; font-size: 25px; font-weight: bold;">주문 접수
		페이지</h1>
	<hr>
	<ul id="ul">
		<%
			for (oderlistDto oderlistDto : alloder) {
		%>
		<li class="oderNum">주문번호 : <%=oderlistDto.getOdernum()%><input
			name="oderNum" type="hidden" value="<%=oderlistDto.getOdernum()%>">
			<br> 주문시각 : <%=oderlistDto.getOderdate()%><br>주문상태 : <%=oderlistDto.getStatus()%><br>
			<input type="button" value="주문목록 보기" class="oderdetail">
			<table class="detail">
				<%
					for (oderDto dto : oderlistDto.getOderDtos()) {
				%>
				<tr>
					<td><%=dto.getMenu()%></td>
					<td><%=dto.getQuantity()%></td>
				</tr>
				<%
					}
				%>
			</table>
			<p>
				총계 :
				<%=oderlistDto.getSum()%>원</li>
		<%
			}
		%>
	</ul>
	<footer>
		<input type="button" value="주문 취소" class="btn btn-warning" id="delete"
			style="font-size: 30px;">&nbsp;&nbsp;<input type="button"
			value="조리 시작" class="btn btn-warning" style="font-size: 30px;"
			id="start">&nbsp;&nbsp;<input type="button" value="영수증 출력"
			class="btn btn-warning" style="font-size: 30px;" onclick="print()">
	</footer>
</body>
<script type="text/javascript">
	var num = 0;
	$("#delete").click(function() {
		if (confirm("정말 취소하시겠습니까 ?") == true) {
			location.href = "deleteOder.do?odernum=" + num;
			alert("취소되었습니다");
		} else {
			return;
		}
	});
	$("#start").click(function() {
		if (confirm("조리가 완료 되었습니까?") == true) {
			location.href = "startOder.do?odernum=" + num;
			alert("조리가 완료되었습니다");
		} else {
			return;
		}
	});
	$('.oderNum').click(function() {
		var n = $('.oderNum').index(this);
		num = $("input[name=oderNum]:eq(" + n + ")").val();
	});
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
		var chatMsg = event.data;

		var chatMsgs = chatMsg.split(",");

		var $chat = "<li class='oderNum'>주문번호 : "
				+ chatMsgs[chatMsgs.length - 4]
				+ "<input name='oderNum' type='hidden' value='"+chatMsgs[chatMsgs.length-4]+"'> <br> 주문시각 : "
				+ chatMsgs[chatMsgs.length - 3]
				+ "<br>주문상태 : "
				+ chatMsgs[chatMsgs.length - 1]
				+ "<br> <input type='button' value='주문목록 보기' class='oderdetail'><table class='detail'>";

		var $chat2 = ""
		for (var i = 0; i < chatMsgs.length - 4; i++) {
			$chat2 += "<tr><td>" + chatMsgs[i] + "</td><td>" + chatMsgs[++i]
					+ "</td></tr>";
		}

		var $chat3 = "</table><p>총계 : " + chatMsgs[chatMsgs.length - 2]
				+ "원</li>";

		$('#ul').append($chat + $chat2 + $chat3);

		$('.oderNum').click(function() {
			var n = $('.oderNum').index(this);
			num = $("input[name=oderNum]:eq(" + n + ")").val();
		});
	}

	function onOpen(e) {
	}

	function onError(e) {
		alert(e.data);
	}

	function send() {
	}
	function print() {
		var url = "receiptPrint.do?odernum=" + num;
		window
				.open(url, "receiptPrint",
						"toolbar=no, menubar=no,scrollbar=yes, resizable=no, width=450,height=800");
	}

	// 	$('.oderNum').click(function() {
	//		var n = $('.oderNum').index(this);
	//		num = $("input[name=oderNum]:eq(" + n + ")").val();
	//	});
	//	$('.oderdetail').click(function() {
	//		var n = $('.oderdetail').index(this);
	//		if ($(".detail:eq(" + n + ")").css("display") == "none") {
	//			$(".detail:eq(" + n + ")").show();
	//			$(".oderdetail:eq(" + n + ")").val("주문목록 숨기기");
	//		} else {
	//			$(".detail:eq(" + n + ")").hide();
	//			$(".oderdetail:eq(" + n + ")").val("주문목록 보기");
	//		}
	//	});
</script>
</html>