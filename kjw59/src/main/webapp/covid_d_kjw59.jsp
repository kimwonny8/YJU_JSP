<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>2101059 김정원</h1>
<h2>출입자 명부 - 삭제</h2>
<p>테이블 착석하실 경우 꼭 작성해주셔야합니다.</p>
<p>작성 전 손소독을 꼭 해주시고, 작성 후 신분증 제시 부탁드립니다.</p>
<p>해당 정보는 보건당국의 역학조사 용도로만 사용되며 4주 후 폐기합니다.</p>

<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/covid_db_kjw59";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("utf-8");

	int id;
	String date;
	String time;
	String name;
	String phone;
	String agree;
	String fever;
	
	String sql = "select * from people_kjw59";
	ResultSet rs=stmt.executeQuery(sql);

%>

<form method="post" actoion="covid_dao_kjw59.jsp">
	<input type="hidden" name="actionType" value="D2"> 
	<button type="submit">4주 이상 경과된 데이터 삭제</button>
</form>

<br>
	<table border="1">
		<thead>
			<tr>
				<th>날짜</th>
				<th>방문시각</th>
				<th>성명</th>
				<th>전화번호</th>
				<th>개인정보 수집.제공동의</th>
				<th>발열현상 유무</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
<%
	while(rs.next()){
		id = rs.getInt("id");
		date = rs.getString("date");
		time = rs.getString("time");
		name = rs.getString("name");
		phone = rs.getString("phone");
		agree = rs.getString("agree");
		fever = rs.getString("fever");
	
%>
		<tr>
			<td ><%= id %></td>
			<td ><%= date %></td>
			<td ><%= time %></td>
			<td><%= name %></td>
			<td><%= phone %></td>
			<td><%= agree %></td>
			<td><%= fever %></td>
			<td><a href="./covid_dao_kjw59.jsp?&actionType=D&id=<%=id %>">삭제</a></td>
		</tr>
<%
	}
%>		
	</tbody>
	</table>

	<a href="./index_kjw59.jsp">홈으로 돌아가기</a>
</body>
</html>