<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="./header.jsp" %>
<%
 session.setAttribute("searchClass", "0");
 session.setAttribute("pageRange", "10");
 %>
 <ul>
 <li><a href="/member_1조/manage_page.jsp?currentPageNo=0&pageRange=10&searchClass=0">회원 관리</a></li>
 <li><a href="">게시물 관리</a></li>
 </ul>

<%@ include file="./footer.jsp" %>
</body>
</html>