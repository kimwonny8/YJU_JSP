<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	if(session.isNew()){
		session.setAttribute("loginState", "logout");
		session.setAttribute("userid", null);
		session.setAttribute("userpw", null);
	}
%>

<table>
 <tr>
	 <td><img src="/member_1조/images/yju_logo_01.png"/></td> 
	 <td width="400" align="center"><h1>회원관리 시스템 V0.1</h1></td> 
	 <td>
<%
		if(session.getAttribute("loginState").equals("login")
			|| session.getAttribute("loginState").equals("adjust")) {
%>
			<%=session.getAttribute("userid")%>님 로그인중.
<% 
			if(session.getAttribute("userclass").equals("30")){
%>
			<form name="logout" method="post" action="/member_1조/mem_models/member_dao.jsp">
			  <input type="hidden" name="actionType" value="LOGOUT">
			  <input type="submit" value="로그아웃">
			  <a href="/member_1조/manage_index_page.jsp">관리하기</a>
			</form> 
<%		
		}
			else {
%>
				<form name="logout" method="post" action="/member_1조/mem_models/member_dao.jsp">
				  <input type="hidden" name="actionType" value="LOGOUT">
				  <input type="submit" value="로그아웃">
				</form> 
<%
				}
		}	
		else {
%>
		<form name="login" method="post" action="/member_1조/mem_models/member_dao.jsp">
		    아이디 : <input type="text" name="userid" size="10">
		    비밀번호 : <input type="password" name="passwd" size="10">
		    <input type="hidden" name="actionType" value="LOGIN">
		    <input type="submit" value="로그인">
		    <a href="/member_1조/signup_page.jsp">아이디가 없다면?</a>
		 </form>
<%
		if(session.getAttribute("loginState").equals("errorID")){
			out.print("[사용자ID오류]");
		}
		
		if(session.getAttribute("loginState").equals("errorPW")){
			out.print("[사용자PW오류]");
			}
		}

		//else {}
%>		
	 </td>
 </tr>
</table>
<%
		if(session.getAttribute("loginState").equals("login")){
%>
			<%@ include file= "/GNB.jsp" %>
<%
		}
%>
<hr> 
</body>
</html>