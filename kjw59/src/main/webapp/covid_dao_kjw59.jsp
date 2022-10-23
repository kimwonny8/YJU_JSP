<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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

<hr>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/covid_db_kjw59";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	request.setCharacterEncoding("utf-8");
%>
<%
	String actionType = request.getParameter("actionType");
	int id;
	String date;
	String time;
	String name;
	String phone;
	String agree;
	String fever;
	
	String sql;
	int result;
	String msg = "실행결과 : ";

	switch(actionType) {
		case "C":
			date = request.getParameter("date");
			time = request.getParameter("time");
			name = request.getParameter("name");
			phone = request.getParameter("phone");
			agree = request.getParameter("agree");
			fever = request.getParameter("fever");
			
			sql = "insert into people_kjw59 (date, time, name, phone, agree, fever) values (?, ?, ?, ?, ?, ?)";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, time);
			pstmt.setString(3, name);
			pstmt.setString(4, phone);
			pstmt.setString(5, agree);
			pstmt.setString(6, fever);
			rs = pstmt.executeQuery();
			response.sendRedirect("./index_kjw59.jsp");
			
			break;
		
		case "D":
			id= Integer.parseInt(request.getParameter("id"));
			sql = "delete from people_kjw59 where id="+id;		
			result = stmt.executeUpdate(sql);
			
			if(result==1){
				%>
				<script>
					alert("삭제 완료!");
					location.href = "/kjw59/index_kjw59.jsp";
				</script>
				<%
			}
			else {
				%>
				<script>
					alert("삭제 실패");
					location.href = "/kjw59/covid_d_kjw59.jsp";
				</script>
				<%
			}
			break;
			
		case "D2":
			sql="delete from people_kjw59 WHERE date < NOW() - INTERVAL 4 week";
			result = stmt.executeUpdate(sql);
			if(result==1) {
				%>
				<script>
					alert("삭제 완료!");
					location.href = "/kjw59/index_kjw59.jsp";
				</script>
				<%
			}
			else {
				%>
				<script>
					alert("삭제할 데이터가 없습니다.");
					location.href = "/kjw59/covid_d_kjw59.jsp";
				</script>
				<%
			}

			break;
		
		case "U":
			id= Integer.parseInt(request.getParameter("id"));
			date = request.getParameter("date");
			time = request.getParameter("time");
			name = request.getParameter("name");
			phone = request.getParameter("phone");
			agree = request.getParameter("agree");
			fever = request.getParameter("fever");
			
			sql = "update people_kjw59 set date=?, time=?, name=?, phone=?, agree=?, fever=? where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, time);
			pstmt.setString(3, name);
			pstmt.setString(4, phone);
			pstmt.setString(5, agree);
			pstmt.setString(6, fever);
			pstmt.setInt(7, id);
			rs = pstmt.executeQuery();
			response.sendRedirect("./index_kjw59.jsp");
			
			break;
	}
%>	
<h2><%=msg %></h2>

<br><a href="./index_kjw59.jsp">홈으로 돌아가기</a>

</body>
</html>