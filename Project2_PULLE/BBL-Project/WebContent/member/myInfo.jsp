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
<jsp:setProperty property="*" name="user"/>
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
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
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
 			<td>이름</td>
 			<td>닉네임</td>
 			<td>성별</td>
 			<td>이메일</td>
 			<td>자기소개</td>
 			<td>수정 및 탈퇴</td>
 		</tr>
 		<%
 		
 			Connection conn = null;
 			PreparedStatement pstmt = null;
 			ResultSet rs = null;
 			
 			try{
 			
 			conn = ConnectionProvider.getConnection();
 			
 			String SQL = "SELECT * FROM custom where user_ID = ?";
 			pstmt = conn.prepareStatement(SQL);
 			pstmt.setString(1, userID);
 			rs = pstmt.executeQuery();
 			
 			while(rs.next()){
 				
 				String user_ID = rs.getString("user_ID");
 				String user_Pw = rs.getString("user_Pw");
 				String user_Name = rs.getString("user_Name");
 				String user_Nic = rs.getString("user_Nic");
 				String user_Gen = rs.getString("user_Gen");
 				String user_Email = rs.getString("user_Email");
 				String user_Memo = rs.getString("user_Memo");
 			
 		
 		%>
 		<tr>
 			<td><%= user_ID %></td>
 			<td><%= user_Pw %></td>
 			<td><%= user_Name %></td>
 			<td><%= user_Nic %></td>
 			<td><%= user_Gen %></td>
 			<td><%= user_Email %></td>
 			<td><%= user_Memo %></td>
 			<td colspan="2"><a href="update.jsp">수정</a>
 			    <a href="delete.jsp">탈퇴</a></td>
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



