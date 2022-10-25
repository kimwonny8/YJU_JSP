<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>파일 업로드/다운로드 테스트 페이지 with COS</h1>
<h2>싱글 파일 업로드 폼</h2>
<hr>

<p>
<form action="fileUpload.jsp" method="post" enctype="multipart/form-data">
<p>작성자 : <input type="text" name ="userName"></p>
<p>파일명 : <input type="file" name ="file01"></p>
<p><input type = "submit" value ="upload"></p>

</form>

</body>
</html>