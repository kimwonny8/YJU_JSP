<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% session.setAttribute("loginState", "adjust"); %>
<%@ include file="./header.jsp" %>
<h1>관리자 페이지</h1>
<%
String driverName = "org.mariadb.jdbc.Driver";
String url = "jdbc:mariadb://localhost/member_db";
String user = "root";
String passwd = "root";

Class.forName(driverName);
Connection con = DriverManager.getConnection(url, user, passwd);
request.setCharacterEncoding("utf-8");	

String sql = "select * from member order by mem_num";
PreparedStatement pstmt = con.prepareStatement(sql);

ResultSet rs=pstmt.executeQuery();

int mem_num;
String mem_name;
String mem_id;
String mem_email;
String mem_phone;
String mem_RRN;
String mem_class;
String mem_class_name="";

%>
	<table border="1" width="80%" height="100%" style="text-align:center">
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>이메일</th>
				<th>휴대폰번호</th>
				<th>주민등록번호</th>
				<th>등급</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
<%
	while(rs.next()){
		mem_num = rs.getInt("mem_num");
		mem_name = rs.getString("mem_name");
		mem_id = rs.getString("mem_id");
		mem_email = rs.getString("mem_email");
		mem_phone = rs.getString("mem_phone");
		mem_RRN = rs.getString("mem_RRN");
		mem_class = rs.getString("mem_class");
		
		if(mem_class.equals("30")) mem_class_name="관리자";
		else if(mem_class.equals("50")) mem_class_name="교수";
		else if(mem_class.equals("100")) mem_class_name="학생";
		
%>
		<tr>
			<td><%= mem_num %></td>
			<td><%= mem_name %></td>
			<td><%= mem_id %></td>
			<td><%= mem_email %></td>
			<td><%= mem_phone %></td>
			<td><%= mem_RRN %></td>
			<td><%= mem_class_name %></td>
			<td>

			<form method="post" action="/member01/mem_models/member_dao.jsp">
<%
			if(!mem_class_name.equals("관리자")){
%>
			<select name="mem_class">
				<option value=100 >학생</option>
			    <option value=50>교수</option>
			    <option value=30 >관리자</option>
			</select>
			<input type="hidden" name="mem_num" value="<%=mem_num%>"> 
			<input type="hidden" name="actionType" value="MANAGE_ADJUST">
		    <input type="submit" value="수정">
<% } %>
		    </form>
			</td>
			
		</tr>
		
<%
	}
%>	


</body>
</html>