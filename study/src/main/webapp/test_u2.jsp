<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서적관리시스템 - 자료수정</title>
</head>
<body>
<h1>서적관리시스템 - 자료수정(U2)</h1>
<hr>
<% int book_id=Integer.parseInt(request.getParameter("book_id"));
String title=request.getParameter("title");
String publisher=request.getParameter("publisher");
String year=request.getParameter("year");
int price=Integer.parseInt(request.getParameter("price"));

%>
<form method="post" action="./test_dao.jsp">
<br>서적번호(수정불가) : <input type="text" name="book_id" value="<%=book_id%>" readonly>
<br>서적명 : <input type="text" name="title" size="30" value="<%=title%>">
<br>출판사 : <input type="text" name="publisher" size="30" value="<%=publisher%>">
<br>출판년도 : <input type="text" name="year" size="30" value="<%=year%>">
<br>가격 : <input type="text" name="price" size="30" value="<%=price%>">
<br><input type="hidden" name="actionType" value="U">
<br><input type="submit" value="수정">
</form>
<br><a href="./index.jsp">홈으로 돌아가기</a>
</body>
</html>
