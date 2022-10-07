<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.loginbar {
display: flex;
justify-content: space-between;
align-items: center;
padding-right:2vw;
}

.loginbar > p {
padding-left:5vw;
color: gray;
}

.menubar {
padding: 2vh 0;
border-top: 1px solid rgba(0, 0, 0, 0.2);
}

.menubar > button {
margin-left:4vw;
border: 0;
}
</style>
</head>

<body>
<%
	if(session.isNew()){
		session.setAttribute("loginState", "logout");
		session.setAttribute("userid", null);
		session.setAttribute("userpw", null);
	}
%>
<div class="loginbar">
	<p>회원관리 시스템 V0.1</p>
<%
		if(session.getAttribute("loginState").equals("login")) {

			if(session.getAttribute("userclass").equals("30")){
%>
			<form name="logout" method="post" action="/member_1조/mem_models/member_dao.jsp">
			  <%=session.getAttribute("userid")%>님 로그인중
			  <input type="hidden" name="actionType" value="LOGOUT">
			  <input type="submit" value="로그아웃">
			  <a href="/member_1조/manage_index_page.jsp">관리하기</a>
			</form> 
<%		
		}
			else {
%>
				<form name="logout" method="post" action="/member_1조/mem_models/member_dao.jsp">
				  <%=session.getAttribute("userid")%>님 로그인중
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

%>		
	</div>
	<div class="menubar">
	<a href="/member_1조/index.jsp"><button type="button"><img src="/member_1조/images/yju_logo_01.png" width=100%></a>
	</button>
		
<%
		if(session.getAttribute("loginState").equals("login")){
%>
			<%@ include file= "/GNB.jsp" %>
<%
		}
%>
	</div>
</body>
</html>