<%@page import="notice.service.DeleteNoticeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int id =0;
if (request.getParameter("id") != null) {
	id = Integer.parseInt(request.getParameter("id"));
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
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
input[type=submit] {
	width: 150px;
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
} else if(userID.equals("admin")){
%> 
<div id="ntc">
	<h4><%= id %>번 공지사항을 삭제하시겠습니까?</h4>
	<br>
	<h5>삭제된 공지사항은 되돌릴 수 없어요. 신중하게 생각해주세요!</h5>
	<a href="deletedNotice.jsp?id=<%= id %>"><input type="submit" name="yes" value="네 삭제하겠습니다"></a>
	<a href="noticeList.jsp"><input type="submit" name="no" value="아니요"></a>
</div>
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
	alert("관리자만 삭제할 수 있습니다.");
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