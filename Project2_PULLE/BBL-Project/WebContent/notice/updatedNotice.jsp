<%@page import="notice.service.NoticeNotFoundException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="notice.service.UpdateNoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="notice" class="notice.model.Notice" />
<jsp:setProperty property="*" name="notice" />
<%
	int id =0;
	if (request.getParameter("id") != null) {
		id = Integer.parseInt(request.getParameter("id"));
	}
	
	int rCnt = 0;
	boolean chk = false;
	String msg = "";

	try {
		UpdateNoticeService service = UpdateNoticeService.getInstance();
		rCnt = service.update(notice);
	} catch (SQLException e) {
		msg = e.getMessage();
	} 

%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	margin: 0;
	padding: 0;
}

li {
	list-style: none;
	float: left;
}

a {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
}

#ntc {
	margin: 0 auto;
	width: 40%;
}
#fork{
	position:fixed;
 	bottom: 50px;
    right: 2%;
    width: 90px;
   }
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<!----------------- 네비게이션  시작-------------------->
	<jsp:include page ="/WEB-INF/nav/nav.jsp"/>
	<script>
		$(document).ready(function(){
			$('#notice').addClass('active');
		});
	</script>
<!----------------- 네비게이션  끝------------------------>
<br><br>
<div id="ntc">
	<h4><%= id %>번 공지사항이 수정되었습니다.</h4>
	<script>
		$(document).ready(function() {
			setTimeout(function() {

				location.href = "noticeList.jsp";
			}, 1000);
		})
	</script>
</div>
<br><br>
<img src="../img/fork.png" id="fork">
</body>
</html>