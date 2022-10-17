<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

</script>
</head>
<body>
<h1>서적관리시스템 - 수정(U)</h1>
<hr>
<%
try{
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/test_db";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");
%>
<%
	int book_id;
	String title;
	String publisher;
	String year;
	int price;
	
	String sql = "select * from books order by book_id";
	ResultSet rs=stmt.executeQuery(sql);
	
%>
	<table border="1">
		<thead>
			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>출판사</th>
				<th>출판년도</th>
				<th>가격</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
<%
	while(rs.next()){
		book_id = rs.getInt("book_id");
		title = rs.getString("title");
		publisher = rs.getString("publisher");
		year = rs.getString("year");
		price = rs.getInt("price");
%>
		<tr>
			<td><%= book_id %></td>
			<td><%= title %></td>
			<td><%= publisher %></td>
			<td><%= year %></td>
			<td><%= price %></td>
			<td><a href="./test_u2.jsp?book_id=<%=book_id%>&title=<%=title%>&publisher=<%=publisher%>&year=<%=year%>&price=<%=price%>">수정</a></td>
		</tr>
<%
	}
}catch(Exception e){
	e.printStackTrace();
}
%>		
	</tbody>
	</table>
	<br><a href="./index.jsp">홈으로 돌아가기</a>
</body>
</html>