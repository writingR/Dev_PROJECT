<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User"/>
<jsp:setProperty property="*" name="user"/>
<!DOCTYPE html>
<html>
<head>
<title>회원가입 완료화면</title>
</head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<body>

	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}	
	

	if (user.getUser_ID() == null || user.getUser_ID().equals("") || user.getUser_Pw() == null || user.getUser_Pw().equals("") ||
		user.getUser_Name() == null || user.getUser_Name().equals("") ||   user.getUser_Nic() == null || user.getUser_Nic().equals("") || 
		user.getUser_Gen() == null || user.getUser_Gen().equals("") ||user.getUser_Email() == null || 
		user.getUser_Email().equals("") || user.getUser_Memo() == null || user.getUser_Memo().equals("")) {
		
		PrintWriter out_ = response.getWriter();
		out_.println("<script>");
		out_.println("alert('오류발생 : 미입력사항있음')");
		out_.println("window.history.back()");
		out_.println("</script>");
	    
    } else {
		
	  UserDAO u_DAO = new UserDAO();	
	  int joinRs = u_DAO.join(user);
		
	  if(joinRs == -2){
		 PrintWriter out_ = response.getWriter();
		 out_.println("<script>");
		 out_.println("alert('오류발생 : 알 수 없는 데이터오류')");
		 out_.println("window.history.back()");
		 out_.println("</script>");			
	  } else{
		 session.setAttribute("userID", user.getUser_ID());
		 PrintWriter out_ = response.getWriter();
		 out_ = response.getWriter();
		 out_.println("<script>");
		 out_.println("alert('회원가입이 완료되었습니다.')");
		 out_.println("location.href = 'sessionOut.jsp'");
		 out_.println("</script>");
	  }
		
		
	}

	
	%>
	
</body>
</html>