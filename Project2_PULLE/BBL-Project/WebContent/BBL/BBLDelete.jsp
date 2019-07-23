<%@page import="java.io.File"%>
<%@page import="mainpage.service.MainpageAuthorityException"%>
<%@page import="mainpage.service.MainpageNotFoundException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="mainpage.service.DeleteMainpageService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int mainpageId = Integer.parseInt(request.getParameter("mainpageId"));

	
	String userId = (String)session.getAttribute("userID");
		
	String fileName = "";
	String msg ="";
	boolean chk= false;
	
	//서비스 객체 생성
	DeleteMainpageService service = DeleteMainpageService.getInstance();
	
	try{
		//데이터베이스 삭제 및 로컬 파일 삭제
		fileName = service.deleteMessage(mainpageId, userId);
		
		String dir = request.getSession().getServletContext().getRealPath("/mainpage_photo/");
		File file = new File(dir+fileName);
        if( file.exists() ){
            if(file.delete()){
                System.out.println("파일삭제 성공");
            }else{
                System.out.println("파일삭제 실패");
            }
        }else{
            System.out.println("파일이 존재하지 않습니다.");
        }
		chk = true;
	}catch(SQLException e){
		msg = e.getMessage();
	}catch(MainpageNotFoundException e){
		msg = e.getMessage();
	}catch(MainpageAuthorityException e){
		msg = e.getMessage();
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#wrap{
	width: 960px;
	height: 400px;
	position: absolute;
	top:50%;
	left:50%;
	margin-top: -200px;
	margin-left: -480px;
	text-align: center;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<div id="wrap">
	<img src="../img/Pacman200px.gif">
	<% if(chk){ %>
	<h1>삭제가 완료되었습니다.</h1>
	<h2>잠시 후 페이지로 이동합니다.</h2>
	<% }else { %>
	<h1>삭제가 실패했습니다.</h1>
	<%= msg %>
	<h2>잠시 후 페이지로 이동합니다.</h2>
	<% }%>
</div>
<script>
	$(document).ready(function () {
	        	setTimeout(function(){
	        		
					location.href = "BBL.jsp";
					
	        	}, 1000);
	    });
</script>
</body>
</html>