<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.swing.JOptionPane"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원정보</title>
</head>
<body>
	<h1>데이터베이스 처리 부분</h1>
	<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
	String user = "root";
	String passwd = "root";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	%>
	<%
	String actionType = request.getParameter("actionType");

	String mb_id;
	String mb_pw;
	String mb_pw2;
	String mb_name;
	String mb_birth;
	String mb_email;
	String mb_phone;
	boolean temp;
	String sql;
	int result;
	String msg = "";

	switch (actionType) {

		// 회원가입
		case "signUp" :
			boolean suc = true;
			mb_id = request.getParameter("mb_id");
			mb_pw = request.getParameter("mb_pw");
			mb_pw2 = request.getParameter("mb_pw2");
			mb_name = request.getParameter("mb_name");
			mb_birth = request.getParameter("mb_birth");
			mb_email = request.getParameter("mb_email");
			mb_phone = request.getParameter("mb_phone");

			String error_code = "";
			pstmt = con.prepareStatement("select * from member where mb_id = ?");
			pstmt.setString(1, mb_id);
			rs = pstmt.executeQuery();
			temp = rs.next();

			if (temp) {
				suc = false;
				error_code += "아이디, ";
			}

			pstmt = con.prepareStatement("select * from member where mb_email = ?");
			pstmt.setString(1, mb_email);
			rs = pstmt.executeQuery();
			temp = rs.next();

			if (temp) {
				suc = false;
				error_code += "이메일, ";
			}

			pstmt = con.prepareStatement("select * from member where mb_birth = ?");
			pstmt.setString(1, mb_birth);
			rs = pstmt.executeQuery();
			temp = rs.next();

			if (temp) {
				suc = false;
				error_code += "주민등록번호, ";
			}

			if (!suc) {
		error_code = error_code.substring(0, error_code.length() - 2);
	%>
	<script>
				alert("<%=error_code%>
		를 다시 입력해주세요!");
		history.back();
	</script>
	<%
	}

	else if (mb_pw.equals(mb_pw2)) {
	sql = "insert into member (mb_name, mb_id, mb_pw, mb_email, mb_phone, mb_birth) values ";
	sql += "('" + mb_name + "','" + mb_id + "','" + mb_pw + "','" + mb_email + "', '" + mb_phone + "','" + mb_birth + "')";

	result = stmt.executeUpdate(sql);

	if (result == 1) {
	%>
	<script>
		alert("회원가입 완료! 로그인 후 이용해주세요");
		document.location.href = './index.jsp'
	</script>
	<%
	} else {
	System.out.println("레코드 추가 실패");
	msg += "레코드 추가 실패";
	}
	}

	else {
	%>
	<script>
		alert("비밀번호가 맞지 않습니다. 다시 입력해주세요");
		history.back();
	</script>
	<%
	}

	break;

	// 로그인
	case "signIn" :
	mb_id = request.getParameter("mb_id");
	mb_pw = request.getParameter("mb_pw");

	pstmt = con.prepareStatement("select mb_pw, mb_name, mb_id from member where mb_id = ?");
	pstmt.setString(1, mb_id);
	rs = pstmt.executeQuery();

	if (rs.next()) {
	if (mb_pw.equals(rs.getString("mb_pw"))) {
		session.setAttribute("mb_id", rs.getString("mb_id"));
		System.out.println("로그인 성공");
		response.sendRedirect("./member.jsp");
	} else {
		System.out.println("로그인 실패");
	%>
	<script>
		alert("비밀번호가 틀렸습니다. 다시 입력해주세요");
		document.location.href = './index.jsp'
	</script>
	<%
	}
	} else {
	System.out.println("로그인 실패");
	%>
	<script>
		alert("존재하지 않는 아이디입니다. 다시 입력해주세요");
		document.location.href = './index.jsp'
	</script>
	<%
	}

	break;

	// 로그아웃
	case "signOut" :
	session.invalidate();
	response.sendRedirect("./index.jsp");
	break;

	// 회원탈퇴
	case "memberDelete" :
	mb_id = request.getParameter("mb_id");
	mb_pw = request.getParameter("mb_pw");
	mb_pw2 = request.getParameter("mb_pw2");

	pstmt = con.prepareStatement("select mb_pw from member where mb_id = ?");
	pstmt.setString(1, mb_id);
	rs = pstmt.executeQuery();

	if (rs.next()) {
		if (mb_pw.equals(mb_pw2)) {
			sql = "delete from member where mb_id = '" + mb_id + "'";
			System.out.println(sql);
			result = stmt.executeUpdate(sql);
			if (mb_pw.equals(rs.getString("mb_pw"))) {
				if (result == 1) {
		%>
				<script>
					alert("탙퇴 완료. 이용해주셔서 감사합니다.");
					document.location.href = './index.jsp'
				</script>
		<%
				} else {
				System.out.println("탈퇴 실패");
				msg += "탈퇴실패";
				}
			} else {
			%>
			<script>
				alert("비밀번호가 일치하지 않습니다. 확인 후 다시 시도해주세요.");
				history.back();
				//document.location.href = './member.jsp'
			</script>
			<%
			}
			} else {
			%>
			<script>
				alert("비밀번호가 일치하지 않습니다. 확인 후 다시 시도해주세요.");
				history.back();
				//document.location.href = './member.jsp'
			</script>
			<%
		}
	}
	break;

	case "memberEdit" :
	mb_id = request.getParameter("mb_id");
	mb_pw = request.getParameter("mb_pw");
	mb_pw2 = request.getParameter("mb_pw2");
	mb_name = request.getParameter("mb_name");
	mb_email = request.getParameter("mb_email");
	mb_phone = request.getParameter("mb_phone");

	if (mb_pw.equals(mb_pw2)) {
	pstmt = con.prepareStatement("update member set mb_name = ?, mb_email = ?, mb_phone = ?, mb_pw = ? where mb_id = ?");
	pstmt.setString(1, mb_name);
	pstmt.setString(2, mb_email);
	pstmt.setString(3, mb_phone);
	pstmt.setString(4, mb_pw);
	pstmt.setString(5, mb_id);
	rs = pstmt.executeQuery();
	%>
	<script>
		alert("회원 정보가 수정되었습니다.");
		document.location.href = './member.jsp'
	</script>
	<%
	}

	else {
	%>
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
	</script>
	<%
	}
	break;
	}
	%>
	
	<br>
	<a href="./index.jsp">홈으로 돌아가기</a>
</body>
</html>