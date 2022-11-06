package kjw59_mvc_beer3.model.beer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BeerDAO {

	private PreparedStatement pstmt = null;
	private Connection con = null;

	Context init = null; // 컨텍스트 객체 변수
	DataSource ds = null; // 데이터소스 객체 변수
	ResultSet rs = null; // 쿼리 결과 셋 객체 변수

	CategoryCodeDTO category;
	CountryCodeDTO country;

	
	public BeerDAO() {
		super();
		dbConnect();
	}

	public void dbConnect() {
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc_mariadb");
			con = ds.getConnection();

			System.out.println("DB연결 성공");
		} catch (Exception e) {
			System.out.println("DB연결 실패");
			e.printStackTrace();
		}
	}

	// 데이터베이스 연결 해제 메소드
	public void disConnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		// 쿼리 결과셋 객체 해제 부분 추가
		if(rs != null) {
			try {
				rs.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// 게시판의 모든 레코드를 반환 메소드 - R
	public ArrayList<BeerSelectInfoVO> getBeerList(String searchType, String searchContent) {
		ArrayList<BeerSelectInfoVO> list = new ArrayList<BeerSelectInfoVO>();	
		String SQL;
		System.out.println(searchType);
		
		if(searchType.equals("전체")) {
			SQL = "select b.b_id, b.b_code, b.b_category, b.b_name, b.b_country, "
					+ "b.b_price, b.b_alcohol, b.b_content, b.b_like, b.b_dislike, IFNULL(i.i_file_name, 'default.jpg') AS i_file_name "
					+ "from beer b LEFT JOIN beer_image i on (b.b_id = i.b_id) order by b.b_id";
		}
		else if(searchType.equals("종류")) {
			SQL = "select b.b_id, b.b_code, b.b_category, b.b_name, b.b_country, "
					+ "b.b_price, b.b_alcohol, b.b_content, b.b_like, b.b_dislike, IFNULL(i.i_file_name, 'default.jpg') AS i_file_name "
					+ "from beer b LEFT JOIN beer_image i on (b.b_id = i.b_id) where b.b_category=? order by b.b_id";
		}
		else if(searchType.equals("국가")) {
			SQL = "select b.b_id, b.b_code, b.b_category, b.b_name, b.b_country, "
					+ "b.b_price, b.b_alcohol, b.b_content, b.b_like, b.b_dislike, IFNULL(i.i_file_name, 'default.jpg') AS i_file_name "
					+ "from beer b LEFT JOIN beer_image i on (b.b_id = i.b_id) where b.b_country=? order by b.b_id";
		}
		else {
			SQL = "select b.b_id, b.b_code, b.b_category, b.b_name, b.b_country, "
					+ "b.b_price, b.b_alcohol, b.b_content, b.b_like, b.b_dislike, IFNULL(i.i_file_name, 'default.jpg') AS i_file_name "
					+ "from beer b LEFT JOIN beer_image i on (b.b_id = i.b_id) where b.b_name=? order by b.b_id";
		}
		
		
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, searchContent);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BeerSelectInfoVO selectVO=new BeerSelectInfoVO();
				selectVO.setB_id(rs.getInt("b_id"));
				selectVO.setB_code(rs.getString("b_code"));
				selectVO.setB_category(rs.getString("b_category"));
				selectVO.setB_name(rs.getString("b_name"));
				selectVO.setB_country(rs.getString("b_country"));
				selectVO.setB_price(rs.getInt("b_price"));
				selectVO.setB_alcohol(rs.getString("b_alcohol"));
				selectVO.setB_content(rs.getString("b_content"));
				selectVO.setB_like(rs.getInt("b_like"));
				selectVO.setB_dislike(rs.getInt("b_dislike"));
				selectVO.setI_file_name(rs.getNString("i_file_name"));

				list.add(selectVO);
			}
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnect();
		}
		return list;
	}

	
	// 게시판의 현재 페이지 레코드를 반환 메서드 - R4
	public ArrayList<BeerSelectInfoVO> getBeerListForPage(BeerPageInfoVO bpiVO) {

		ArrayList<BeerSelectInfoVO> list = new ArrayList<>();

		String SQL = "select b.b_id, b.b_code, b.b_category, b.b_name, b.b_country, "
				+ "b.b_price, b.b_alcohol, b.b_content, b.b_like, b.b_dislike, IFNULL(i.i_file_name, 'default.jpg') AS i_file_name "
				+ "from beer b LEFT JOIN beer_image i on (b.b_id = i.b_id)";
		SQL+= "ORDER BY b.b_id limit ?,?";
		
		String SQL2 = "select count(*) from beer";

		ResultSet rs;

		try {
			pstmt = con.prepareStatement(SQL2);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				bpiVO.setRecordCnt(rs.getInt(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		bpiVO.adjPageInfo();

		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, bpiVO.getStartRecord());
			pstmt.setInt(2, bpiVO.getLimitCnt());

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BeerSelectInfoVO selectVO=new BeerSelectInfoVO();
				selectVO.setB_id(rs.getInt("b_id"));
				selectVO.setB_code(rs.getString("b_code"));
				selectVO.setB_category(rs.getString("b_category"));
				selectVO.setB_name(rs.getString("b_name"));
				selectVO.setB_country(rs.getString("b_country"));
				selectVO.setB_price(rs.getInt("b_price"));
				selectVO.setB_alcohol(rs.getString("b_alcohol"));
				selectVO.setB_content(rs.getString("b_content"));
				selectVO.setB_like(rs.getInt("b_like"));
				selectVO.setB_dislike(rs.getInt("b_dislike"));
				selectVO.setI_file_name(rs.getNString("i_file_name"));

				list.add(selectVO);
			}
			rs.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnect();
		}
		return list;
	}

	// R2에 들어갈 종류별 검색 조회
		public ArrayList<BeerSelectInfoVO> getSearchList(BeerPageInfoVO bpiVO, String search) {

			ArrayList<BeerSelectInfoVO> list = new ArrayList<>();
			
			String SQL = "select b.b_id, b.b_code, b.b_category, b.b_name, b.b_country, "
					+ "b.b_price, b.b_alcohol, b.b_content, b.b_like, b.b_dislike, IFNULL(i.i_file_name, 'default.jpg') AS i_file_name "
					+ "from beer b LEFT JOIN beer_image i on (b.b_id = i.b_id)";
			SQL+= "ORDER BY b.b_id limit ?,?";
			
			String SQL2 = "select count(*) from beer";

			ResultSet rs;

			try {
				pstmt = con.prepareStatement(SQL2);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					bpiVO.setRecordCnt(rs.getInt(1));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			bpiVO.adjPageInfo();

			try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setInt(1, bpiVO.getStartRecord());
				pstmt.setInt(2, bpiVO.getLimitCnt());

				rs = pstmt.executeQuery();

				while (rs.next()) {
					BeerSelectInfoVO selectVO=new BeerSelectInfoVO();
					selectVO.setB_id(rs.getInt("b_id"));
					selectVO.setB_code(rs.getString("b_code"));
					selectVO.setB_category(rs.getString("b_category"));
					selectVO.setB_name(rs.getString("b_name"));
					selectVO.setB_country(rs.getString("b_country"));
					selectVO.setB_price(rs.getInt("b_price"));
					selectVO.setB_alcohol(rs.getString("b_alcohol"));
					selectVO.setB_content(rs.getString("b_content"));
					selectVO.setB_like(rs.getInt("b_like"));
					selectVO.setB_dislike(rs.getInt("b_dislike"));
					selectVO.setI_file_name(rs.getNString("i_file_name"));

					list.add(selectVO);
				}
				rs.close();

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				disConnect();
			}
			return list;
		}
	

	// 주 키 b_id의 레코드를 반환 메소드 - R
	public BeerDTO getBeer(int b_id) {
		String SQL = "select * from beer where b_id=?";
		BeerDTO beer = new BeerDTO();

		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setInt(1, b_id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();

			beer.setB_id(rs.getInt("b_id"));
			beer.setB_code(rs.getString("b_code"));
			beer.setB_category(rs.getString("b_category"));
			beer.setB_name(rs.getString("b_name"));
			beer.setB_country(rs.getString("b_country"));
			beer.setB_price(rs.getInt("b_price"));
			beer.setB_alcohol(rs.getString("b_alcohol"));
			beer.setB_content(rs.getString("b_content"));
			beer.setB_like(rs.getInt("b_like"));
			beer.setB_dislike(rs.getInt("b_dislike"));

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disConnect();
		}
		return beer;
	}
	

	// 게시물 등록 메서드 - C
	public boolean insertBeer(BeerDTO beer) {
		boolean success = false;
		
		String sql = "insert into beer(b_id, b_code, b_category, b_name, b_country, b_price, b_alcohol, b_content, b_like, b_dislike) ";
		sql += "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, beer.getB_id());
			pstmt.setString(2, beer.getB_code());
			pstmt.setString(3, beer.getB_category());
			pstmt.setString(4, beer.getB_name());
			pstmt.setString(5, beer.getB_country());
			pstmt.setInt(6, beer.getB_price());
			pstmt.setString(7, beer.getB_alcohol());
			pstmt.setString(8, beer.getB_content());
			pstmt.setInt(9, beer.getB_like());
			pstmt.setInt(10, beer.getB_dislike());

			pstmt.executeUpdate();
			success = true;
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		} finally {
			disConnect();
			
		}
		return success;
	}

	// 데이터 갱신을 위한 메서드 - U
	public boolean updateBeer(BeerDTO beer) {
		boolean success = false;
	
		String sql = "update beer set b_code=?, b_category=?, b_name=?, b_country=?, "
				+ "b_price=?, b_alcohol=?, b_content=?, b_like=?, b_dislike=? where b_id=?";
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, beer.getB_code());
			pstmt.setString(2, beer.getB_category());
			pstmt.setString(3, beer.getB_name());
			pstmt.setString(4, beer.getB_country());
			pstmt.setInt(5, beer.getB_price());
			pstmt.setString(6, beer.getB_alcohol());
			pstmt.setString(7, beer.getB_content());
			pstmt.setInt(8, beer.getB_like());
			pstmt.setInt(9, beer.getB_dislike());
			pstmt.setInt(10, beer.getB_id());

			System.out.println("update문: "+pstmt);
			int rowUdt = pstmt.executeUpdate();
			if (rowUdt == 1)
				success = true;

		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		} finally {
			disConnect();
		}
		return success;
	}

	public boolean deleteBeer(int b_id) {
		boolean success = false;
	
		String sql = "delete from beer where b_id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, b_id);
			pstmt.executeUpdate();
			success = true;

		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		} finally {
			disConnect();
		}
		return success;
	}
	
	public int selectB_id(BeerDTO beer) throws SQLException {
		int b_id=0;

		String sql = "select b_id from beer where b_code = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, beer.getB_code());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				b_id=rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return b_id;
			
		} finally {
			disConnect();
		}
		
		return b_id;
	}
	

	public String selectCategory_code(BeerDTO beer) {
		String category_code="";
		
		String sql = "select category_code from category_code where b_category = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, beer.getB_category());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				category_code=rs.getString(1);
				System.out.println("category_code: "+category_code);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return category_code;
			
		} finally {
			disConnect();
		}
		return category_code;
	}

	public String selectCountry_code(BeerDTO beer) {
		String country_code="";
		
		String sql = "select country_code from country_code where b_country = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, beer.getB_country());
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				country_code=rs.getString(1);
				System.out.println("country_code: "+country_code);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return country_code;
			
		} finally {
			disConnect();
		}
		return country_code;
	}
	
	public String makeB_code(String b_code) {
		String make_code="";
		
		String sql="select b_code from beer where b_code like ? order by b_code desc";
	
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, b_code+"%");
			System.out.println(pstmt);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				make_code=rs.getString(1);
			}
			else {
				make_code=b_code+0000;
			}

		} catch (SQLException e) {
			e.printStackTrace();
			return make_code;
			
		} finally {
			disConnect();
		}
		return make_code;
		
	}
	
	// 최종으로 들어갈 b_code
	public String addB_code(BeerDTO beer) {
		BeerDAO beerDAO;
		
		// 코드 자동생성 만드는 과정
		beerDAO = new BeerDAO();
		String code = beerDAO.selectCategory_code(beer); // 종류코드 조회
		beerDAO = new BeerDAO();
		String code2 = beerDAO.selectCountry_code(beer); // 국가코드 조회
		String b_code = "BE" + code + code2;
		beerDAO = new BeerDAO();
		String code3 = beerDAO.makeB_code(b_code); // 같은 종류, 국가 코드찾고 가장 큰 일련번호 확인
		System.out.println("code3:"+code3);
		
		// 뒤에 4개 잘라서 일련번호 만들기
		String tmp = code3.substring(7);
		int tmp2 = Integer.parseInt(tmp) + 1;
		if (tmp2 < 10) 	b_code="BE"+code+code2+"000"+ tmp2;
		else if (tmp2 < 100) b_code="BE"+code+code2+"00"+ tmp2;
		else if (tmp2 < 1000) b_code="BE"+code+code2+"0"+ tmp2;
		else b_code="BE"+code+code2+tmp2;
		
		return b_code;
		
	}
}
