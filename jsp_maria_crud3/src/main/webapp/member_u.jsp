<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>edit</title>
</head>
<body>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");
	
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	String mb_pw;
	String mb_name;
	String mb_birth;
	String mb_phone;
	String mb_email;
	
	String mb_id=request.getParameter("mb_id");
	pstmt = con.prepareStatement("select * from member where mb_id = ?");
	pstmt.setString(1, mb_id);
	rs=pstmt.executeQuery();

	if(rs.next()){
		mb_pw = rs.getString("mb_pw");
		mb_name = rs.getString("mb_name");
		mb_birth = rs.getString("mb_birth");
		mb_email = rs.getString("mb_email");
		mb_phone = rs.getString("mb_phone");
	
%>

<div>
<a href="./member.jsp">홈으로</a>
<h1>회원정보수정</h1>
</div>
<form method="post" action="./member_dao.jsp">
<div>
<p>변경할 내용을 입력해주세요. 아이디는 변경되지 않습니다.</p>
아이디 : <input type="text" name="mb_id" size="30" value="<%=mb_id%>" readonly>
<br> 비밀번호 : <input type="password" name="mb_pw" size="30" value="<%=mb_pw%>">
<br> 비밀번호 확인 : <input type="password" name="mb_pw2" size="30"  value="<%=mb_pw%>">

<br> 이름 : <input type="text" name="mb_name" size="30" value="<%=mb_name%>">
<!--  
<br> 주민등록번호 : <input type="text" name="mb_birth" size="30" value="<%=mb_birth%>" placeholder="'-'없이 숫자만 입력하세요." disabled>
-->
<br> 이메일 : <input type="text" name="mb_email" size="40" value="<%=mb_email%>" placeholder="email@gmail.com">
<br> 휴대폰번호 : <input type="text" name="mb_phone" size="20" value="<%=mb_phone %>" placeholder="010-1234-5678">
<div>
<input type="hidden" name="actionType" value="memberEdit">
<br><input type="submit" value="수정 완료">
<%
}
%>
</div>
</div>

</form>
</body>
</html>