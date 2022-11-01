<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/globalData.jsp"%>
<%@ page import="kjw59_mvc_beer2.model.beer.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String imgDirPath = "D:\\Dev\\kjw59_mvc_beer2\\src\\main\\webapp\\com\\yju\\2wda\\team1\\image\\";
	String thumbImageDir = "D:\\Dev\\kjw59_mvc_beer2\\src\\main\\webapp\\com\\yju\\2wda\\team1\\image\\thumb\\";

	int maxSize = 1024 * 1024 * 5; //최대 5G까지 가능 1024 => 1KB 

	MultipartRequest multi = new MultipartRequest(request, imgDirPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	String actionType = multi.getParameter("actionType");

	request.setCharacterEncoding("utf-8");

	BeerDTO beer;
	BeerDAO beerDAO;
	BeerImageDAO beerImageDAO;
	ArrayList<BeerDTO> beerList;

	BeerPageInfoVO bpiVO;

	if (session.getAttribute("beerPageInfoVO") == null) {
		bpiVO = new BeerPageInfoVO();
		session.setAttribute("beerPageInfoVO", bpiVO);
	} else {
		bpiVO = (BeerPageInfoVO) session.getAttribute("beerPageInfoVO");
	}

	boolean result;
	String msg = "실행결과: ";

	String displayRecordCnt;
	int drc;

	String currentPageNo;
	int cpn;

	switch (actionType) {
	case "C": // 기본데이터 입력 C-모듈
		beer = new BeerDTO();
		beerDAO = new BeerDAO();
		beerImageDAO = new BeerImageDAO();
		
		String pricetmp = multi.getParameter("b_price");
		int price;
		try {
			price = Integer.parseInt(pricetmp);
		} catch (Exception e) {
			price = 0;
		}

		beer.setB_code(multi.getParameter("b_code"));
		beer.setB_category(multi.getParameter("b_category"));
		beer.setB_name(multi.getParameter("b_name"));
		beer.setB_country(multi.getParameter("b_country"));
		beer.setB_price(price);
		beer.setB_alcohol(multi.getParameter("b_alcohol"));
		beer.setB_content(multi.getParameter("b_content"));
		beer.setB_like(0);
		beer.setB_dislike(0);

		result = beerDAO.insertBeer(beer);
		
		// 사진 파일 데이터 -> 받아올 사진 변수 추가해야함
		Enumeration<?> files = multi.getFileNames();
		String element = "";
		String filesystemName = "";
		String originalFileName = "";
		String contentType = "";

		long length = 0;

		if (files.hasMoreElements()) {
			element = (String) files.nextElement();
			filesystemName = multi.getFilesystemName(element);
			originalFileName = multi.getOriginalFileName(element);
			contentType = multi.getContentType(element);
			length = multi.getFile(element).length();
		}

//		new BeerImageadd().createImage(imgDirPath, thumbImageDir, originalFileName, 5);

		if (result == true) {
			pageContext.forward("/index.jsp");
		} else {
			pageContext.forward("/com/yju/2wda/team1/view/etc/error.jsp");
		}
		break;

	case "U_ID":
		beer = new BeerDTO();
		beerDAO = new BeerDAO();
		beerImageDAO = new BeerImageDAO();
		
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

		result = beerImageDAO.updateBeer(beer);

		if (result == true) {
			pageContext.forward("/index.jsp");
		} else {
			pageContext.forward("/com/yju/2wda/team1/view/etc/error.jsp");
		}
		break;
	}
	%>

</body>
</html>