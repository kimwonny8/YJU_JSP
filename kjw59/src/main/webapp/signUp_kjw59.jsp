<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>2101059 김정원 kjw59</h1>
	<h2>회원가입</h2>
	<form method="post" action="./member_dao_kjw59.jsp">
		이름: <input type="text" name="mem_name" size="30">
		<br>아이디 : <input type="text" name="mem_id" id="mem_id" size="30">
		<br>비밀번호: <input  type="password" name="mem_passwd" size="30">
		<br>휴대폰번호: <input type="text" name="mem_phone" size="30">
		<input type="hidden" name="actionType" value="SIGNUP">
		<button type="submit">회원가입</button>
	</form>
</body>
</html>