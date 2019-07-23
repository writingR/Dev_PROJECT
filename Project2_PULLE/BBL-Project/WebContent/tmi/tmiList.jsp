<%@page import="tmiService.ListService"%>
<%@page import="tmi.Tmi"%>
<%@page import="java.util.List"%>
<%@page import="tmi.TmiDAO"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("utf-8");

ListService service= ListService.getInstance();

List<Tmi> list=service.tmiList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* div {
	margin: 20px;
} */

 #contentBox{
 width: 70%;
}
 #tPhotoBox{
	display:block;
	width: 810px;
	height: 500px;
	overflow: auto;
	margin-left: 70px;
}
#tPhoto{
	width: 800px;
}
.aTag{
 	
	font-family: 'Sunflower', sans-serif;
	color: #7f8c8d;
	font-size: 1.2em;
}
.aTag:hover{
	text-decoration:none;
	text-decoration:blink;
	color:#2c3e50;
	
}
#make {
	margin-left: 8%;
	font-size: 2.5em;
}
#map {
	margin-left: 8%;
	font-size: 1.3em;
}
#contents {
	margin-left: 10%;
}
#main {
	width:1000px;
	margin:3%;
	border: 5px #f1f2f6 solid;
	padding: 10px;
}
.mSpan{
	font-size: 1.4em;
	font-weight: 200;
	padding-right: 5px;
}
#photo{
	position:fixed;
 	bottom: 50px;
    right: 2%;
    width: 90px;
   }
