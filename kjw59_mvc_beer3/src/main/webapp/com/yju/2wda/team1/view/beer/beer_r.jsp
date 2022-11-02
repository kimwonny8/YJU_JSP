<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="kjw59_mvc_beer3.model.beer.*"%>
<%@ include file="/globalData.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이쇼핑몰(KJW59) - 맥주자료조회(R)</title>
</head>
<body>
<h1>마이쇼핑몰(KJW59) - 맥주자료조회(R)</h1>
<hr>
<h2>전체보기(부분조회, 페이징기능 미포함)</h2>

<%
	BeerDTO beer;
	ArrayList<BeerDTO> beerList;
	
	beerList = (ArrayList<BeerDTO>)request.getAttribute("beerList");
%>
<table border="1">
	<thead>
		<tr>
			<th>순번</th>
			<th>코드</th>
			<th>종류</th>
			<th>이름</th>
			<th>원산지</th>
			<th>가격</th>
			<th>알코올</th>
			<th>설명</th>
			<th>좋아요</th>
			<th>싫어요</th>
			<th>사진</th>
	</thead>
	<tbody>
<%
	for(int i=0; i<beerList.size(); i++){
		beer = beerList.get(i);
%>	
		<tr>
			<td><%=beer.getB_id()%></td>
			<td><%=beer.getB_code()%></td>
			<td><%=beer.getB_category()%></td>
			<td><%=beer.getB_name()%></td>
			<td><%=beer.getB_country()%></td>
			<td><%=beer.getB_price()%></td>
			<td><%=beer.getB_alcohol()%></td>
			<td><%=beer.getB_content()%></td>
			<td><%=beer.getB_like()%></td>
			<td><%=beer.getB_dislike()%></td>
<%-- 			<td><%=beer.getB_image()%></td> --%>
		</tr>
<%
	}
%>	
	</tbody>
</table>

<br><a href="<%=rootDir%>/index.jsp">홈으로 돌아가기</a>
</body>
</html>