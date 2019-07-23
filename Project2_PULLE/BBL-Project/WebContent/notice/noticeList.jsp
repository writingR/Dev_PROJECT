<%@page import="notice.dao.NoticeDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="notice.model.NoticeListView"%>
<%@page import="notice.service.GetNoticeService"%>
<%@page import="notice.model.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	//핵심 처리 할 서비스 객체 
	GetNoticeService service = GetNoticeService.getInstance();

	//응답 데이터의 결과
	NoticeListView viewData = service.getNoticeListView(pageNumber);	
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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




a {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
	color: black;
}

#ntc {
	margin: 0 auto;
	width: 40%;
}
#sub{
font-size:12px;
float:right;
}
table {
	width: 100%
}

table>tbody>tr>td {
	border-bottom: 1px solid #ddd;
	padding: 10px;
}
#num{
width:15%;
text-align:center;
}
#ti{
width:65%;
}
#dt{
width:20%;
text-align:center;
}
#a{
text-align:right;
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
		<span id="sub"><%=viewData.getNoticeTotalCount()%>개의 공지사항이 있습니다.</span>
		<br>
		<hr>
		<%
			if (viewData.isEmpty()) {
		%>
		<h3>등록된 공지사항이 없습니다.</h3>
		<%
			} else {
				for (Notice notice : viewData.getNoticeList()) {
		%>
		<table>
			<tr>
				<td id="num"><%=notice.getId()%></td>
				<td id="ti"><a href="viewNotice.jsp?id=<%= notice.getId()%>"><%=notice.getTitle()%></a></td>
				<td id="dt"><%=notice.getDate() %></td>
			</tr>
		</table>
		<%
			}
			}
			//page numbering [1][2][3] 
			for (int i = 1; i <= viewData.getPageTotalCount(); i++) {
		%> 
		<a href="noticeList.jsp?pageNumber=<%=i%>"><%=i%></a>
		<%
			}
		%>
		<div id="a"><a href="writeNotice.jsp">공지작성</a></div>
	</div>
	<br><br>
	<img src="../img/fork.png" id="fork">
</body>
</html>