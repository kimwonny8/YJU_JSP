package kjw59_mvc_beer4.controller.beer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kjw59_mvc_beer4.controller.beer.Action;
import kjw59_mvc_beer4.controller.beer.ActionForward;
import kjw59_mvc_beer4.model.beer.BeerDAO;
import kjw59_mvc_beer4.model.beer.BeerDTO;

public class UpdateBeerDisplayAction implements Action {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		int b_id = Integer.parseInt(request.getParameter("b_id"));
		
		BeerDAO beerDAO = new BeerDAO();
		BeerDTO beer = new BeerDTO();
		beer = beerDAO.getBeer(b_id);
		
		request.setAttribute("beer", beer);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		forward.setPath("/com/yju/2wda/team1/view/beer/beer_u2.jsp");
		
		return forward;
	}
}