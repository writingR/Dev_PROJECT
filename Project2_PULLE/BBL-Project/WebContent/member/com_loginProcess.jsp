<%@page import="company.CompanyDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="company" class="company.Company" scope="page"/>
<jsp:setProperty property="company_ID" name="company"/>
<jsp:setProperty property="company_Pw" name="company"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사업자 로그인 Process</title>
</head>

<body>
		<%
		
		String company_ID = null;
		if (session.getAttribute("company_ID") != null) {
			company_ID = (String) session.getAttribute("company_ID");
		}
		if(company_ID != null){
			PrintWriter out_ = response.getWriter();
			out_.println("<script>");
			out_.println("alert('이미 로그인 되어 있습니다.')");
			out_.println("location.href = 'main.jsp' ");
			out_.println("</script>");
		}
		
		CompanyDAO comDAO = new CompanyDAO();
		int result = comDAO.login(company.getCompany_ID(), company.getCompany_Pw());
		// -1: 아이디 없음 / 1: 로그인 성공 / 0: 로그인 실패(비밀번호가 다를경우) / -2: 데이터베이스 오류  
		
		// 로그인 성공시
		if(result == 1) {
			session.setAttribute("company_ID", company.getCompany_ID());
			PrintWriter out_ = response.getWriter();
			out_.println("<script>");
			out_.println("alert('사업자전용 로그인되었습니다.')");
			out_.println("location.href='../main.jsp'");
			out_.println("</script>");
		}
		// 로그인 실패(비밀번호가 다를경우)
		else if(result == 0) {
			PrintWriter out_ = response.getWriter();
			out_.println("<script>");
			out_.println("alert('비밀번호가 틀립니다.')");
			out_.println("history.back()");
			out_.println("</script>");
		}
		
		// 아이디 없음
		else if(result == -1) {
					PrintWriter out_ = response.getWriter();
					out_.println("<script>");
					out_.println("alert('존재하지 않는 아이디입니다.다시 확인해주세요.')");
					out_.println("history.back()");
					out_.println("</script>");
		}
		
		// 데이터베이스 오류  
		else if(result == -2) {
					PrintWriter out_ = response.getWriter();
					out_.println("<script>");
					out_.println("alert('오류가 감지되었습니다.메인페이지로 이동합니다.')");
					out_.println("history.back()");
					out_.println("</script>");
		}
		
		
	%>


</body>
</html>