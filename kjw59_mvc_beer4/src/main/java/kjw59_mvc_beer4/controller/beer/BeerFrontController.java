package kjw59_mvc_beer4.controller.beer;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.*;

import kjw59_mvc_beer4.controller.beer.*;
import kjw59_mvc_beer4.controller.beer.action.*;
import kjw59_mvc_beer4.model.beer.*;

public class BeerFrontController extends HttpServlet implements Servlet {
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		command = command.substring(command.lastIndexOf("/"));
		
		BeerPageInfoVO bpiVO;
		HttpSession session = request.getSession();
		
		if (session.getAttribute("beerPageInfoVO") == null) {
			bpiVO = new BeerPageInfoVO();
			session.setAttribute("beerPageInfoVO", bpiVO);
		} 
		else {
			bpiVO = (BeerPageInfoVO)session.getAttribute("beerPageInfoVO");
		}
		
		ActionForward forward = null;
		Action action = null;
		
		System.out.println("command = "+command);
		
		switch(command) {
		
		case "/insertBeer.be":
			action = new InsertBeerAction();
			break;
			
		case "/getBeerList.be":
			action = new GetBeerListAction();
			break;
			
		case "/getBeerListForPage.be":
			action = new GetBeerListForPageAction();
			break;	
			
		case "/adjustBPI.be":
			action = new AdjustBPIAction();
			break;
			
		case "/deleteBeerForID.be":
			action = new DeleteBeerForIDAction();
			break;
			
		case "/updateBeerListDisplay.be":
			action = new UpdateBeerListDisplayAction();
			break;	
			
		case "/updateBeerDisplay.be":
			action = new UpdateBeerDisplayAction();
			break;
			
		case "/updateBeerForID.be":
			action = new UpdateBeerForIDAction();
			break;	
			
		default:
			action = new DefaultAction();
			break;
		}
		
		try {
			forward = action.execute(request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}
			else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
		
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request, response);
	}
}