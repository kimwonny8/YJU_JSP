<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" 
import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"
import="com.oreilly.servlet.MultipartRequest" 
import="java.sql.*" %>


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
	String imgDirPath = "D:\\Dev\\fileUploadProj01\\src\\main\\webapp\\image\\";
	int maxSize = 1024*1024*5; //최대 5G까지 가능 1024 => 1KB 
	
	MultipartRequest multi = new MultipartRequest(request, imgDirPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
	String userName=multi.getParameter("userName");
	
	Enumeration<?> files = multi.getFileNames();
	
	String element="";
	String filesystemName="";
	String originalFileName="";
	String contentType="";
	
	long length=0;
	
	if(files.hasMoreElements()){
		element = (String)files.nextElement();
		filesystemName = multi.getFilesystemName(element);
		originalFileName = multi.getOriginalFileName(element);
		contentType = multi.getContentType(element);
		length = multi.getFile(element).length();
	}
%>
<p>입력한 사용자 이름: <%=userName %></p>
<p>파라메타 이름 : <%=element %></p>
<p>서버에 업로드된 파일 이름 : <%=filesystemName %></p>
<p>유저가 업로드한 원본 파일 이름 : <%=originalFileName %></p>
<p>파일 타입 : <%=contentType %></p>
<p>파일 크기 : <%=length %></p>

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
	
/* 	String thumbImg = imgDirPath+originalFileName;
	Image srcImg = ImageIO.read(orgFile);
	int width = 100; //줄일 가로길이
	int height = 100; //줄일 세로길이 */
	
	
	try {
		   pstmt = con.prepareStatement(sql);
		   pstmt.setString(1,filesystemName);
		   pstmt.setString(2,originalFileName);
		   pstmt.setString(3,"sm_" + filesystemName);
		   pstmt.setString(4,contentType);
		   pstmt.setLong(5,length);
	
		   result = pstmt.executeUpdate();
		   
		   if(result == 1){
		      out.println("<h2>데이터베이스 입력 성공</h2>");
		   }
		   else{
		      out.println("<h2>데이터베이스 입력 실패<h2>");
		   }
	} 
	catch(SQLException e) {
	   e.printStackTrace();
	} 
	finally {
	   con.close();
	}
	%>
	<p><br><a href="index.jsp">홈으로 돌아가기</a></p>

</body>
</html>