<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>파일 업로드/다운로드 테스트 페이지 with COS</h1>
<h2>다운로드 페이지 - DB조회(MVC/Bean 미사용)</h2>
<hr>
<p>
<table border="1">
   <thead>
      <tr>
         <th>순번</th>
         <th>파일이름</th>
         <th>원본이름</th>
         <th>썸네일이름</th>
         <th>파일타입</th>
         <th>파일사이즈</th>
         <th>원본이미지</th>
         <th>썸네일이미지</th>
         <th>다운로드</th>
      </tr>
   </thead>
   <tbody>
<%
	String driverName = "org.mariadb.jdbc.Driver";
	String url = "jdbc:mariadb://localhost/kjw59_mall_db";
	String user = "root";
	String passwd = "root";
	
	String imageDir = "/fileUploadProj02/image/";
	String thumbImageDir = imageDir + "thumb/";
	
	int result;
	int i_id;
	String i_file_name;
	String i_original_name;
	String i_thumbnail_name;
	String i_file_type;
	long i_file_size;
	
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(url,user,passwd);
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String SQL = "select * from image_tbl";
	try{
	   	pstmt = con.prepareStatement(SQL);
	   	rs = pstmt.executeQuery();
	   
	  	while(rs.next()) {
	      i_id = rs.getInt("i_id");
	      i_file_name = rs.getString("i_file_name");
	      i_original_name = rs.getString("i_original_name");
	      i_thumbnail_name = rs.getString("i_thumbnail_name");
	      i_file_type = rs.getString("i_file_type");
	      i_file_size = rs.getLong("i_file_size"); 
%>
	   <tr>
	      <td><%=i_id %></td>
	      <td><%=i_file_name %></td>
	      <td><%=i_original_name %></td>
	      <td><%=i_thumbnail_name %></td>
	      <td><%=i_file_type %></td>
	      <td><%=i_file_size %></td>
	      <td><img src="<%=imageDir%><%=i_file_name%>" width="150"/></td>
	      <td><%=i_thumbnail_name %></td>
	      <td><a href="<%=imageDir %><%=i_original_name %>" download>다운받기</a></td>
	   </tr>
<% 
   }
%>
   </tbody>
</table>
<% 
	   rs.close();
	} catch(SQLException e) {
	   e.printStackTrace();
	}
	finally{
	   con.close();
	}
%>

<p><br><a href="index.jsp">홈으로 돌아가기</a>

</body>
</html>