<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>서적관리시스템 - 조회(R3)</h1>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/book_db";
	String user = "root";
	String passwd = "root";
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);
	Statement stmt = con.createStatement();
	request.setCharacterEncoding("utf-8");

	String sql2 = "select count(*) from books ";
	ResultSet rs2=stmt.executeQuery(sql2);
	
	int recordCnt=0;
	int pageCnt;
	// 페이징 처리하려고 만든 변수
	int startRecord = 0;
	int limitCnt = Integer.parseInt(request.getParameter("limitCnt"));
	int currentPageNo = Integer.parseInt(request.getParameter("currentPageNo"));
	startRecord = currentPageNo * limitCnt;
	
	while(rs2.next()){
		recordCnt = rs2.getInt(1); // count(*) 가져와서 담음
	}
	pageCnt = recordCnt/limitCnt;
	if(recordCnt%limitCnt !=0) pageCnt++; // 남아있는 게 더 있다면 다음 페이지 있어야함~!

	int book_id;
	String title;
	String publisher;
	String year;
	int price;
	
	String sql = "select * from books order by book_id limit ";
	sql += startRecord + "," + limitCnt;
	// limit 0, 10 => 0번 인덱스부터 10개를 가져옴
	
	ResultSet rs=stmt.executeQuery(sql);
%>

<hr>
<h2>전체보기(부분조회 미포함, 페이징기능개선, 출력레코드갯수선택, 세선객체사용안함)</h2>
<hr>
<h2>현재 DISPLAY RECORDS NUMBER: <%=limitCnt %></h2>
<hr>

<form action="./book_r3.jsp" method="post" >
    디스플레이 레코드수 변경 :
    <select name="limitCnt" >
    <option value=10 >10</option>
    <option value=30 >30</option>
    <option value=50 >50</option>
    <option value=100 >100</option> 
</select> 

<input type="hidden" name="currentPageNo" value="<%=currentPageNo%>">
<input type="submit" value="확인"><br>

</form>
<br>
	<table border="1">
		<thead>
			<tr>
				<th>순번</th>
				<th>제목</th>
				<th>출판사</th>
				<th>출판년도</th>
				<th>가격</th>
			</tr>
		</thead>
		<tbody>
<%
	while(rs.next()){
		book_id = rs.getInt("book_id");
		title = rs.getString("title");
		publisher = rs.getString("publisher");
		year = rs.getString("year");
		price = rs.getInt("price");
%>
		<tr>
			<td ><%= book_id %></td>
			<td ><%= title %></td>
			<td><%= publisher %></td>
			<td><%= year %></td>
			<td><%= price %></td>
		</tr>
<%
	}
%>		
	</tbody>
	</table>
<br>
<a href = "./book_r3.jsp?currentPageNo=0&limitCnt=<%=limitCnt%>">[처음]</a>	
<%
	if(currentPageNo > 0){
%>
	<a href="./book_r3.jsp?currentPageNo=<%=(currentPageNo-1)%>&limitCnt=<%=limitCnt%>">[이전]</a>		
<%		
	}else {
%>	
	[이전]
<% 
	}

	for(int i=0; i<pageCnt; i++){
		if(i==currentPageNo){
%>
			[<%=(i+1)%>]			
<%
		}else { 
%>
		<a href="./book_r3.jsp?currentPageNo=<%=i%>&limitCnt=<%=limitCnt%>">[<%=(i+1)%>]</a>
<%		
		}
	}
%>
<%
	if(currentPageNo < pageCnt -1) {
%>
	<a href="./book_r3.jsp?currentPageNo=<%=(currentPageNo+1) %>&limitCnt=<%=limitCnt%>">[다음]</a>
<%	
	}else{
%>	
	[다음]
<%	
	}
%>
<a href="./book_r3.jsp?currentPageNo=<%=(pageCnt-1) %>&limitCnt=<%=limitCnt%>">[마지막]</a>
<br>
	<a href="./index.jsp">홈으로 돌아가기</a>
</body>
</html>