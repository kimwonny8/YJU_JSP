<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/globalData.jsp" %>
<%@ page import="kjw59_mvc_beer2.model.beer.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String actionType = request.getParameter("actionType");

	BeerDTO beer;
	BeerDAO beerDAO;
	ArrayList<BeerDTO> beerList;
	
	BeerPageInfoVO bpiVO;
	
	if(session.getAttribute("beerPageInfoVO")==null){
		bpiVO=new BeerPageInfoVO();
		session.setAttribute("beerPageInfoVO", bpiVO);
	}
	else {
		bpiVO = (BeerPageInfoVO)session.getAttribute("beerPageInfoVO");
	}
	
	beerDAO=new BeerDAO();
/* 	beerDAO.jdbcDriverLoad(); */
	
	boolean result;
	String msg="실행결과: ";
	
	String displayRecordCnt;
	int drc;
	
	String currentPageNo;
	int cpn;

	switch(actionType){
		case "C": // 기본데이터 입력 C-모듈			
			beer=new BeerDTO();
			
			beer.setB_code(request.getParameter("b_code"));
			beer.setB_category(request.getParameter("b_category"));
			beer.setB_name(request.getParameter("b_name"));
			beer.setB_country(request.getParameter("b_country"));
			beer.setB_price(Integer.parseInt(request.getParameter("b_price")));
			beer.setB_alcohol(request.getParameter("b_alcohol"));
			beer.setB_content(request.getParameter("b_content"));
			beer.setB_like(0);
			beer.setB_dislike(0);
			beer.setB_image("baseImage.jpg");
			
			result = beerDAO.insertBeer(beer);
			
			if(result==true){
				pageContext.forward("/index.jsp");
			}
			else {
				pageContext.forward("/com/yju/2wda/team1/view/etc/error.jsp");
			}
			break;
		
		case "R": // 페이징 기능 없는 R-모듈
			//beerList = beerDAO.getBeerList();
			beerList = beerDAO.getBeerListForPage(bpiVO);
			request.setAttribute("beerList", beerList);
			pageContext.forward("/com/yju/2wda/team1/view/beer/beer_r.jsp");
			
			break;
			
		case "R4": // 페이징 기능 포함 R-모듈
			currentPageNo = request.getParameter("currentPageNo");
			cpn = (currentPageNo == null)? 0 : Integer.parseInt(currentPageNo);
			
			bpiVO.setCurrentPageNo(cpn);
			bpiVO.adjPageInfo();
			
			beerList = beerDAO.getBeerListForPage(bpiVO);
			
			request.setAttribute("beerList", beerList);
			pageContext.forward("/com/yju/2wda/team1/view/beer/beer_r4.jsp");
			
			break;
		
		case "R_DRC": // 페이지당 디스플레이 레코드 갯수 변경 처리
			displayRecordCnt = request.getParameter("displayRecordCnt");
			drc = (displayRecordCnt == null)? 10 : Integer.parseInt(displayRecordCnt);
			
			bpiVO.setLimitCnt(drc);
			bpiVO.setCurrentPageNo(0);
			bpiVO.adjPageInfo();
			
			pageContext.forward("/index.jsp");
			
			break;
		
		case "D_ID": // 조건에 해당하는 레코드 삭제 처리
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			
			result = beerDAO.deleteBeer(b_id);
			
			if(result==true){
				pageContext.forward("/com/yju/2wda/team1/controller/beer/BeerController.jsp?actionType=D");
			}
			else {
				pageContext.forward("/com/yju/2wda/team1/view/etc/error.jsp");
			}
			break;
			
		case "D": // 페이지당 디스플레이 레코드 갯수 출력 및 삭제 처리
			currentPageNo = request.getParameter("currentPageNo");
			cpn = (currentPageNo == null)? 0 : Integer.parseInt(currentPageNo);
			
			bpiVO.setCurrentPageNo(cpn);
			bpiVO.adjPageInfo();
			
			beerList = beerDAO.getBeerListForPage(bpiVO);
			
			request.setAttribute("beerList", beerList);
			pageContext.forward("/com/yju/2wda/team1/view/beer/beer_d.jsp");
			
			break;
	
		case "U": // 페이지당 디스플레이 레코드 갯수 출력 및 수정 처리
			currentPageNo = request.getParameter("currentPageNo");
			cpn = (currentPageNo == null)? 0 : Integer.parseInt(currentPageNo);
			
			bpiVO.setCurrentPageNo(cpn);
			bpiVO.adjPageInfo();
			
			beerList = beerDAO.getBeerListForPage(bpiVO);
			
			request.setAttribute("beerList", beerList);
			pageContext.forward("/com/yju/2wda/team1/view/beer/beer_u.jsp");
			
			break;
			
		case "U2":
			b_id = Integer.parseInt(request.getParameter("b_id"));
			beer = beerDAO.getBeer(b_id);
			
			request.setAttribute("beer", beer);
			pageContext.forward("/com/yju/2wda/team1/view/beer/beer_u2.jsp");
			
			break;
			
		case "U_ID":	
			beer = new BeerDTO();	

			beer.setB_id(Integer.parseInt(request.getParameter("b_id")));
			beer.setB_code(request.getParameter("b_code"));
			beer.setB_category(request.getParameter("b_category"));
			beer.setB_name(request.getParameter("b_name"));
			beer.setB_country(request.getParameter("b_country"));
			beer.setB_price(Integer.parseInt(request.getParameter("b_price")));
			beer.setB_alcohol(request.getParameter("b_alcohol"));
			beer.setB_content(request.getParameter("b_content"));
			beer.setB_like(Integer.parseInt(request.getParameter("b_like")));
			beer.setB_dislike(Integer.parseInt(request.getParameter("b_dislike")));
			beer.setB_image(request.getParameter("b_image"));
			
			result = beerDAO.updateBeer(beer);
			
			if(result==true){
				pageContext.forward("/index.jsp");
			}
			else {
				pageContext.forward("/com/yju/2wda/team1/view/etc/error.jsp");
			}
			break;
	}
%>

</body>
</html>