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
<title>마이쇼핑몰(KJW59) - 맥주자료수정(U2)</title>
</head>
<body>
	<h1>마이쇼핑몰(KJW59) - 맥주자료수정(U2)</h1>
	<hr>
	<%
	BeerDTO beer = (BeerDTO)request.getAttribute("beer");
	%>
	
	<form method="post" action="./updateBeerDisplay.be">
		<br>맥주번호(수정불가) : <input type="text" name="b_id" value="<%=beer.getB_id()%>" readonly>
		<br>맥주코드 : <input type="text" name="b_code" value="<%=beer.getB_code()%>" size="30">
		<br>맥주종류 : <input type="text" name="b_category" value="<%=beer.getB_category()%>" size="30">
		<br>맥주이름 : <input type="text" name="b_name" value="<%=beer.getB_name()%>" size="30">
		<br>맥주국가 : <input type="text" name="b_country" value="<%=beer.getB_country()%>" size="30">
		<br>맥주가격 : <input type="text" name="b_price" value="<%=beer.getB_price()%>" size="30">
		<br>맥주알콜도수 : <input type="text" name="b_alcohol" value="<%=beer.getB_alcohol()%>" size="30">
		<br>맥주설명 : <input type="text" name="b_content" value="<%=beer.getB_content()%>" size="30">
		<br>좋아요 : <input type="text" name="b_like" value="<%=beer.getB_like()%>" size="30">
		<br>싫어요 : <input type="text" name="b_dislike" value="<%=beer.getB_dislike()%>" size="30">
		<br>맥주사진 : <input type="text" name="b_image" value="<%=beer.getB_image()%>" size="30">
		<br><input type="hidden" name="actionType" value="U_ID">
		<br><input type="submit" value="저장">
	</form>
	
	<br><a href="<%=rootDir%>/index.jsp">홈으로 돌아가기</a>
</body>
</html>