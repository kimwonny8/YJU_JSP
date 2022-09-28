<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String mb_id=request.getParameter("mb_id");
%>
<a href="./member.jsp">뒤로</a>
<h1>회원 탈퇴</h1>
<form method="post" action="./member_dao.jsp">
아이디 : <input type="text" name="mb_id" size="20" value="<%=mb_id %>"  disabled>
<br> 비밀번호 : <input type="password" name="mb_pw" size="30">
<br> 비밀번호 확인 : <input type="password" name="mb_pw2" size="30">
<input type="hidden" name="actionType" value="memberDelete">
<input type="submit" value="회원탈퇴">
</form>
</body>
</html>