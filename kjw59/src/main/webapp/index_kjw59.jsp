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
		session.setAttribute("mem_id", null);
		session.setAttribute("mem_name", null);
		session.setAttribute("mem_phone", null);
		session.setAttribute("limitCnt", 10);
		session.setAttribute("searchDate", null);
		session.setAttribute("searchFever", null);
	}
%>


<h1>2101059 김정원 kjw59</h1>
<h2>출입자 명부</h2>
<hr>
<%
if(session.getAttribute("loginState")=="logout"){
	%>
	<form method="post" action="./member_dao_kjw59.jsp">
		아이디: <input type="text" name="mem_id">
		<br> 비밀번호: <input type="password" name="mem_passwd"> <button name="actionType" value="LOGIN">로그인</button>
	</form>
	<%
}
else {
	
	%>
	<p><%=session.getAttribute("mem_name") %>님 안녕하세요!</p>
	<form method="post" action="./member_dao_kjw59.jsp">
		<button name="actionType" value="LOGOUT">로그아웃</button>
	</form>
	<%
}

%>


<br>
<li><a href="./covid_c_kjw59.jsp">등록(C)</a></li>
<li><a href="./covid_r_kjw59.jsp?currentPageNo=0">조회</a></li>
<li><a href="./covid_u_kjw59.jsp">수정(U)</a></li>
<li><a href="./covid_d_kjw59.jsp">삭제(D)</a></li>
<li><a href="./signUp_kjw59.jsp">회원가입</a></li>
</body>
</html>
