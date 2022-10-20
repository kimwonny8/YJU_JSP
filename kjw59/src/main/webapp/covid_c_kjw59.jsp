<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h1>2101059 김정원 kjw59</h1>
<h2>출입자 명부</h2>

<%
String name="";
String phone="";

if(session.getAttribute("loginState")=="login"){
	name = (String)session.getAttribute("mem_name");
	phone = (String)session.getAttribute("mem_phone");
}
%>

<a href="./index_kjw59.jsp">홈으로</a>
<form method="post" action="./covid_dao_kjw59.jsp">
	<div>
		날짜 : <input type="date" name="date" id="date">
		<br> 방문시각 : <input type="time" name="time" id="time">
		<br> 성명 : <input type="text" name="name" size="30" value="<%=name%>">
		<br> 휴대폰번호 : <input type="text" name="phone" size="20" value="<%=phone%>">
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
<script>
document.getElementById('date').valueAsDate = new Date();
document.getElementById('time').value = new Date().toISOString().slice(11, 16);
</script>
</body>
</html>