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

.contentLeft>img {
	width: 35vw;
	border-radius: 20px;
	box-shadow: 3px 5px 5px grey;
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
			<p>취미</p>
			<img
				src="https://www.canceranswer.co.kr/news/photo/202109/3045_4820_1253.jpg" />
		</div>
		<div class="contentRight">
			<h1>운동</h1>
			<p>크로스핏</p>
			<p>헬스</p>
			<p>수영</p>
			<p>프리다이빙</p>
			<br>
			<h1>개발</h1>
			<p>알고리즘 공부</p>
			<p>vue.js</p>
			<p>kotiln</p>
		</div>

		<div class="menu">
			<button onclick="location.href='introduce.jsp'">
				<img src="img/left.png" />
			</button>
			<button onclick="location.href='goal.jsp'">
				<img src="img/right.png" />
			</button>
		</div>
	</div>
</body>
</html>
