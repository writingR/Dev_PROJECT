<%@page import="company.Company"%>
<%@page import="company.CompanyDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="company" class="company.Company"/>
<jsp:setProperty property="*" name="company"/>
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

	<ul class="nav nav-tabs">
  		<li role="presentation"><a href="../main.jsp">Home</a></li>
  		<li role="presentation"><a href="#">Notice</a></li>
  		<li role="presentation"><a href="#">BBL</a></li>
  		<li role="presentation"><a href="#">TMI</a></li>
  		<li role="presentation"><a href="#">Advertisement</a></li>
  		<li role="presentation" class="active"><a href="join.jsp">Join</a></li>
  		<li role="presentation"><a href="login.jsp">Login</a></li>
  		<li role="presentation"><a href="#">Login.c</a></li>
  		<li role="presentation"><a href="logout.jsp">Logout</a></li>
	</ul>
	
	<%
	String comID = null;
	if (session.getAttribute("comID") != null) {
		comID = (String) session.getAttribute("comID");
	}	
	

	if (company.getCompany_ID() == null || company.getCompany_ID().equals("") || company.getCompany_Pw() == null || company.getCompany_Pw().equals("") ||
		company.getCompany_Name() == null || company.getCompany_Name().equals("") || company.getCompany_Email() == null || company.getCompany_Email().equals("") || 
		company.getCompany_Num() == null || company.getCompany_Num().equals("") || company.getCompany_Memo() == null || company.getCompany_Memo().equals("") ) {
		
		PrintWriter out_ = response.getWriter();
		out_.println("<script>");
		out_.println("alert('오류발생 : 미입력사항있음')");
		out_.println("window.history.back()");
		out_.println("</script>");
	    
    } else {
	 
	  CompanyDAO comDAO = new CompanyDAO();	
	  int joinRs = comDAO.join(company);
		
	  if(joinRs == -2){
		 PrintWriter out_ = response.getWriter();
		 out_.println("<script>");
		 out_.println("alert('오류발생 : 알 수 없는 데이터오류')");
		 out_.println("window.history.back()");
		 out_.println("</script>");			
	  } else{
		 session.setAttribute("comID", company.getCompany_ID());
		 PrintWriter out_ = response.getWriter();
		 out_ = response.getWriter();
		 out_.println("<script>");
		 out_.println("alert('사업자가입이 완료되었습니다.')");
		 out_.println("location.href = 'sessionOut.jsp'");
		 out_.println("</script>");
	  }
		
		
	}

	
	%>

</body>
</html>