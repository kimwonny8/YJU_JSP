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
<h2>전체보기(부분조회 포함, 페이징기능 미포함)</h2>

<form method="post" action="./BeerController.be">
	종류별 검색: 
	<select name="searchType">
		<option value="전체" selected>전체</option>
		<option value="종류">종류</option>
		<option value="국가">원산지</option>
		<option value="이름">이름</option>
	</select>
	<input type="text" name="searchContent">
	<input type="hidden" name="actionType" value="R">
	<input type="submit" value="검색">
</form>

<%
	BeerSelectInfoVO selectVO;
	ArrayList<BeerSelectInfoVO> beerList;
	
	String thumbImageDir = "/kjw59_mvc_beer3/com/yju/2wda/team1/image/thumb/";
	
	beerList = (ArrayList<BeerSelectInfoVO>)request.getAttribute("beerList");
	
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
		selectVO = beerList.get(i);
		String i_file_name = selectVO.getI_file_name();
		String thumbsnail=thumbImageDir+"sm_"+i_file_name;
%>	
		<tr>
			<td><%=selectVO.getB_id()%></td>
			<td><%=selectVO.getB_code()%></td>
			<td><%=selectVO.getB_category()%></td>
			<td><%=selectVO.getB_name()%></td>
			<td><%=selectVO.getB_country()%></td>
			<td><%=selectVO.getB_price()%></td>
			<td><%=selectVO.getB_alcohol()%></td>
			<td><%=selectVO.getB_content()%></td>
			<td><%=selectVO.getB_like()%></td>
			<td><%=selectVO.getB_dislike()%></td>
			<td><%=selectVO.getI_file_name()%></td>
 			<td><img src="<%=thumbsnail%>" width="100"></td> 
		</tr>
<%
	}
%>	
	</tbody>
</table>

<br><a href="<%=rootDir%>/index.jsp">홈으로 돌아가기</a>
</body>
</html>