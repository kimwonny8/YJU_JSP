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

@keyframes change{
from {
 transform: translateX(100%);
 visibility: visible;
}

to {
	transform: translateX(0%);
}

}
.contentLeft>img {
	border-radius: 20px;
	box-shadow: 3px 5px 5px grey;
	width: 20vw;
}

.contentLeft>p {
	font-size: 5vh;
	font-weight: bold;
	margin: 1vh;
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

.contentRight>button>img {
	width: 10vw;
}

.contentRight>button>img:hover {
	border-radius: 50%;
	background-color: gray;
}

.contentRight>button {
	border: none;
	background: none;
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
	transform: scale(1.2);
	transition: all 300ms ease-in;
}
</style>
</head>
<body>
	<div class="container">
		<div class="contentLeft">
			<p>자기소개</p>
			<img src="img/jw.jpg" />
		</div>
		<div class="contentRight">
			<p>이름 : 김정원</p>
			<p>생년월일 : 1997. 1. 17</p>
			<p>MBTI : ESTP</p>
			<p>혈액형 : B형</p>
			<p>이메일 : kimwonny8@gmail.com</p>
			<p></p>
			<button onclick="location.href='http://github.com/kimwonny8'">
				<img src="img/github.png" />
			</button>
		</div>

		<div class="menu">
			<button onclick="location.href='main.jsp'">
				<img src="img/left.png" />
			</button>
			<button onclick="location.href='hobby.jsp'">
				<img src="img/right.png" />
			</button>
		</div>
	</div>
</body>
</html>
