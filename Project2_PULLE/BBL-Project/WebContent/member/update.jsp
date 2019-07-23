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
 		</br>
	    </br>
 		<div class="container">
		<span style ="color: black; font-size: 60px; margin-left: 330px; font-family: 'Sunflower', sans-serif;">MY INFO</span>
		<form action="update_Process.jsp" method="post">
		   <fieldset style = "margin-left: 200px; margin-top: -20px;">
			  <!-- 	<legend style ="color: black; font-size: 60px; margin-left: 70px; font-family: 'Sunflower', sans-serif;">회원가입</legend> -->
			  	</br>
			  	</br>
			  	<ul>
					<li text-align="center"><label for="user_ID">아이디 : </label>
   	 				<%= userID %><input type="hidden" name="user_ID" value="<%=userID%>"></li>
             	</ul>			
				<ul>
   					<li><label for="user_Pw">암호:</label> <input type="password" name="user_Pw" value="<%=user_Pw%>"></li>
  				</ul>
  				<ul>
  					 <li><label for="user_Name">이름 : </label>
   					 <%= user_Name %><input type="hidden" name="user_Name" value="<%=userName%>"></li>
 				</ul>
 				<ul>
  					 <li><label for="user_Nic">닉네임 : </label>
   					 <input type="text" name="user_Nic" value="<%=user_Nic%>"></li>
 				</ul>
				<ul>
 				  	 <li><label for="user_Gen">성별 : </label>
   					 <%= user_Gen %><input type="hidden" name="user_Gen" value="<%=userGen%>"></li> 
 			    </ul>
				<ul>
   					 <li><label for="user_Email">이메일 : </label>
  					 <input type="text" name="user_Email" value="<%=user_Email%>"></li>
  				</ul>
				<ul>
  				   <li><label for="user_Memo">비고 : </label>
   				   <input type="text" name="user_Memo" value="<%=user_Memo%>"></li>
  				</ul>
  				<ul>
  				   <li colspan="2">
  				  	<a href='update_Process.jsp' style='text-decoration:none;color:black'><input type="submit" name="user_Update" value="저장"></a>
					<a href='myInfo.jsp' style='text-decoration:none;color:black'><input type="button" name="user_List" value="리스트"></a>
  				   </li>
  				</ul>
			</fieldset>
		</form>
	</div>
 <%-- 		
		<form action="update_Process.jsp" method="post">
			
			<table>
				<tr>
					<td>아이디</td>
					<td><%= userID %><input type="hidden" name="user_ID" value="<%=userID%>"></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="user_Pw" value="<%=user_Pw%>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><%= user_Name %><input type="hidden" name="user_Name" value="<%=userName%>"></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="user_Nic" value="<%=user_Nic%>"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><%= user_Gen %><input type="hidden" name="user_Gen" value="<%=userGen%>"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="user_Email" value="<%=user_Email%>"></td>
				</tr>
				<tr>
					<td>자기소개</td>
					<td><input type="text" name="user_Memo" value="<%=user_Memo%>"></td>
				</tr> --%>					
<!-- 				<tr>
					<td colspan="2">
					<a href='update_Process.jsp' style='text-decoration:none;color:black'><input type="submit" name="user_Update" value="저장"></a>
					<a href='myInfo.jsp' style='text-decoration:none;color:black'><input type="button" name="user_List" value="리스트"></a>
					</td>
				</tr>																			
			</table>
 		 </form> -->
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



