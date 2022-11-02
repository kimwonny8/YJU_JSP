package kjw59_mvc_beer3.model.beer;

import java.sql.*;
import javax.sql.*;

import kjw59_mvc_beer3.model.beer.BeerDTO;

import java.util.ArrayList;
import javax.naming.*;

public class BeerImageDAO {

	private PreparedStatement pstmt = null;
	private Connection con = null;

	Context init = null; // 컨텍스트 객체 변수
	DataSource ds = null; // 데이터소스 객체 변수
	ResultSet rs = null; // 쿼리 결과 셋 객체 변수

	public BeerImageDAO() {
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

	
	// 게시물 등록 메서드 - C
	public boolean insertBeer(BeerImageDTO beer) {
		boolean success = false;

		String sql = "insert into beer_image values(?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, beer.getI_file_name());
			pstmt.setString(2, beer.getI_original_name());
			pstmt.setString(3, beer.getI_thumbnail_name());
			pstmt.setString(4, beer.getI_file_type());
			pstmt.setInt(5, beer.getI_file_size());
			pstmt.setInt(6, beer.getB_id());
		
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
	public boolean updateBeer(BeerImageDTO beer) {
		boolean success = false;
	
		String sql = "update beer set i_file_name=?, i_original_name=?, i_thumbnail_name=?, i_file_type=?, "
				+ "i_file_size=? where b_id=? ";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, beer.getI_file_name());
			pstmt.setString(2, beer.getI_original_name());
			pstmt.setString(3, beer.getI_thumbnail_name());
			pstmt.setString(4, beer.getI_file_type());
			pstmt.setInt(5, beer.getI_file_size());
			pstmt.setInt(6, beer.getB_id());
		

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

}
