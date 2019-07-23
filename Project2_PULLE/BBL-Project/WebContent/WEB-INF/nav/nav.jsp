<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">


	<header>
		<img src="${pageContext.request.contextPath}/img/fork.png" style="width:40px;height:40px; margin-left: 20px;margin-top:-10px;">
        <span style ="color: black; font-size:40px; margin-left: 20px; font-family: 'Sunflower', sans-serif;">뿔레</span>
        <input type="text" id="searchbar" placeholder="당신의 게시물을 쉽고 빠르게 찾을 수 있습니다!   게시물 이동 후 검색." style="width:800px; padding:5px;opacity:0.7;background-color:#f1f2f6;border:0px solid black;border-radius:10px;margin:6px;vertical-align:5px;font-family: 'Nanum Gothic', sans-serif;font-size:13px;">
        <img src="${pageContext.request.contextPath}/img/search.png" style="width:20px;margin-top:-6px;">
	</header>
	<%
		request.setCharacterEncoding("utf-8");
	%>
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
	  	
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"">
	  		<ul class="nav navbar-nav">
	  			<li id="home"><a href="${pageContext.request.contextPath}/main.jsp">홈</a></li>
	  			<li id="notice"><a href="${pageContext.request.contextPath}/notice/noticeList.jsp">공지사항</a></li>
	  			<li id="BBL"><a href="${pageContext.request.contextPath}/BBL/BBL.jsp">뿔레?!</a></li>
	  			<li id="tmi"><a href="${pageContext.request.contextPath}/tmi/tmiList.jsp">일상게시판</a></li>
	  			<li id="ad"><a href="${pageContext.request.contextPath}/adver/adver_list.jsp">광고게시판</a></li>	  			
	  		</ul>  		
	  		<%
	  			if(userID == null && company_ID == null){
	  		%>
			<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  				   data-toggle="dropdown" role="button"
	  				   aria-haspopup="true" aria-expanded="false">뿔레 가입후에 더 많은 서비스를 즐겨주세요! <span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="${pageContext.request.contextPath}/member/join.jsp">회원가입</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/join_Com.jsp">사업자가입</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/login.jsp">회원 로그인</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/login_com.jsp">사업자 로그인</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/logout.jsp">로그아웃</a></li>	  					
	  				</ul>   
	  			</li>
	  		</ul>

	  		<%
	  			} else if (userID != null) {
	  		%>
	  		<ul class="nav navbar-nav navbar-right"  id="drop2">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  				   data-toggle="dropdown" role="button"
	  				   aria-haspopup="true" aria-expanded="false">일반회원 로그인중 <span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="${pageContext.request.contextPath}/member/login.jsp">회원 로그인</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/login_com.jsp">사업자 로그인</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/myInfo.jsp">회원정보</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/logout.jsp">로그아웃</a></li>  					
	  				</ul>   
	  			</li>
	  		</ul>
	  		
	   		<%
	  			} else if (company_ID != null) {
	  		%>
	  		<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  				   data-toggle="dropdown" role="button"
	  				   aria-haspopup="true" aria-expanded="false">사업자 로그인중 <span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="${pageContext.request.contextPath}/member/login.jsp">회원 로그인</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/login_com.jsp">사업자 로그인</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/myInfo_com.jsp">사업자정보</a></li>
	  					<li><a href="${pageContext.request.contextPath}/member/logout.jsp">로그아웃</a></li>  					
	  				</ul>   
	  			</li>
	  		</ul>
	  		
			<%
	  			}
			%>
	  </div>
	</nav>
	
	