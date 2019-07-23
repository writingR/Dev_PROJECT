<%@page import="notice.service.GetNoticeService"%>
<%@page import="notice.model.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int id = 0;
	String idStr = request.getParameter("id");

	if (idStr != null) {
		id = Integer.parseInt(idStr);
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
* {
	margin: 0;
	padding: 0;
}

li {
	list-style: none;
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

textarea {
	width: 100%;
	border: 0 solid #fff;
	background-color: #F2F2F2;
}

input[type=submit] {
	width: 50px;
	height: 25px;
	background-color: #A69A94;
	color: #fff;
	font-size: 15px;
	border-style: none;
}
input[type=button] {
	width: 50px;
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
<%
		String userID = null;
		String company_ID = null;
		if (session.getAttribute("userID") != null || session.getAttribute("company_ID") != null){
			userID = (String)session.getAttribute("userID");
			company_ID = (String)session.getAttribute("company_ID");
		}
%>
<%
if(userID==null){
%>
<script>
$(document).ready(function(){
	alert("로그인 후에 사용할 수 있습니다.");
	location.href = "noticeList.jsp";
});
</script>
<%
}
else if(userID.equals("admin")){
%>  
	<div id="ntc">
		<br>
		<h2>공지사항 수정</h2>
		<hr>
		<form action="updatedNotice.jsp?id=<%= id %>" method="post">
			<div>
				<textarea rows="1" cols="80" name="title"
					placeholder="수정할 타이틀을 입력해주세요"></textarea>
				<br> <br>
				<textarea rows="30" cols="80" name="con" placeholder="수정할 내용을 입력해주요"></textarea>
				<br>
			</div>
			<input type="submit" value="수정" name="submit"> 
			<input type="button" value="취소" name="calcel" id="cancel">
		</form>
	</div>
<script>
$(document).ready(function() {
	$("#cancel").on("click",function(){
		location.href = "noticeList.jsp";
	});
})
</script>
<script>
		$(document).ready(function() {
			$("#cancel").on("click",function(){
				location.href = "noticeList.jsp";
			});
		})
	</script>
<%
}else {
%>
<script>
$(document).ready(function(){
	alert("관리자만 수정할 수 있습니다.");
	location.href = "noticeList.jsp";
});
</script>
<%
}
%>
<br><br>
<img src="../img/fork.png" id="fork">
</body>
</html>