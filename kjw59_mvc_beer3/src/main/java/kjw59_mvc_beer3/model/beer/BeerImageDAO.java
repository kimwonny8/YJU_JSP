package kjw59_mvc_beer3.model.beer;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import javax.sql.*;

import kjw59_mvc_beer3.model.beer.BeerDTO;

import java.util.ArrayList;

import javax.imageio.ImageIO;
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

	public boolean chkBeer(BeerImageDTO beer) {
		boolean success = false;

		String sql = "select * from beer_image where b_id = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, beer.getB_id());
		
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) success = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return success;
		} finally {
			disConnect();
		}
		return success;
	}
	
	// 이미지 등록 메서드 - C
	public boolean insertBeer(BeerImageDTO beer) {
		boolean success = false;

		String sql = "insert into beer_image values(?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, beer.getI_file_name());
			pstmt.setString(2, beer.getI_original_name());
			pstmt.setString(3, beer.getI_thumbnail_name());
			pstmt.setString(4, beer.getI_file_type());
			pstmt.setInt(5, beer.getB_id());
		
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

	// 이미지 갱신을 위한 메서드 - U
	public boolean updateBeer(BeerImageDTO beer) {
		boolean success = false;
	
		String sql = "update beer_image set i_file_name=?, i_original_name=?,"
				+ " i_thumbnail_name=?, i_file_type=? where b_id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, beer.getI_file_name());
			pstmt.setString(2, beer.getI_original_name());
			pstmt.setString(3, beer.getI_thumbnail_name());
			pstmt.setString(4, beer.getI_file_type());
			pstmt.setInt(5, beer.getB_id());
			
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

	// 썸네일
	public void createImageThumb(String imgDirPath, String thumbImageDir, 
			String originalFileName, int zoom) throws IOException {

		String oPath = imgDirPath + originalFileName; // 원본 경로
		File oFile = new File(oPath);

		int index = oPath.lastIndexOf(".");
		String ext = oPath.substring(index + 1); // 파일 확장자

		String tPath = thumbImageDir + "sm_" + originalFileName; // 썸네일저장 경로
		File tFile = new File(tPath);

		double ratio = zoom; // 이미지 축소 비율

		try {
			BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
			int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
			int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이

			BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
			Graphics2D graphic = tImage.createGraphics();
			Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
			graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
			graphic.dispose(); // 리소스를 모두 해제

			ImageIO.write(tImage, ext, tFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
