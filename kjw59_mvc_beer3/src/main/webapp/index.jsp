<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/globalData.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>마이쇼핑몰(KJW59) ver0.3</h1>
<hr>
<h2>맥주샵 시스템 - CRUD with MVC #3</h2>
<h2>MVC패턴적용,DAO,DTO,VO활용,DBCP/서블릿/스프링 적용</h2>
<h3>JNDI, DBCP 구성 및 활용</h3>

<ul>
<li><a href="<%=beerViewDir%>/beer_r_drc.jsp">출력레코드갯수조정(R_DRC)</a>
<li><a href="<%=beerViewDir%>/beer_c.jsp">맥주정보입력(C)</a>
<li><a href="./BeerController.be?searchType=전체&actionType=R">맥주정보조회(R,부분조회포함,페이징기능X)</a>
<li><a href="./BeerController.be?actionType=R4">맥주정보조회(R4,MVC패턴적용)</a>
<li><a href="./BeerController.be?actionType=U">맥주정보조회(U,MVC패턴적용)</a>
<li><a href="./BeerController.be?actionType=D">맥주정보조회(D,MVC패턴적용)</a>
</ul>
<p>
<br>JNDI(Java Naming and Directory Interface) 구성 및 활용
<br>DBCP(Database Connection Pool) 구성 및 테스트
<br>commons-collections.jar, commons-dbcp.jar, commons-pool.jar
<br>web.xml, context.xml

</body>
</html>