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
String actionType=request.getParameter("actionType");
String searchFever=request.getParameter("searchFever");
String searchDate=request.getParameter("searchDate");
int currentPageNo = Integer.parseInt(request.getParameter("currentPageNo"));

int limitCnt=((Integer)session.getAttribute("limitCnt")).intValue();
String tempLimitCnt= request.getParameter("limitCnt"); // 일단 스트링으로 받고 
if (tempLimitCnt != null && !tempLimitCnt.trim().equals("")){// Null 체크 하고 
	try{ 
		limitCnt = Integer.parseInt(tempLimitCnt); // int 로 변환 
	}
	catch (NumberFormatException ex) { 
		limitCnt = 10; 
	}
}

if(searchFever==null) searchFever="all";
if(searchDate==null || searchDate.equals(""))  searchDate="all";

if(actionType!=null && actionType.equals("search")){
	session.setAttribute("limitCnt",limitCnt);
	session.setAttribute("searchDate",searchDate);
	session.setAttribute("searchFever",searchFever);	
}

%>
	<h1>2101059 김정원 kjw59</h1>
	<h2>출입자 명부</h2>
	<p>테이블 착석하실 경우 꼭 작성해주셔야합니다.</p>
	<p>작성 전 손소독을 꼭 해주시고, 작성 후 신분증 제시 부탁드립니다.</p>
	<p>해당 정보는 보건당국의 역학조사 용도로만 사용되며 4주 후 폐기합니다.</p>
	<form action="./covid_r_kjw59.jsp" method="post">
		개수별 보기: <select name="limitCnt">
			<option value=10 selected>10</option>
			<option value=30>30</option>
			<option value=50>50</option>
			<option value=100>100</option>
		</select> 
		
		<br>날짜별 검색: <input type="date" name="searchDate" id="date" value="all">
		<br>발열현상 유무별 보기: <select name="searchFever">
			<option value="all" selected>전체</option>
			<option value="O">O</option>
			<option value="X">X</option>
		</select> 	
		<input type="hidden" name="actionType" value="search">
		<input type="hidden" name="limitCnt" value="10">
		<input type="hidden" name="currentPageNo" value="<%=currentPageNo%>">
		<input type="submit" value="확인">
	</form>
	<hr>
	
	<table border="1" style="text-align:center;">
		<thead>
			<tr>
				<th>번호</th>
				<th>날짜</th>
				<th>방문시각</th>
				<th>성명</th>
				<th>전화번호</th>
				<th>개인정보 수집.제공동의</th>
				<th>발열현상 유무</th>
			</tr>
		</thead>
		<tbody>

	<%
		String driverName = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://localhost/covid_db_kjw59";
		String user = "root";
		String passwd = "root";

		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url, user, passwd);
		Statement stmt = con.createStatement();
		PreparedStatement pstmt = null;
		request.setCharacterEncoding("utf-8");
		
		String sql2 = "select count(*) from people_kjw59";
		ResultSet rs2 = stmt.executeQuery(sql2);
		
		int recordCnt = 0;
		int startRecord = currentPageNo * limitCnt;

		while (rs2.next()) {
			recordCnt = rs2.getInt(1); // count(*) 가져와서 담음
		}
		int pageCnt = recordCnt / limitCnt;
		if (recordCnt % limitCnt != 0)
			pageCnt++; 
		
		int id;
		String date;
		String time;
		String name;
		String phone;
		String agree;
		String fever;

		String sql;
		if(!searchDate.equals("all") && !searchFever.equals("all")){
			sql = "select * from people_kjw59 where date=? and fever=? order by id limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, searchDate);
			pstmt.setString(2, searchFever);
			pstmt.setInt(3, startRecord);
			pstmt.setInt(4, limitCnt);	
		}
		else if(searchDate.equals("all") && !searchFever.equals("all")) {
			sql = "select * from people_kjw59 where fever=? order by id limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, searchFever);
			pstmt.setInt(2, startRecord);
			pstmt.setInt(3, limitCnt);	
		}
		else if(!searchDate.equals("all") && searchFever.equals("all")){
			sql = "select * from people_kjw59 where date=? order by id limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, searchDate);
			pstmt.setInt(2, startRecord);
			pstmt.setInt(3, limitCnt);	
		}
 		else {
			sql = "select * from people_kjw59 order by id limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRecord);
			pstmt.setInt(2, limitCnt);	
		}
		 
		ResultSet rs = pstmt.executeQuery();
		
	%>
	<p>[ 현재 <%=limitCnt %>개씩 보기, 날짜: <%=searchDate %>, 발열현상 유무: <%=searchFever%> ] 검색 중입니다.</p>
	<%
		while (rs.next()) {
			id = rs.getInt("id");
			date = rs.getString("date");
			time = rs.getString("time");
			name = rs.getString("name");
			phone = rs.getString("phone");
			agree = rs.getString("agree");
			fever = rs.getString("fever");
	%>
			<tr>
				<td><%=id%></td>
				<td><%=date%></td>
				<td><%=time%></td>
				<td><%=name%></td>
				<td><%=phone%></td>
				<td><%=agree%></td>
				<td><%=fever%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<br>
	
	<a href="./covid_r_kjw59.jsp?currentPageNo=0">[처음]</a>
<% 	if (currentPageNo > 0) { %>
		<a href="./covid_r_kjw59.jsp?currentPageNo=<%=(currentPageNo-1)%>">[이전]</a>
<%	} else { %> [이전] <% }

	int pageNo = currentPageNo / 10; // 0부터 시작
	int end=(pageNo + 1) * 10 ;
	if(end> pageCnt){ end=pageCnt; }
	for (int i = pageNo * 10; i < end; i++) {
		if (i > pageCnt - 1) break;
		
		if (i == currentPageNo) { 
			%> [<%=(i + 1)%>] <%
		} 
		else { %> 
			<% 	if (currentPageNo > 0) { %>
				<a href="./covid_r_kjw59.jsp?currentPageNo=<%=(currentPageNo-1)%>">[<%=(i + 1)%>]</a>
			<%	} else { %>
				<a href="./covid_r_kjw59.jsp?currentPageNo=<%=(currentPageNo+1)%>">[<%=(i + 1)%>]</a> 
			<% }
		}
	}
	if (currentPageNo < pageCnt - 1) { %>
		<a href="./covid_r_kjw59.jsp?currentPageNo=<%=(currentPageNo+1)%>">[다음]</a> 
	<% }
	else { %> [다음] <% 
	} %> 	
	<a	href="./covid_r_kjw59.jsp?currentPageNo=<%=(pageCnt-1)%>">[마지막]</a>
	<br>
	
	<a href="./index_kjw59.jsp">홈으로 돌아가기</a>
</body>
</html>