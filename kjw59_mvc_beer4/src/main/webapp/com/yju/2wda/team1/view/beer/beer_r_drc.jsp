<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/globalData.jsp"%>
<%@ page import="kjw59_mvc_beer4.model.beer.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이쇼핑몰(KJW59) - 맥주자료조회 레코드 카운트 설정(R_DRC)</title>
</head>
<body>
<h1>마이쇼핑몰(KJW59) - 맥주자료조회 레코드 카운트 설정(R_DRC)</h1>
<hr>
	<%
	BeerPageInfoVO bpiVO;
	bpiVO = (BeerPageInfoVO) session.getAttribute("beerPageInfoVO");
	int limitCnt;

	if (bpiVO == null)
		limitCnt = 10;
	else
		limitCnt = bpiVO.getLimitCnt();
	%>

	<h2>현재 DISPLAY RECORDS NUMBER : <%=limitCnt %></h2>
	<hr>
	<form method="post" action="<%=beerContDir%>/BeerController.be?actionType=R_DRC">
		디스플레이 레코드 수 변경 :
		<select name="displayRecordCnt">
			<option SELECTED value="10">10</option>
			<option value="20">20</option>
			<option value="50">50</option>
			<option value="100">100</option>
		</select>
		<input type="hidden" name="currentPageNo" value="0">
		<input type="submit" value="확인">
	</form>
	
	<br><a href="<%=rootDir%>/index.jsp">홈으로 돌아가기</a>
</body>
</html>