<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>2101059 김정원</h1>
<h2>출입자 명부</h2>

<%
Date today = new Date(); 
SimpleDateFormat t = new SimpleDateFormat("HH:mm");
String time = t.format(today);

Calendar cal = Calendar.getInstance();
String date= cal.get(Calendar.MONTH)+"/"+cal.get(Calendar.DATE);

%>

<a href="./index_kjw59.jsp">홈으로</a>
<form method="post" action="./covid_dao_kjw59.jsp">
	<div>
		날짜 : <input type="text" name="date" value="<%=date%>" >
		<br> 방문시각 : <input type="text" name="time" value="<%=time %>">
		<br> 성명 : <input type="text" name="name" size="30">
		<br> 휴대폰번호 : <input type="text" name="phone" size="20" placeholder="010-1234-5678">
		<br> 개인정보 수집,제공 동의 
		<input type="radio" name="agree" value="O">O
		<input type="radio" name="agree" value="X">X
		
		<br> 발열현상 유무
		<input type="radio" name="fever" value="O">O
		<input type="radio" name="fever" value="X">X
		
		<div>
		<input type="hidden" name="actionType" value="C">
		<br><input type="submit" value="등록">
	
		</div>
	</div>

</form>

</body>
</html>