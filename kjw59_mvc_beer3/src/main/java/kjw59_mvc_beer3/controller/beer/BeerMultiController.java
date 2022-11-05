package kjw59_mvc_beer3.controller.beer;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.imageio.ImageIO;
import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kjw59_mvc_beer3.model.beer.BeerDAO;
import kjw59_mvc_beer3.model.beer.BeerDTO;
import kjw59_mvc_beer3.model.beer.BeerImageDAO;
import kjw59_mvc_beer3.model.beer.BeerImageDTO;

public class BeerMultiController extends HttpServlet implements Servlet {

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

		int maxSize = 1024 * 1024 * 5; // 최대 5G까지 가능 1024 => 1KB

		MultipartRequest multi = new MultipartRequest(request, imgDirPath, maxSize, "utf-8",
				new DefaultFileRenamePolicy());

		Enumeration<?> files = multi.getFileNames();

		String element = "";
		String i_file_name = "";
		String i_original_name = "";
		String i_file_type = "";

		long length = 0;

		if (files.hasMoreElements()) {
			element = (String) files.nextElement();
			i_file_name = multi.getFilesystemName(element);
			i_original_name = multi.getOriginalFileName(element);
			i_file_type = multi.getContentType(element);
		}

		String actionType = multi.getParameter("actionType");

		BeerDTO beer;
		BeerImageDTO beerImage;

		BeerDAO beerDAO;
		BeerImageDAO beerImageDAO;

		ArrayList<BeerDTO> beerList;

		beerDAO = new BeerDAO();
		beerImageDAO = new BeerImageDAO();

		boolean result;

		switch (actionType) {
		case "C": // 기본데이터 입력 C-모듈
			beer = new BeerDTO();

			// 가격이 숫자가 아닐때 오류처리
			String pricetmp = multi.getParameter("b_price");
			int b_price;
			try {
				b_price = Integer.parseInt(pricetmp);
			} catch (Exception e) {
				b_price = 0;
			}

			beer.setB_category(multi.getParameter("b_category"));
			beer.setB_name(multi.getParameter("b_name"));
			beer.setB_country(multi.getParameter("b_country"));
			beer.setB_price(b_price);
			beer.setB_alcohol(multi.getParameter("b_alcohol"));
			beer.setB_content(multi.getParameter("b_content"));

			// 코드 자동생성 만드는 과정
			beerDAO = new BeerDAO();
			String code = beerDAO.selectCategory_code(beer); // 종류코드 조회
			beerDAO = new BeerDAO();
			String code2 = beerDAO.selectCountry_code(beer); // 국가코드 조회
			String b_code = "BE" + code + code2;
			beerDAO = new BeerDAO();
			String code3 = beerDAO.makeB_code(b_code); // 같은 종류, 국가 코드찾고 가장 큰 일련번호 확인

			// 뒤에 4개 잘라서 일련번호 만들기
			String tmp = code3.substring(7);
			int tmp2 = Integer.parseInt(tmp) + 1;
			if (tmp2 < 10) 	b_code="BE"+code+code2+"000"+ tmp2;
			else if (tmp2 < 100) b_code="BE"+code+code2+"00"+ tmp2;
			else if (tmp2 < 1000) b_code="BE"+code+code2+"0"+ tmp2;
			else b_code="BE"+code+code2+tmp2;
			
			System.out.println("만들 코드: " + b_code);
			beer.setB_code(b_code);

			// beer에 추가
			beerDAO = new BeerDAO();
			boolean test = beerDAO.insertBeer(beer);
			System.out.println("beer insert 결과: " + test);

			// 이미지 관련
			beerImageDAO = new BeerImageDAO();
			beerImage = new BeerImageDTO();
			
			int b_id = beer.getB_id();
			beerImage.setI_file_name(i_file_name);
			beerImage.setI_original_name(i_original_name);
			beerImage.setI_thumbnail_name("sm_" + i_original_name);
			beerImage.setI_file_type(i_file_type);
			beerImage.setB_id(b_id);

			result = beerImageDAO.insertBeer(beerImage);

			beerImageDAO.createImageThumb(imgDirPath, thumbImageDir, i_original_name, 5);

			if (result == true) {
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("/com/yju/2wda/team1/view/etc/error.jsp").forward(request, response);
			}
			break;

		case "U_ID":
			beer = new BeerDTO();

			// 가격이 숫자가 아닐때 오류처리
			pricetmp = multi.getParameter("b_price");
			try {
				b_price = Integer.parseInt(pricetmp);
			} catch (Exception e) {
				b_price = 0;
			}
			
			beer.setB_id(Integer.parseInt(multi.getParameter("b_id")));
			beer.setB_category(multi.getParameter("b_category"));
			beer.setB_name(multi.getParameter("b_name"));
			beer.setB_country(multi.getParameter("b_country"));
			beer.setB_price(b_price);
			beer.setB_alcohol(multi.getParameter("b_alcohol"));
			beer.setB_content(multi.getParameter("b_content"));

			// 코드 자동생성 만드는 과정
			beerDAO = new BeerDAO();
			code = beerDAO.selectCategory_code(beer); // 종류코드 조회
			beerDAO = new BeerDAO();
			code2 = beerDAO.selectCountry_code(beer); // 국가코드 조회
			
			b_code = "BE" + code + code2;
			beerDAO = new BeerDAO();
			code3 = beerDAO.makeB_code(b_code); // 같은 종류, 국가 코드찾고 가장 큰 일련번호 확인

			// 뒤에 4개 잘라서 일련번호 만들기
			tmp = code3.substring(7);
			tmp2 = Integer.parseInt(tmp)+1;
			if (tmp2 < 10) 	b_code="BE"+code+code2+"000"+ tmp2;
			else if (tmp2 < 100) b_code="BE"+code+code2+"00"+ tmp2;
			else if (tmp2 < 1000) b_code="BE"+code+code2+"0"+ tmp2;
			else b_code="BE"+code+code2+tmp2;

			System.out.println("만들 코드: " + b_code);
			beer.setB_code(b_code);

			// beer에 추가
			beerDAO = new BeerDAO();
			test = beerDAO.updateBeer(beer);
			System.out.println("beer update 결과: " + test);

			// 이미지 관련
			beerImageDAO = new BeerImageDAO();
			beerImage = new BeerImageDTO();

			b_id = beer.getB_id();
			beerImage.setI_file_name(i_file_name);
			beerImage.setI_original_name(i_original_name);
			beerImage.setI_thumbnail_name("sm_" + i_original_name);
			beerImage.setI_file_type(i_file_type);
			beerImage.setB_id(b_id);

			// 값이 있는 건지 없는 건지 체크
			boolean rs=beerImageDAO.chkBeer(beerImage);
			beerImageDAO = new BeerImageDAO();
			if(rs) {
				result = beerImageDAO.updateBeer(beerImage);
			}
			else {
				result = beerImageDAO.insertBeer(beerImage);
			}

			beerImageDAO.createImageThumb(imgDirPath, thumbImageDir, i_original_name, 5);

			if (result == true) {
				request.getRequestDispatcher("/index.jsp").forward(request, response);
			} else {
				request.getRequestDispatcher("/com/yju/2wda/team1/view/etc/error.jsp").forward(request, response);
			}
			break;

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
