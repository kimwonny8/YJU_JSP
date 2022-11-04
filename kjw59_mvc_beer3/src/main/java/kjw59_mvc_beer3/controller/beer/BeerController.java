package kjw59_mvc_beer3.controller.beer;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.*;
import kjw59_mvc_beer3.model.beer.*;

public class BeerController extends HttpServlet implements Servlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		HttpSession session = request.getSession();
		
		request.setCharacterEncoding("utf-8");
		String actionType = request.getParameter("actionType");

		BeerDTO beer;
		BeerDAO beerDAO;
		ArrayList<BeerSelectInfoVO> beerList;
		
		BeerPageInfoVO bpiVO;
		BeerSelectInfoVO selectVO;
		
		if(session.getAttribute("beerPageInfoVO")==null){
			bpiVO=new BeerPageInfoVO();
			session.setAttribute("beerPageInfoVO", bpiVO);
		}
		else {
			bpiVO = (BeerPageInfoVO)session.getAttribute("beerPageInfoVO");
		}

		beerDAO=new BeerDAO();
		
		boolean result;
		String displayRecordCnt;
		int drc;
		String currentPageNo;
		int cpn;
		
		
		switch(actionType){
		
		case "R": // 페이징 기능 없는 R-모듈
			beerList = beerDAO.getBeerList();

			request.setAttribute("beerList", beerList);
			request.getRequestDispatcher("/com/yju/2wda/team1/view/beer/beer_r.jsp").forward(request, response);
			break;
		
		case "R4": // 페이징 기능 포함 R-모듈
			currentPageNo = request.getParameter("currentPageNo");
			cpn = (currentPageNo == null)? 0 : Integer.parseInt(currentPageNo);
			
			bpiVO.setCurrentPageNo(cpn);
			bpiVO.adjPageInfo();
			
			beerList = beerDAO.getBeerListForPage(bpiVO);
			
			request.setAttribute("beerList", beerList);
			request.getRequestDispatcher("/com/yju/2wda/team1/view/beer/beer_r4.jsp").forward(request, response);
			
			break;
		
		case "R_DRC": // 페이지당 디스플레이 레코드 갯수 변경 처리
			displayRecordCnt = request.getParameter("displayRecordCnt");
			drc = (displayRecordCnt == null)? 10 : Integer.parseInt(displayRecordCnt);
			
			bpiVO.setLimitCnt(drc);
			bpiVO.setCurrentPageNo(0);
			bpiVO.adjPageInfo();
			
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			
			break;
		/*
		case "D_ID": // 조건에 해당하는 레코드 삭제 처리
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			
			result = beerDAO.deleteBeer(b_id);
			
			if(result==true){
				request.getRequestDispatcher("/com/yju/2wda/team1/controller/beer/BeerController.jsp?actionType=D").forward(request, response);
			}
			else {
				request.getRequestDispatcher("/com/yju/2wda/team1/view/etc/error.jsp").forward(request, response);
			}
			break;
			
		case "D": // 페이지당 디스플레이 레코드 갯수 출력 및 삭제 처리
			currentPageNo = request.getParameter("currentPageNo");
			cpn = (currentPageNo == null)? 0 : Integer.parseInt(currentPageNo);
			
			bpiVO.setCurrentPageNo(cpn);
			bpiVO.adjPageInfo();
			
			beerList = beerDAO.getBeerListForPage(bpiVO);
			
			request.setAttribute("beerList", beerList);
			request.getRequestDispatcher("/com/yju/2wda/team1/view/beer/beer_d.jsp").forward(request, response);
			
			break;
	
		case "U": // 페이지당 디스플레이 레코드 갯수 출력 및 수정 처리
			currentPageNo = request.getParameter("currentPageNo");
			cpn = (currentPageNo == null)? 0 : Integer.parseInt(currentPageNo);
			
			bpiVO.setCurrentPageNo(cpn);
			bpiVO.adjPageInfo();
			
			beerList = beerDAO.getBeerListForPage(bpiVO);
			
			request.setAttribute("beerList", beerList);
			request.getRequestDispatcher("/com/yju/2wda/team1/view/beer/beer_u.jsp").forward(request, response);
			
			break;
				
		case "U2":
			b_id = Integer.parseInt(request.getParameter("b_id"));
			beer = beerDAO.getBeer(b_id);
			
			request.setAttribute("beer", beer);
			request.getRequestDispatcher("/com/yju/2wda/team1/view/beer/beer_u2.jsp").forward(request, response);
			
			break;
		*/
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response);
	}
}