<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>sign-up </title>
</head>
<body>
<form method="post" action="./member_dao.jsp">
<div>
<a href="./member.jsp">홈으로</a>
<h1>회원가입</h1>
</div>
<div>
아이디 : <input type="text" name="mb_id" size="30" >
<br> 비밀번호 : <input type="password" name="mb_pw" size="30">
<br> 비밀번호 확인 : <input type="password" name="mb_pw2" size="30">
<br> 이름 : <input type="text" name="mb_name" size="30">
<br> 주민등록번호 : <input type="text" name="mb_birth" size="30" placeholder="'-'없이 숫자만 입력하세요.">
<br> 이메일 : <input type="text" name="mb_email" size="40" placeholder="email@gmail.com">
<br> 휴대폰번호 : <input type="text" name="mb_phone" size="20" placeholder="010-1234-5678">

<div>
<input type="hidden" name="actionType" value="signUp">
<br><input type="submit" value="회원가입">

</div>
</div>

</form>
</body>
</html>