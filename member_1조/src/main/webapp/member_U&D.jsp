<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 및 삭제</title>
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
	System.out.println(userID);
	
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
	[회원정보 수정]
    <br><input type="hidden" name="mem_num" value=<%=mem_num%>>
	<br>회원명(수정불가) : <input type="text" name="mem_name" size="30" value=<%=mem_name%> readonly>
	<br>아이디(수정불가) : <input type="text" name="mem_id" size="30" value=<%=mem_id%> readonly>
	<br>패스워드 : <input type="text" name="mem_passwd" size="30" value=<%=mem_passwd%>>
	<br>이메일 : <input type="text" name="mem_email" size="30" value=<%=mem_email%>>
	<br>휴대폰 : <input type="text" name="mem_phone" size="30" value=<%=mem_phone%>>
	<br>주민번호(수정불가) : <input type="text" name="mem_RRN" size="30" value=<%=mem_RRN%> readonly>
	<br><br><button type="submit" id="confirm_u" name="actionType" value="mem_U">수정</button>
	<button type="submit" id="confirm_d" name="actionType" value="mem_D">회원탈퇴</button>
</form>

<%
	}
%>
<script>
	var check = document.getElementById("confirm_u");
	check.addEventListener("click", function(){ //수정 버튼을 누른경우
		var result = window.confirm("회원정보를 수정하시겠습니까?");
		
		if(result == true){
			//확인 클릭시 member_dao.jsp로 value속성값 "mem_U"가 전송되어 DB의 레코드 수정
			window.alert("회원정보가 수정되었습니다.");
		}else{
			document.getElementById("confirm_u").setAttribute("value","" );
			//취소 클릭시 value속성값이 ""가 되어 수정 X(id값이 confirm_u인 요소의 value속성값을 ""로 정함")
		}
	});
</script>
<script>
	var check = document.getElementById("confirm_d");
	check.addEventListener("click", function(){ //회원탈퇴 버튼을 누른경우
		var result = window.confirm("정말로 탈퇴하시겠습니까?");
		
		if(result == true){
			//확인 클릭시 member_dao.jsp로 value속성값 "mem_D"가 전송되어 DB의 레코드 삭제
			window.alert("회원탈퇴 되었습니다.");
		}else{
			document.getElementById("confirm_d").setAttribute("value","" );
			//취소 클릭시 value속성값이 ""가 되어 삭제 X
		}
	});
</script>
<br><a href="./index.jsp">홈으로 돌아가기</a>
<%@ include file="../footer.jsp" %>
</body>
</html>