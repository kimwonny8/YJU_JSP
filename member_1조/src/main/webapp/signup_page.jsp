<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
   <%
   session.setAttribute("loginState", "signup");
      String driverName = "org.mariadb.jdbc.Driver";
      String url = "jdbc:mariadb://localhost/member_db";
      String user = "root";
      String pswd = "root";
      
      Class.forName(driverName);
      Connection con = DriverManager.getConnection(url,user,pswd);
      Statement st = con.createStatement();
      request.setCharacterEncoding("utf-8");
      String sql;
      String mem_ids;
      PreparedStatement pstmt;
      
      
   %>
   <%@ include file="./header.jsp"%>

   <h1>회원가입</h1>
   <form name="signup" method="post" action="./mem_models/member_dao.jsp" onsubmit="return blankCheck()">
      이름 : <input type="text" name="mem_name" size="20"><br>
      아이디 : <input type="text" name="mem_id" id="mem_id" size="30">
      <input type="button" name="OverlapCheck" id="check_id" onclick="checkId()" value="중복체크">
      <small id="lapcheck">중복체크 확인하세요!</small> 
      <br> 
      비밀번호 : <input   type="password" name="mem_passwd" size="30"><br> 
      이메일 : <input type="text" name="mem_email" size="30"><br> 
      휴대폰번호 : <input type="text" name="mem_phone" size="30" placeholder="010-1234-5678"><br>
      주민등록번호 : <input type="text" name="mem_RRN1" id="userRrn1" size="12" maxlength="6">-
      				<input type="password" name="mem_RRN2" id="userRrn2" size="12" maxlength="7">
      				<input type="button" value="검사" id="Rrn" onclick="chkRrn();" />
      				<small id="checkRrn">유효성 검사</small> <br>
      <input type="hidden" name="actionType" value="SIGNUP">
      <input type="submit" value="회원가입">
   </form>

   <script>
      var OverCheck = 0;
      
      function chkRrn(){
    	  var rrn1= document.getElementById("userRrn1");
    	  var rrn2= document.getElementById("userRrn2");
    	  
    	  var arrRrn1 = new Array();
    	  var arrRrn2 = new Array();
    	  
    	  for(var i=0; i<rrn1.value.length; i++){
    		  arrRrn1[i] = rrn1.value.charAt(i);
    	  }
    	  for(var i=0; i<rrn2.value.length; i++){
    		  arrRrn2[i] = rrn2.value.charAt(i);
    	  }
    	  
    	  var sum =0;
    	  
    	  for(var i=0; i<rrn1.value.length; i++){
    		  sum += arrRrn1[i]*(2+i);
    	  }
    	  for(var i=0; i<rrn2.value.length-1; i++){
    		  if(i>=2){
    			  sum+=arrRrn2[i] *i;
    		  }else{
    			  sum += arrRrn2[i] *(8+i);
    		  }
    	  }
    	  
    	  if((11-(sum%11))%10 != arrRrn2[6]){
    		  document.getElementById("checkRrn").innerHTML="X"
    		  rrn1.value = "";
    		  rrn2.value = "";
    		  rrn1.focus();
    		  return false;
    	  }else{
    		  document.getElementById("checkRrn").innerHTML="O"
    	  }
      }
      
      function blankCheck() { //빈칸있는지, 중복체크 확인 했는지 함수
         <%
//          sql = "select mem_id from member where mem_id='?'";
//           pstmt = con.prepareStatement(sql);
//           pstmt.setString(1, mem_ids);
          sql = "SELECT mem_id FROM member ORDER BY mem_id";
         ResultSet rs = st.executeQuery(sql);
         %>
         var fun = document.signup;
         

         if (fun.mem_name.value == "") {
            alert("이름을 입력해주세요");
            fun.mem_name.focus();
            return false;
         }
         if (OverCheck == 0 && fun.mem_id.value != ""){
            alert("중복되는지 확인해주세요.")
            fun.mem_id.focus();
            return false;
         }
         if (fun.mem_id.value == "") {
            alert("아이디를 입력해주십시오");
            fun.mem_id.focus();
            return false;
         }
         if (fun.mem_passwd.value == "") {
            alert("비밀번호를 입력해주십시오");
            fun.mem_passwd.focus();
            return false;
         }
         if (fun.mem_email.value == "") {
            alert("이메일을 입력해주십시오");
            fun.mem_email.focus();
            return false;
         }
         if (fun.mem_phone.value == "") {
            alert("전화번호를 입력해주십시오");
            fun.mem_phone.focus();
            return false;
         }
         if (fun.mem_RRN1.value == "") {
            alert("주민번호를 입력해주십시오.");
            fun.mem_RRN.focus();
            return false;
         }
         if (fun.mem_RRN2.value == "") {
             alert("주민번호를 입력해주십시오.");
             fun.mem_RRN.focus();
             return false;
          }
         if(OverCheck =! 0){ //혹시라도 중복아닌 아이디로 중복체크 확인 후 중복되는 아이디로 바꿨을 때의 경우
            <%
            while(rs.next()){
               mem_ids = rs.getString("mem_id");
             %> 
            if (fun.mem_id.value == "<%=mem_ids%>"){
               document.getElementById("lapcheck").innerHTML="중복되는 아이디입니다."
               fun.mem_id.focus();
               return false;
            }
            <%}%>
         }
         
         
      }

      function checkId() { //중복체크 함수
         var fun = document.signup;
         <%
//           sql = "select mem_id from member where mem_id='?'";
//           pstmt = con.prepareStatement(sql);
//           pstmt.setString(1, mem_ids);
          sql = "SELECT mem_id FROM member ORDER BY mem_id";
         rs = st.executeQuery(sql);
         
         while(rs.next()){
            mem_ids = rs.getString("mem_id");
          %> 
         if (fun.mem_id.value == "<%=mem_ids%>"){
            document.getElementById("lapcheck").innerHTML="중복되는 아이디입니다."
            fun.mem_id.focus();
            return false;
         }
         <%}%>
         else{
         document.getElementById("lapcheck").innerHTML="사용가능한 아이디입니다!"
         fun.mem_passwd.focus();
         OverCheck = 1;
         }
      }
      
      
   </script>



   <%@ include file="./footer.jsp"%>
</body>
</html>