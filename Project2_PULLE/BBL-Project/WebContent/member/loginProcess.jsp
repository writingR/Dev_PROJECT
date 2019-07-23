<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 이 페이지 안에서만 login시도를 하기때문에 scope는 page를 주어도 상관없다. -->
<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
<!-- 한명의 사용자의 아이디,패스워드를 받아서 처리하는 것이기 떄문에 propert에는 ID,password를 각각 넣어서 처리한다.  -->
<jsp:setProperty property="user_ID" name="user"/>
<jsp:setProperty property="user_Pw" name="user"/>
<!DOCTYPE html>
<html>
<head>
<title>일반 회원 Process</title>
</head>

<body>
		<%
		
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter out_ = response.getWriter();
			out_.println("<script>");
			out_.println("alert('이미 로그인 되어 있습니다.')");
			out_.println("location.href = 'main.jsp' ");
			out_.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUser_ID(), user.getUser_Pw());
		// -1: 아이디 없음 / 1: 로그인 성공 / 0: 로그인 실패(비밀번호가 다를경우) / -2: 데이터베이스 오류  
		
		// 로그인 성공시
		if(result == 1) {
			// 로그인 성공시에 세션을 부여해준다. 세션 ? 현재 접속한 회원(데이터)에게 부여해주는 고유한 ID!
			// 페이지 안에서 회원들을 구분하려면 세션에 부여된 ID로 구분해야한다.
			session.setAttribute("userID", user.getUser_ID());
			PrintWriter out_ = response.getWriter();
			out_.println("<script>");
			out_.println("alert('회원전용 로그인되었습니다.')");
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