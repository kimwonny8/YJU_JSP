<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.swing.JOptionPane"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/member_db";
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

    int mem_num;
	String mem_name;
    String mem_id;
	String mem_passwd;
	String mem_email;
	String mem_phone;
	String mem_RRN;
	String mem_class;
	
	String userID;
	String userPW;
	
	
	
	int loginState;

	switch(actionType){
		case "LOGIN":
			userID = request.getParameter("userid");
		    userPW = request.getParameter("passwd");
		    
		    pstmt = con.prepareStatement("select mem_id, mem_passwd, mem_class from member where mem_id = ?");
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				String userID_DUMMY = rs.getString("mem_id");
				String userPW_DUMMY = rs.getString("mem_passwd");
				String userclass = rs.getString("mem_class");
				
				  if(userID.equals(userID_DUMMY)){
				    	if(userPW.equals(userPW_DUMMY)){
				    		session.setAttribute("loginState", "login");
				    		session.setAttribute("userid", userID);
				    		session.setAttribute("userpw", userPW);
				    		session.setAttribute("userclass", userclass);
				    	}else{
				    		session.setAttribute("loginState", "errorPW");
				    	}
				    }else{
				    	session.setAttribute("loginState", "errorID");
				    }		
			}
			else {
				%>
				alert("존재하지 않는 아이디입니다.");
				<% 
			}
			response.sendRedirect("../index.jsp");
		    break;
		    
		case "LOGOUT":
			session.setAttribute("userid", null);
			session.setAttribute("userpw", null);
			session.setAttribute("loginState", "logout");
			response.sendRedirect("../index.jsp");
			break;
		
		case "SIGNUP":
			mem_name=request.getParameter("mem_name");
			mem_id=request.getParameter("mem_id");
			mem_passwd=request.getParameter("mem_passwd");
			mem_email=request.getParameter("mem_email");
			mem_phone=request.getParameter("mem_phone");
			mem_RRN=request.getParameter("mem_RRN");
			
			sql="insert into member (mem_name, mem_id, mem_passwd, mem_email, mem_phone, mem_RRN)";
			sql+="values (?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_name);
			pstmt.setString(2, mem_id);
			pstmt.setString(3, mem_passwd);
			pstmt.setString(4, mem_email);
			pstmt.setString(5, mem_phone);
			pstmt.setString(6, mem_RRN);
			rs = pstmt.executeQuery();
			
			//session.setAttribute("loginState", "logout");
			response.sendRedirect("../index.jsp");
			break;
			
		case "MANAGE_ADJUST":
			mem_class=request.getParameter("mem_class");
			mem_num=Integer.parseInt(request.getParameter("mem_num"));
			
			sql="update member set mem_class = ? where mem_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mem_class);
			pstmt.setInt(2, mem_num);
			rs = pstmt.executeQuery();
			
			session.setAttribute("loginState", "login");
%>
			<script type="text/javascript">
				alert("변경 완료되었습니다.");
				location.href="/member_1조/manage_page.jsp?currentPageNo=0&pageRange=10&searchClass=0";
			</script>
<%		
			break;
	
		case "DELETE" :
			mem_num = Integer.parseInt(request.getParameter("mem_num"));
			sql = "DELETE FROM member WHERE mem_num = ";
			sql += mem_num;
			System.out.println(sql);
			
			result = stmt.executeUpdate(sql);

			if (result == 1) {
				System.out.println("삭제성공");
			} else {
				System.out.println("삭제실패");
			}
%>
			<script>
				alert("탈퇴 완료되었습니다.");
				location.href="/member_1조/manage_page.jsp?currentPageNo=0&pageRange=10&searchClass=0";
			</script>
<%			break;
			
		default:
			break;
	}
%>

<%-- <jsp:forward page="../index.jsp"/> --%>

</body>
</html>