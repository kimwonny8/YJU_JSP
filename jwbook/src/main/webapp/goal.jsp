<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" type="image/x-icon"
	href="https://cdn-icons-png.flaticon.com/512/473/473614.png">
<title>IntroduceJW</title>
<style>
* {
	margin: 0;
	padding: 0;
}

body {
	height: 100vh;
	background: url(img/desk.jpg) no-repeat center;
	background-size: cover;
	display: flex;
	justify-content: center;
	align-items: center;
}

.container {
	animation: change 0.5s ease forwards;
	height: 90vh;
	width: 90vw;
	padding-top: 1vh;
	background: url(img/bookbg.png) no-repeat center;
	background-size: cover;
}

@keyframes change {from { transform:translateX(100%);
	visibility: visible;
}

to {
	transform: translateX(0%);
}

}
.menu {
	width: 85vw;
	display: flex;
	justify-content: space-between;
	margin-left: 1vw;
}

.menu>button {
	border: none;
	background: none;
}

.menu>button>img {
	width: 5vw;
	height: 10vh;
}

.menu>button>img:hover {
	color: red;
}

.contentLeft>p {
	font-size: 5vh;
	margin: 1vh;
	font-weight: bold;
}

.contentLeft {
	height: 80vh;
	width: 45vw;
	float: left;
	display: flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
}

.contentRight {
	height: 80vh;
	width: 45vw;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.contentRight>p {
	margin-top: 2vh;
	font-size: 22px;
}

.contentLeft>img {
	width: 35vw;
	border-radius: 20px;
	box-shadow: 3px 5px 5px grey;
}

.contentRight>button>img {
	width: 10vw;
}

.contentRight>button {
	border: none;
	background: none;
}

.menu>button>img:hover {
	transform: scale(1.2);
	transition: all 300ms ease-in;
}
</style>
</head>
<body>
	<div class="container">
		<div class="contentLeft">
			<p>목표</p>
			<img src="img/goal.png" />
		</div>
		<div class="contentRight">
			<h1>졸업 전</h1>
			<p>정보처리산업기사</p>
			<p>토익 800</p>
			<p>앱 개발</p>
			<p>포트폴리오 마무리</p>
			<p>취업...╰(*°▽°*)╯</p>
			<br />

			<h1>졸업 후</h1>
			<p>학사과정 후 대학원 진학</p>
			<p>정보처리기사</p>
		</div>

		<div class="menu">
			<button onclick="location.href='hobby.jsp'">
				<img src="img/left.png" />
			</button>
			<button onclick="location.href='main.jsp'">
				<img src="https://cdn-icons-png.flaticon.com/512/25/25694.png" />
			</button>
		</div>
	</div>
</body>
</html>
