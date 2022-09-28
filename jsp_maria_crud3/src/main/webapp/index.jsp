<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
</head>
<body>
<h1>로그인</h1>
<hr>
<form method="post" action="./member_dao.jsp">
아이디 : <input type="text" name="mb_id" size="30" placeholder="아이디를 입력해주세요.">
<br> 비밀번호 : <input type="password" name="mb_pw" size="30" placeholder="비밀번호를 입력해주세요.">
<input type="hidden" name="actionType" value="signIn">
<input type="submit" value="로그인">
</form>
<br><a href="./member_c.jsp">회원가입</a>
</body>
</html>