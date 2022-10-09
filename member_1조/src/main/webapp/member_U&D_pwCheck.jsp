<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
</head>
<body>
<%@ include file="../header.jsp" %>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/member_db";
	String user = "root";
	String passwd = "root";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url,user,passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");
%>

<%
	String userID = (String)session.getAttribute("userid");
	//세션객체에서 로그인 상태(해당 id),로그아웃 상태(null)반환
	
	int mem_num;
	String mem_name;
	String mem_id;
	String mem_passwd;
	String mem_email;
	String mem_phone;
	String mem_RRN;
	
	String sql = "select * from member where mem_id='"+userID+"';"; //where조건이 String타입이므로 값 양쪽에 작은따옴표 
	ResultSet rs = stmt.executeQuery(sql);
	
	while(rs.next()){
		mem_num = rs.getInt("mem_num");
		mem_name = rs.getString("mem_name");
		mem_id = rs.getString("mem_id");
		mem_passwd = rs.getString("mem_passwd");
		mem_email = rs.getString("mem_email");
		mem_phone = rs.getString("mem_phone");
		mem_RRN = rs.getString("mem_RRN");
		
%>
	<form method="post" action="./mem_models/member_dao.jsp">
	[패스워드 입력]
	<br><input type="hidden" name="mem_num" value=<%=mem_num%> readonly>
	<br>패스워드 : <input type="text" name="passwdCK" size="30" value="">
	<button type="submit" id="check_pw" name="actionType" value="mem_check_pw">확인</button>
	</form>
<%
	}
%>
<% 
	//입력한 패스워드 불일치 시 member_dao.jsp에서 세션객체 passwdCheck의 값을 false로 바꿈 
	if((String)session.getAttribute("passwdCheck")=="false"){
%>
<script>
		window.alert("패스워드가 일치하지 않습니다.");
</script>
<%
		session.setAttribute("passwdCheck", null); //경고후 값 초기화
	}
%>
<br><a href="./index.jsp">홈으로 돌아가기</a>
</body>
</html>