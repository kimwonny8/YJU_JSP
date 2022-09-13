<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="https://cdn-icons-png.flaticon.com/512/473/473614.png">
<title>Click the book</title>
<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	height: 100vh;
	background: url(img/desk.jpg) no-repeat center;
	background-size: cover;
	display: flex;
	justify-content: center;
	align-items: center;
}

button {
	border: none;
	background: none;
}

button:hover {
	transform: scale(2, 2);
	transition: all 0.5s linear;
}
</style>
</head>
<body>
	<div class="container">
		<button onclick="location.href='introduce.jsp'">
			<img src="img/book.webp" height="300vh" />
		</button>
	</div>
</body>
</html>

