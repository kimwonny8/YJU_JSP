
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<%
session.setAttribute("loginState", "signup");
%>
<%@ include file="./header.jsp" %>

<h1>회원가입</h1>

<form name="signup" method="post" action="/member01/mem_models/member_dao.jsp">
이름 : <input type="text" name="mem_name" size="20"><br>
아이디 : <input type="text" name="mem_id" id="mem_id" size="30">
<br>
비밀번호 : <input type="password" name="mem_passwd" size="30"><br>
이메일 : <input type="text" name="mem_email" size="30"><br>
휴대폰번호 : <input type="text" name="mem_phone" size="30" placeholder="010-1234-5678"><br>
주민등록번호 : <input type="text" name="mem_RRN" size="30" placeholder="000000-0000000"><br>
<input type="hidden" name="actionType" value="SIGNUP">
<input type="submit" value="회원가입">
</form>


</body>
</html>