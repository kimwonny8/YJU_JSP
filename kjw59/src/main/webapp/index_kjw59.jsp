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
	if (session.isNew()) {
		session.setAttribute("loginState", "logout");
		session.setAttribute("userid", null);
		session.setAttribute("userpw", null);
	}
%>


<h1>2101059 김정원</h1>
<h2>출입자 명부</h2>
<hr>
<li><a href="./covid_c_kjw59.jsp">등록(C)</a></li>
<li><a href="./covid_r_kjw59.jsp?currentPageNo=0&limitCnt=10">조회</a></li>
<li><a href="./covid_u_kjw59.jsp">수정(U)</a></li>
<li><a href="./covid_d_kjw59.jsp">삭제(D)</a></li>
<li><a href="./signUp_kjw59.jsp">회원가입</a></li>
</body>
</html>
