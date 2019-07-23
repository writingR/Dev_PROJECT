<%@page import="user.User"%>
<%@page import="user.UserDAO"%>
<%@page import="jdbc.DBConnection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="jdbc.DBCPInit"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
	request.setCharacterEncoding("UTF-8");
%>   
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty property="user_ID" name="user"/>
<jsp:setProperty property="user_Name" name="user"/>
<jsp:setProperty property="user_Gen" name="user"/>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<style>
  ul{
	list-style: none;
  }
  label {
	width: 60px;
	display: inline-block;
  }
</style>
<body>
	
	<!----------------- 네비게이션  시작-------------------->
		<jsp:include page ="/WEB-INF/nav/nav.jsp"/>
		<script>
			$(document).ready(function(){
				$('#home').addClass('active');
			});
		</script>
	<!----------------- 네비게이션  끝------------------------>
	
	<%
		String company_ID = null;
		if (session.getAttribute("company_ID") != null){
			company_ID = (String)session.getAttribute("company_ID");			
		}
	%>

 		<%
 		
 			Connection conn = null;
 			PreparedStatement pstmt = null;
 			ResultSet rs = null;
 			
 			try{
 			
 			conn = ConnectionProvider.getConnection();
 			
 			String SQL = "SELECT * FROM company where company_ID = ?";
 			pstmt = conn.prepareStatement(SQL);
 			pstmt.setString(1, company_ID);
 			rs = pstmt.executeQuery();
 			
 			while(rs.next()){
 			
 			String companyID = rs.getString("company_ID");
 			String company_Pw = rs.getString("company_Pw");
 			String company_Name = rs.getString("company_Name");
 			String company_Email = rs.getString("company_Email");
 			String company_Num = rs.getString("company_Num");
 			String company_Memo = rs.getString("company_Memo");
 			
 		
 		%>
 		</br>
	    </br>
 		<div class="container">
		<span style ="color: black; font-size: 60px; margin-left: 330px; font-family: 'Sunflower', sans-serif;">MY INFO</span>
		<form action="update_Process_com.jsp" method="post">
		   <fieldset style = "margin-left: 200px; margin-top: -20px;">
			  <!-- 	<legend style ="color: black; font-size: 60px; margin-left: 70px; font-family: 'Sunflower', sans-serif;">회원가입</legend> -->
			  	</br>
			  	</br>
			  	<ul>
					<li text-align="center"><label for="user_ID">아이디 : </label>
   	 				<%= company_ID %><input type="hidden" name="user_ID" value="<%=company_ID%>"></li>
             	</ul>			
				<ul>
   					<li><label for="user_Pw">암호:</label> <input type="password" name="company_Pw" value="<%=company_Pw%>"></li>
  				</ul>
  				<ul>
  					 <li><label for="user_Name">이름 : </label>
   					 <%= company_Name %><input type="hidden" name="company_Name" value="<%=company_Name%>"></li>
 				</ul>
				<ul>
   					 <li><label for="user_Email">이메일 : </label>
  					 <input type="text" name="company_Email" value="<%=company_Email%>"></li>
  				</ul>
				<ul>
  				   <li><label for="user_Memo">사업자 : </label>
   				   <%= company_Num %><input type="hidden" name="company_Num" value="<%=company_Num%>"></li>
  				</ul>				
				<ul>
  				   <li><label for="user_Memo">비고 : </label>
   				   <input type="text" name="company_Memo" value="<%=company_Memo%>"></li>
  				</ul>
  				<ul>
  				   <li colspan="2">
  				  	<a href='update_Process_com.jsp' style='text-decoration:none;color:black'><input type="submit" name="user_Update" value="저장"></a>
					<a href='myInfo_com.jsp' style='text-decoration:none;color:black'><input type="button" name="user_List" value="리스트"></a>
  				   </li>
  				</ul>
			</fieldset>
		</form>
		

	</div>
<%-- 		<form action="update_Process_com.jsp" method="post">
			
			<table>
				<tr>
					<td>아이디</td>
					<td><%= company_ID %><input type="hidden" name="company_ID" value="<%=company_ID%>"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="company_Pw" value="<%=company_Pw%>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><%= company_Name %><input type="hidden" name="company_Name" value="<%=company_Name%>"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="company_Email" value="<%=company_Email%>"></td>
				</tr>
				<tr>
					<td>사업자번호</td>
					<td><%= company_Num %><input type="hidden" name="company_Num" value="<%=company_Num%>"></td>
				</tr>
				<tr>
					<td>자기소개</td>
					<td><input type="text" name="company_Memo" value="<%=company_Memo%>"></td>
				</tr>					
				<tr>
					<td colspan="2">
					<a href='update_Process_com.jsp' style='text-decoration:none;color:black'><input type="submit" name="user_Update" value="저장"></a>
					<a href='myInfo_com.jsp' style='text-decoration:none;color:black'><input type="button" name="user_List" value="리스트"></a>
					</td>
				</tr>																			
			</table>
 		 </form> --%>
		<%
		
 			}
		
 			} catch (SQLException e) {
 				e.printStackTrace();
 			} finally {
 			
 				try{
 				
 			 if(rs != null) rs.close();
 			 if(pstmt != null) pstmt.close();
 			 if(conn != null) conn.close();
 			
 			 } catch (SQLException e){
 				 e.printStackTrace();
 			}
 		}
		
		%>
 		
 	</table>

</body>
</html>