#story{
 	width: 900px;
 } 
 #MOVE_TOP{
    position: fixed;
    right: 8%;
    bottom: 50px;
    display: none;
    color: black; 
    font-size:40px;  
    font-family: 'Sunflower', sans-serif;
}
.btn_submit{
 	background-image: url('../img/16s.png');
 
    background-repeat: no-repeat;
    background-color:white;
    width: 16px;
 	height:16px;
    border: 0px;
 	cursor:pointer;
 	
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<meta name="viewport" content="width=device-width" initial-scale="1">
<link
	href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Orbitron&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="../css/bootstrap.min.css" />
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="../js/bootstrap.js"></script>
<body>

	<header>
		<img src="../img/fork.png" style="width:40px;height:40px; margin-left: 20px;margin-top:-10px;">
        <span style ="color: black; font-size:40px; margin-left: 20px; font-family: 'Sunflower', sans-serif;">뿔레</span>
		<form action="searchList.jsp" style="display: inline-block;">
        	<input name="keyword" id="searchText" type="text" placeholder="당신의 게시물을 쉽고 빠르게 찾을 수 있습니다!   게시물 이동 후 검색." style="width:800px; padding:5px;opacity:0.7;background-color:#f1f2f6;border:0px solid black;border-radius:10px;margin:6px;vertical-align:5px;font-family: 'Nanum Gothic', sans-serif;font-size:13px;">
			<!-- <input type="submit" value="" style="width:20px; height:20px; background-color:white;border-radius:50%; border:1px solid black;"> -->
			<input type="submit" value="" class="btn_submit">

		</form>
	</header>
	<%
		String userID = null;
		String company_ID = null;
		if (session.getAttribute("userID") != null || session.getAttribute("company_ID") != null){
			userID = (String)session.getAttribute("userID");
			company_ID = (String)session.getAttribute("company_ID");
		}
	%>
	<nav class="navbar navbar-inverse">
		<div class="navbar-header">
 		<a class = "navbar-brand" href="#"></a>	
	  	</div>
	  	
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li><a href="../main.jsp">홈</a></li>
	  			<li><a href="../notice/noticeList.jsp">공지사항</a></li>
	  			<li><a href="../BBL/BBL.jsp">뿔레?!</a></li>
	  			<li class="active"><a href="tmiList.jsp">일상게시판</a></li>
	  			<li><a href="../adver/adver_list.jsp">광고게시판</a></li>	  			
	  		</ul>  		
	  		<%
	  			if(userID == null || company_ID == null){
	  		%>
			<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  				   data-toggle="dropdown" role="button"
	  				   aria-haspopup="true" aria-expanded="false">뿔레 가입후에 더 많은 서비스를 즐겨주세요! <span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="../member/join.jsp">회원가입</a></li>
	  					<li><a href="../member/join_Com.jsp">사업자가입</a></li>
	  					<li><a href="../member/login.jsp">회원 로그인</a></li>
	  					<li><a href="../member/login_com.jsp">사업자 로그인</a></li>
	  					<li><a href="../member/logout.jsp">로그아웃</a></li>	  					
	  				</ul>   
	  			</li>
	  		</ul>
	  		
	  		<%
	  			} else {
	  		%>
	  		<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  				   data-toggle="dropdown" role="button"
	  				   aria-haspopup="true" aria-expanded="false">개인회원 로그인중 <span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="../member/login.jsp">회원 로그인</a></li>
	  					<li><a href="../member/login_com.jsp">사업자 로그인</a></li>	
	  					<li><a href="../member/logout.jsp">로그아웃</a></li>  					
	  				</ul>   
	  			</li>
	  		</ul>
	  		
			<%
	  			}
			%>
	  		
	  	</div>
	</nav>
	
	
	
	<br>
	<a href="tmiForm.jsp" id="make" class="aTag">일상을 전달해 볼까요?</a>
	<br>
	<br>
	<a href="searchMap.jsp" id="map" class="aTag">어디에 뭐가 있는지 궁금하세요?</a>
		<div id="contents">
		<%
			if (list.isEmpty()) {
		%>
		<div>
			<h3>
				아직 아무도 글을 남기지 않았어요<br>첫번째 글을 남겨보세요
			</h3>
		</div>
		<%
			} else {
		%>
		<h1><%=service.count()%>개의 글이 떠돌고 있어요!</h1>
		<%
			for (Tmi tmi : list) {
		%>
		<div id="main">
			<table>
					
			<tr>
				<td><span class="mSpan">글번호</span></td>
				<td><%=tmi.getTmi_ID()%></td>
			</tr>
			<tr>
				<td><span class="mSpan">작성자</span></td>
				<td><%=tmi.getUser_ID()%></td>
			</tr>
			<tr>
				<td><span class="mSpan">날 짜</span></td>
				<td><%=tmi.getTmi_Date()%></td>
			</tr>
			<tr>
				<td><span class="mSpan">제 목</span></td>
				<td><%=tmi.getTmi_Title()%></td>
			</tr>	
				<tr>
					<td><span class="mSpan">내 용</span></td>
					<td><div id="story"><%=tmi.getTmi_Content()%></div></td>
				</tr>
			</table>
				<%
					if (tmi.getTmi_Photo() != null) {
				%>
				<span class="mSpan">TMI</span><br> 
				<span id="tPhotoBox"><img id="tPhoto" src="<%=tmi.getTmi_Photo()%>" class="img-thumbnail"></span> <br>
			<%
				}
			%>
			<div id="update">
				<a href="updateForm.jsp?tmi_ID=<%=tmi.getTmi_ID()%>" class="aTag">새로운 기억이 떠올랐어요!</a><br>
				<a href="deleteForm.jsp?tmi_ID=<%=tmi.getTmi_ID()%>" class="aTag">이 글이 보기 싫어요...</a>
			</div>
		</div>
		<%
				}
			}
		/* 	테스트용 */
		int	loginChk=0;
  		/* 요기다가 아리형 세션을 넣즈아!! */
	
		if(session.getAttribute("userID")==null){
			loginChk=1;
		}
		/* 테스트용끝 */
		%>
	
	</div>
		<img id="photo" src="../img/fork.png">
		<a id="MOVE_TOP" href="#">뿔레</a>
</body>
	<script>
	
	/* 세션으로 로그인체크 */
$(document).ready(function(){
	$(".aTag").click(function(event){
			if(<%=loginChk%>==1){
				event.preventDefault();
				alert("로그인 상태가 아니에요..");
				}
		});
	/* 스크롤 이벤트! */
	$(window).scroll(function () {
		if($(this).scrollTop()>500){
			$('#MOVE_TOP').fadeIn();
		}else{
			$('#MOVE_TOP').fadeOut();
		}
	});	
	$('#MOVE_TOP').click(function() {
		$('html,body').animate({
			scrollTop :0
		},400);
		return false;
	});
		
}) ; 
	
	</script>


</html>