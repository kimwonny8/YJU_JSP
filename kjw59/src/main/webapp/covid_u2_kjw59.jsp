<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>2101059 김정원 kjw59</h1>
<h2>출입자 명부 - 수정</h2>
<%
int id= Integer.parseInt(request.getParameter("id"));
String date = request.getParameter("date");
String time = request.getParameter("time");
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String agree = request.getParameter("agree");
String fever = request.getParameter("fever");

%>
<a href="./index_kjw59.jsp">홈으로</a>
<form method="post" action="./covid_dao_kjw59.jsp">
	<div>
		번호(수정불가) : <input type="text" name="id" value="<%=id%>" readonly>
		<br>날짜 : <input type="date" name="date" value="<%=date%>" >
		<br> 방문시각 : <input type="time" name="time" value="<%=time %>">
		<br> 성명 : <input type="text" name="name" value="<%=name %>" size="30">
		<br> 휴대폰번호 : <input type="text" name="phone" value="<%=phone %>" size="20">
		<br> 개인정보 수집,제공 동의 
		<input type="radio" name="agree" value="O" >O
		<input type="radio" name="agree" value="X">X
		
		<br> 발열현상 유무
		<input type="radio" name="fever" value="O">O
		<input type="radio" name="fever" value="X">X
		
		<div>
		<input type="hidden" name="actionType" value="U">
		<br><input type="submit" value="수정">
	
		</div>
	</div>

</form>

</body>
</html>