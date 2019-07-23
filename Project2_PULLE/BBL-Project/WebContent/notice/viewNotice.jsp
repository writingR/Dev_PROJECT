<%@page import="notice.service.GetNoticeService"%>
<%@page import="notice.service.WriteNoticeService"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="notice.model.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	int id = 1;
	if (request.getParameter("id") != null) {
		 id= Integer.parseInt(request.getParameter("id"));
	}

	GetNoticeService service = GetNoticeService.getInstance();
	Notice notice = service.getNotice(id);
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
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<style>
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

#view {
	padding: 5px;
}

#title {
	font-weight: 700;
	font-size: 17px;
	padding: 5px;
}

#cons {
	background-color: #F2F2F2;
	padding: 5px;
}
span{
font-size:12px;
font-weight: 300;
}
#date{
text-align: right;
}

#btn {
	padding: 5px;
	text-align: right;
}

input[type=submit] {
	width: 7%;
	height: 25px;
	background-color: #A69A94;
	color: #fff;
	font-size: 15px;
	border-style: none;
}
#fork{
	position:fixed;
 	bottom: 50px;
    right: 2%;
    width: 90px;
   }
</style>
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
	<div id="ntc">
		<br>
		<h2>공지사항</h2>
		<hr>
		<div id="view">
			<div id="title"><span><%=notice.getId()%>. </span>  <%=notice.getTitle()%></div>
			<div id="cons">
				<img src="../upload/<%=notice.getPhoto()%>" width="90%"><br>
				<%=notice.getCon()%><br><br>
				<span><a href="searchMap.jsp">지도를 검색하시겠어요?</a></span>
			</div>

			<div id="date"><%=notice.getDate()%></div>
		</div>
		<div id="btn">
		<a href="updateNotice.jsp?id=<%= id %>"><input type="submit" name="edt" value="수정"></a> 
		<a href="deleteNotice.jsp?id=<%= id %>"><input type="submit" name="del" value="삭제"></a> 
		<a href="noticeList.jsp"><input type="submit" name="list" value="목록"></a>
		</div>
	</div>
	<br><br>
	<img src="../img/fork.png" id="fork">
</body>
</html>