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
		String userName = null;
		String userGen = null;
		if (session.getAttribute("userID") != null || session.getAttribute("userName") != null ||
			session.getAttribute("userGen") != null){
			userID = (String)session.getAttribute("userID");
			userName = (String)session.getAttribute("userName");
			userGen = (String)session.getAttribute("userGen");
			
		}
	%>
	

 		<%
 		
 			String user_Pw = request.getParameter("user_Pw");
 		    String user_Nic = request.getParameter("user_Nic");
 		    String user_Email = request.getParameter("user_Email");
 		    String user_Memo = request.getParameter("user_Memo");
 			Connection conn = null;
 			PreparedStatement pstmt = null;
 			ResultSet rs = null;
 			int resultCnt = 0;
 			
 			try{
 			
 			conn = ConnectionProvider.getConnection();
 			
 			String SQL = "UPDATE custom set user_Pw=?,user_Nic=?,user_Email=?,user_Memo=? WHERE user_ID = ?";
 			pstmt = conn.prepareStatement(SQL);
 			pstmt.setString(1, user_Pw);
 			pstmt.setString(2, user_Nic);
 			pstmt.setString(3, user_Email);
 			pstmt.setString(4, user_Memo);
 			pstmt.setString(5, userID);
 			
 			resultCnt = pstmt.executeUpdate();
 		
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
    <script>
    	if(<%=resultCnt%> > 0) {
    		alert("수정완료");
    		location.href="myInfo.jsp";
    	} else {
    		alert("오류가 발생했습니다.");
    		location.href="myInfo.jsp";
    	}
    </script>
	
	

</body>
</html>



