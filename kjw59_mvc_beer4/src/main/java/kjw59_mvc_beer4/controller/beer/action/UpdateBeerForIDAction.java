package kjw59_mvc_beer4.controller.beer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kjw59_mvc_beer4.controller.beer.Action;
import kjw59_mvc_beer4.controller.beer.ActionForward;
import kjw59_mvc_beer4.model.beer.*;
public class UpdateBeerForIDAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		BeerDTO beer = new BeerDTO();
		
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
		
		BeerDAO beerDAO = new BeerDAO();
		boolean result = beerDAO.updateBeer(beer);
	
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		if(result == true) {
			forward.setPath("/index.jsp");
		}
		else {
			forward.setPath("/com/yju/2wda/team1/view/etc/error.jsp");
		}
		
		return forward;
	}
}
