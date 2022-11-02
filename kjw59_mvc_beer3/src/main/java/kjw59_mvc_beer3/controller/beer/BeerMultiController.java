package kjw59_mvc_beer3.controller.beer;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kjw59_mvc_beer3.model.beer.*;

public class BeerMultiController extends HttpServlet implements Servlet{

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		HttpSession session = request.getSession();
		
		// 파일관련 
		request.setCharacterEncoding("utf-8");
		String imgDirPath = "D:\\Dev\\kjw59_mvc_beer3\\src\\main\\webapp\\com\\yju\\2wda\\team1\\image\\";
		String thumbImageDir = "D:\\Dev\\kjw59_mvc_beer3\\src\\main\\webapp\\com\\yju\\2wda\\team1\\image\\thumb\\";

		int maxSize = 1024 * 1024 * 5; //최대 5G까지 가능 1024 => 1KB 

		MultipartRequest multi = new MultipartRequest(request, imgDirPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
		
		Enumeration<?> files = multi.getFileNames();

		String element = "";
		String i_file_name = "";
		String i_original_name = "";
		String i_file_type = "";
		int i_file_size = 0;
		
		long length = 0;

		if (files.hasMoreElements()) {
			element = (String) files.nextElement();
			i_file_name = multi.getFilesystemName(element);
			i_original_name = multi.getOriginalFileName(element);
			i_file_type = multi.getContentType(element);
			i_file_size = (int) multi.getFile(element).length();
		}

		String actionType = multi.getParameter("actionType");

		BeerDTO beer;
		BeerImageDTO beerImage;
		
		BeerDAO beerDAO;
		BeerImageDAO beerImageDAO;
		
		ArrayList<BeerDTO> beerList;

		beerDAO=new BeerDAO();
		beerImageDAO=new BeerImageDAO();
		
		boolean result;

		switch(actionType){
		case "C": // 기본데이터 입력 C-모듈
			beerDAO=new BeerDAO();
			beer = new BeerDTO();
			
			String b_code=multi.getParameter("b_code");
			
			beer.setB_code(b_code);
			beer.setB_category(multi.getParameter("b_category"));
			beer.setB_name(multi.getParameter("b_name"));
			beer.setB_country(multi.getParameter("b_country"));
			beer.setB_price(Integer.parseInt(multi.getParameter("b_price")));
			beer.setB_alcohol(multi.getParameter("b_alcohol"));
			beer.setB_content(multi.getParameter("b_content"));
			
			// beer에 추가
			beerDAO.insertBeer(beer);
			
			// beer에서 b_id 받아서 beerImage 추가
			int b_id=0;
			try {
				b_id = beerDAO.selectB_id(b_code);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			beerImageDAO=new BeerImageDAO();
			// 이미지 관련
			beerImage=new BeerImageDTO();
			
			beerImage.setI_file_name(i_file_name);
			beerImage.setI_original_name(i_original_name);
			beerImage.setI_thumbnail_name("sm_"+i_original_name);
			beerImage.setI_file_type(i_file_type);
			beerImage.setI_file_size(i_file_size);
			beerImage.setB_id(b_id);

			result = beerImageDAO.insertBeer(beerImage);
			
			if(result==true){
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else {
				request.getRequestDispatcher("/com/yju/2wda/team1/view/etc/error.jsp").forward(request, response);
			}
			break;
			
		/*
		 * case "U_ID": beer = new BeerDTO();
		 * 
		 * beer.setB_id(Integer.parseInt(request.getParameter("b_id")));
		 * beer.setB_code(request.getParameter("b_code"));
		 * beer.setB_category(request.getParameter("b_category"));
		 * beer.setB_name(request.getParameter("b_name"));
		 * beer.setB_country(request.getParameter("b_country"));
		 * beer.setB_price(Integer.parseInt(request.getParameter("b_price")));
		 * beer.setB_alcohol(request.getParameter("b_alcohol"));
		 * beer.setB_content(request.getParameter("b_content"));
		 * beer.setB_like(Integer.parseInt(request.getParameter("b_like")));
		 * beer.setB_dislike(Integer.parseInt(request.getParameter("b_dislike")));
		 * 
		 * result = beerDAO.updateBeer(beer);
		 * 
		 * if(result==true){ request.getRequestDispatcher("/index.jsp").forward(request,
		 * response); } else {
		 * request.getRequestDispatcher("/com/yju/2wda/team1/view/etc/error.jsp").
		 * forward(request, response); } break;
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
