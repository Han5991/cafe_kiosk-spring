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
.row.content {
	height: 1119px;
	text-align: center;
	vertical-align: middle;
}

footer {
	background-color: #555;
	color: white;
	padding: 15px;
}

#form {
	width: 450px;
	height: 400px;
	border: 3px solid lightgray;
	border-radius: 20px;
	margin: 80px auto;
	font-size: 24px;
}

#id {
	margin: 30px 80px;
}

#pw {
	margin: 0px 80px;
}

#btn {
	margin-top: 50px;
	padding: 20px 20px;
	border-radius: 10px;
	background-color: #bcaaa4;
}
</style>
</head>
<body>

	<!-- Navigation -->
	<%@ include file="navbar_admin.jsp"%>

	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-12 text-center">
				<h1>로그인</h1>
				<hr>

				<h3>Login coffee shop</h3>
				<form action="/loginProcess.do" method="post" id="form">
					<div id="id">
						ID:<input type="text" placeholder="id" name="id">
					</div>
					<div id="pw">
						PW:<input type="password" placeholder="password" name="pw">
					</div>
					<input type="submit" value="로그인" id="btn" size="50">
				</form>
			</div>
		</div>
	</div>

	<footer class="container-fluid text-center">
		<p>Footer Text</p>
	</footer>

</body>
</html>