<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>home</title>
</head>
<body>
<h2>메인 페이지</h2>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");

	String mb_id =(String)session.getAttribute("mb_id");

	int mb_num;
	String sql = "select * from member where mb_id='"+mb_id+"'";
	ResultSet rs=stmt.executeQuery(sql);
	
	while(rs.next()){
		mb_num=rs.getInt("mb_num");
		
%>
<p><%=mb_id %>님 환영합니다!</p>
<form method="post" action="./member_dao.jsp">
<input type="hidden" name="mb_num" value="<%=mb_num%>">
<input type="hidden" name="actionType" value="signOut">
<input type="submit" value="로그아웃">
<a href="./member_d.jsp?mb_id=<%=mb_id%>">회원탈퇴</a>
<a href="./member_u.jsp?mb_id=<%=mb_num%>">회원수정</a>
<% } %>
</form>
</body>
</html>