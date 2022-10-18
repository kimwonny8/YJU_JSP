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

	<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/covid_db_kjw59";
	String user = "root";
	String passwd = "root";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql;
	int result;

	String actionType = request.getParameter("actionType");

	String mem_name;
	String mem_id;
	String mem_passwd;
	String mem_phone;

	switch (actionType) {
		
	case "SIGNUP" :
		mem_name = request.getParameter("mem_name");
		mem_id = request.getParameter("mem_id");
		mem_passwd = request.getParameter("mem_passwd");
		mem_phone = request.getParameter("mem_phone");

		sql = "insert into member (mem_name, mem_id, mem_passwd, mem_phone) values (?, ?, ?, ?)";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, mem_name);
		pstmt.setString(2, mem_id);
		pstmt.setString(3, mem_passwd);
		pstmt.setString(4, mem_phone);
		
		rs = pstmt.executeQuery();
		response.sendRedirect("./index_kjw59.jsp");
		break;

	default:
		response.sendRedirect("./index_kjw59.jsp");
		break;
	}
	%>

	<%-- <jsp:forward page="../index.jsp"/> --%>

</body>
</html>