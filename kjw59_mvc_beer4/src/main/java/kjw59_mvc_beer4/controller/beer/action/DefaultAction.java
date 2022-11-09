package kjw59_mvc_beer4.controller.beer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kjw59_mvc_beer4.controller.beer.Action;
import kjw59_mvc_beer4.controller.beer.ActionForward;

public class DefaultAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("/com/yju/2wda/team1/view/etc/error.jsp");
		
		return forward;
	}
}
