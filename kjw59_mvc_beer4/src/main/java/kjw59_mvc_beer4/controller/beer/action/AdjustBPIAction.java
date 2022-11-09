package kjw59_mvc_beer4.controller.beer.action;

import javax.servlet.http.*;
import java.util.*;
import kjw59_mvc_beer4.controller.beer.Action;
import kjw59_mvc_beer4.controller.beer.ActionForward;
import kjw59_mvc_beer4.model.beer.*;

public class AdjustBPIAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String displayRecordCnt = request.getParameter("displayRecordCnt");
		int drc = (displayRecordCnt == null)? 10:Integer.parseInt(displayRecordCnt);
		
		HttpSession session = request.getSession();
		BeerPageInfoVO bpiVO = (BeerPageInfoVO)session.getAttribute("beerPageInfoVO");
		
		bpiVO.setLimitCnt(drc);
		bpiVO.setCurrentPageNo(0);
		bpiVO.adjPageInfo();
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/index.jsp");
		
		return forward;
	}
}
