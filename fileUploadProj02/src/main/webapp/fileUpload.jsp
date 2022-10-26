<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"
	import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"
	import="com.oreilly.servlet.MultipartRequest" import="java.sql.*"
	import="java.io.*" import="java.nio.file.*"
	import="java.awt.Graphics2D" import="java.awt.image.BufferedImage"
	import="javax.imageio.ImageIO" import="javax.media.jai.JAI"
	import="javax.media.jai.RenderedOp"%>
<%@page import="java.awt.Image"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>파일 업로드/다운로드 테스트 페이지 with COS</h1>
	<h2>파일 업로드 진행 - COS, DB 활용</h2>
	<hr>

	<%
	request.setCharacterEncoding("utf-8");
	String imgDirPath = "D:\\Dev\\fileUploadProj02\\src\\main\\webapp\\image\\";
	String thumbImageDir = "D:\\Dev\\fileUploadProj02\\src\\main\\webapp\\image\\thumb\\";

	int maxSize = 1024 * 1024 * 5; //최대 5G까지 가능 1024 => 1KB 

	MultipartRequest multi = new MultipartRequest(request, imgDirPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	String userName = multi.getParameter("userName");

	Enumeration<?> files = multi.getFileNames();

	String element = "";
	String filesystemName = "";
	String originalFileName = "";
	String contentType = "";

	long length = 0;

	if (files.hasMoreElements()) {
		element = (String) files.nextElement();
		filesystemName = multi.getFilesystemName(element);
		originalFileName = multi.getOriginalFileName(element);
		contentType = multi.getContentType(element);
		length = multi.getFile(element).length();
	}

	/*
	try{
		String orgFileName = imgDirPath + originalFileName;
		String thumbFileName = thumbImageDir + "sm_" + originalFileName;
		int zoom = 5;

		File save = new File(thumbFileName); //썸네일 이미지 파일
		RenderedOp rOp = JAI.create("fileload", orgFileName); //orgFileName는 원본 이미지파일 RenderedOp 객체생성
		BufferedImage im = rOp.getAsBufferedImage(); //BufferedImage 객체를 얻어옴

		if (zoom <= 0)
			zoom = 1; //zoom이 5이면 원본이미지의 1/5 크기가 된다.
			
		int width = im.getWidth() / zoom;
		int height = im.getHeight() / zoom;

		BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB); //메모리에 이미지 공간을 생성
		Graphics2D g2 = thumb.createGraphics(); //BufferedImage로 부터 Graphics2D객체를 얻어냄

		g2.drawImage(im, 0, 0, width, height, null); //메모리의 이미지공간에 원본 이미지를 가로 width, 세로 height 크기로 그린다.

		ImageIO.write(thumb, "png", save); //메모리에 그린이미지를 파일로 저장 
	} catch(Exception e){
		e.printStackTrace();
	}
	*/

	String oPath = imgDirPath + originalFileName; // 원본 경로
	File oFile = new File(oPath);

	int index = oPath.lastIndexOf(".");
	String ext = oPath.substring(index + 1); // 파일 확장자

	String tPath = thumbImageDir + "sm_" + originalFileName; // 썸네일저장 경로
	File tFile = new File(tPath);

	double ratio = 2; // 이미지 축소 비율

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
	%>
	<p>
		입력한 사용자 이름:
		<%=userName%></p>
	<p>
		파라메타 이름 :
		<%=element%></p>
	<p>
		서버에 업로드된 파일 이름 :
		<%=filesystemName%></p>
	<p>
		유저가 업로드한 원본 파일 이름 :
		<%=originalFileName%></p>
	<p>
		파일 타입 :
		<%=contentType%></p>
	<p>
		파일 크기 :
		<%=length%></p>

	<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/kjw59_mall_db";
	String user = "root";
	String passwd = "root";

	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url, user, passwd);

	PreparedStatement pstmt = null;
	int result;

	String sql = "insert into image_tbl(i_file_name, i_original_name, ";
	sql += "i_thumbnail_name, i_file_type, i_file_size)";
	sql += "values(?,?,?,?,?)";

	try {
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, filesystemName);
		pstmt.setString(2, originalFileName);
		pstmt.setString(3, "sm_" + filesystemName);
		pstmt.setString(4, contentType);
		pstmt.setLong(5, length);

		result = pstmt.executeUpdate();

		if (result == 1) {
			out.println("<h2>데이터베이스 입력 성공</h2>");
		} else {
			out.println("<h2>데이터베이스 입력 실패<h2>");
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		con.close();
	}
	%>
	<p>
		<br> <a href="/fileUploadProj02/index.jsp">홈으로 돌아가기</a>
	</p>

</body>
</html>