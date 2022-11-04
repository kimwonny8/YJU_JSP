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
<title>마이쇼핑몰(KJW59) - 맥주자료삭제(D)</title>
</head>
<body>
<h1>마이쇼핑몰(KJW59) - 맥주자료삭제(D)</h1>
<hr>
<%
	BeerSelectInfoVO selectVO;
	ArrayList<BeerSelectInfoVO> beerList;
	BeerPageInfoVO bpiVO;

	bpiVO = (BeerPageInfoVO)session.getAttribute("beerPageInfoVO");
	beerList = (ArrayList<BeerSelectInfoVO>)request.getAttribute("beerList");
	
	int currentPageNo = bpiVO.getCurrentPageNo();
%>
<h2>현재 DISPLAY RECORDS NUMBER : <%=bpiVO.getLimitCnt() %></h2>
<hr>
<br>
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
			<td><a href="./BeerController.be?actionType=D_ID&b_id=<%=selectVO.getB_id()%>">DELETE</a></td>
		</tr>
<%
	}
%>	
	</tbody>
</table>

<a href="./BeerController.be?actionType=D&currentPageNo=0">[FIRST]</a>
<%
	if(currentPageNo > 0){
%>
	<a href="./BeerController.be?actionType=D&currentPageNo=<%=(currentPageNo-1)%>">[PRE]</a>
<%
	} else{
%>
	[PRE]
<%
	}
	for(int i=bpiVO.getStartPageNo(); i<bpiVO.getEndPageNo(); i++){
		if(i==currentPageNo) {
%>
			[<%=(i+1)%>]
<%
		} else {
%>
			<a href="./BeerController.be?actionType=D&currentPageNo=<%=i%>">[<%=(i+1)%>]</a>
<%			
		}
	}
%>
<%
	if(currentPageNo < bpiVO.getPageCnt()-1){
%>
	<a href="./BeerController.be?actionType=D&currentPageNo=<%=(currentPageNo+1)%>">[NXT]</a>
<%
	} else {
%>	
		[NXT]
<% 
	}
%>
<a href="./BeerController.be?actionType=D&currentPageNo=<%=(bpiVO.getPageCnt()-1)%>">[END]</a>

<br><a href="<%=rootDir%>/index.jsp">홈으로 돌아가기</a>
</body>
</html>