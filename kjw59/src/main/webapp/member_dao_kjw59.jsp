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

	case "LOGIN" :
		mem_id = request.getParameter("mem_id");
		mem_passwd = request.getParameter("mem_passwd");
		
		sql = "select * from member where mem_id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, mem_id);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			String mem_passwd2 = rs.getString("mem_passwd");
			mem_phone = rs.getString("mem_phone");
			mem_name = rs.getString("mem_name");
			
			if(mem_passwd2.equals(mem_passwd)){
				session.setAttribute("loginState", "logout");
				session.setAttribute("loginState", "login");
				session.setAttribute("mem_id", mem_id);
				session.setAttribute("mem_name", mem_name);
				session.setAttribute("mem_phone", mem_phone);	
				%>
				<script type="text/javascript">
					alert("로그인 성공!");
					location.href = "/kjw59/index_kjw59.jsp";
				</script>
				
				<%
			}
			else {
				%>
				<script type="text/javascript">
					alert("비밀번호를 확인해주세요!");
					history.back();
				</script>
				<% 
			}
		}
		else {
			%>
			<script type="text/javascript">
				alert("존재하지 않는 아이디입니다.");
				history.back();
			</script>
			<% 
		}
		break;

	case "LOGOUT" :
		session.setAttribute("loginState", "logout");
		session.setAttribute("mem_id", null);
		session.setAttribute("mem_name", null);
		session.setAttribute("mem_phone", null);
		
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