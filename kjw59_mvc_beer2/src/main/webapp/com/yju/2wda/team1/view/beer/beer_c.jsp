<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/globalData.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이쇼핑몰(KJW59) - 맥주자료입력(C)</title>
</head>
<body>

<h1>마이쇼핑몰(KJW59) - 맥주자료입력(C)</h1>

<form method="post" action="<%=beerContDir%>/BeerController.jsp" enctype="multipart/form-data">
	<br>맥주코드 : <input type="text" name="b_code" size="30">
	<br>맥주종류 : <input type="text" name="b_category" size="30">
	<br>맥주이름 : <input type="text" name="b_name" size="30">
	<br>맥주국가 : <input type="text" name="b_country" size="30">
	<br>맥주가격 : <input type="text" name="b_price" size="30">
	<br>맥주알콜도수 : <input type="text" name="b_alcohol" size="30">
	<br>맥주설명 : <input type="text" name="b_content" size="30">
	<br>맥주사진 : <input type="file" name="b_image" size="30">
	<br><input type="hidden" name="actionType" value="C">
	<br><input type="submit" value="저장">
</form>

<br><a href="<%=rootDir%>/index.jsp">홈으로 돌아가기</a>

</body>
</html>