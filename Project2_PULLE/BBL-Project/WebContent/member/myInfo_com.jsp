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
<jsp:useBean id="company" class="company.Company" scope="page"/>
<jsp:setProperty property="*" name="company"/>
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
	
	</br>
	</br>
	<div style="margin-left: 600px;">
 	<h1>MY INFO</h1>
 	<table border="1" width="600px">
 		<tr>
 			<td>아이디</td>
 			<td>비밀번호</td>
 			<td>이름(사업자)</td>
 			<td>이메일</td>
 			<td>사업자번호</td>
 			<td>비고</td>
 			<td>수정 및 탈퇴</td>
 		</tr>
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
 				
 				String companay_ID = rs.getString("company_ID");
 				String company_Pw = rs.getString("company_Pw");
 				String company_Name = rs.getString("company_Name");
 				String company_Email = rs.getString("company_Email");
 				String company_Num = rs.getString("company_Num");
 				String company_Memo = rs.getString("company_Memo");

 		
 		%>
 		
 		<tr>
 			<td><%= company_ID %></td>
 			<td><%= company_Pw %></td>
 			<td><%= company_Name %></td>
 			<td><%= company_Email %></td>
 			<td><%= company_Num %></td>
 			<td><%= company_Memo %></td>
 			<td colspan="2"><a href="update_com.jsp">수정</a>
 			    <a href="delete_com.jsp">탈퇴</a></td>
 		</tr>
 		
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
	</div>
</body>
</html>



