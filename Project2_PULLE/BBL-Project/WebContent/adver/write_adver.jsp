<%@page import="adver.model.Adver"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String userID = null;
	String company_ID = null;
	if (session.getAttribute("userID") != null || session.getAttribute("company_ID") != null) {
		userID = (String) session.getAttribute("userID");
		company_ID = (String) session.getAttribute("company_ID");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Monoton&display=swap"
	rel="stylesheet">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<title>뿔레 사이트</title>
</head>
<body>
	
	<!----------------- 네비게이션  시작-------------------->
	<jsp:include page="/WEB-INF/nav/nav.jsp" />
	<script>
		$(document).ready(function() {
			$('#ad').addClass('active');
		});
	</script>
	<!----------------- 네비게이션  끝------------------------>

	<div class="container">
		<h1 class="display-4">광고 작성 게시판</h1>
		<hr>
		<form action="write_adverProcess.jsp" method="post"
			enctype="multipart/form-data">
			<div class="form-group">
				<label for="adver_Title">제목</label> <input type="text"
					class="form-control" id="adver_Title" name="adver_Title"
					placeholder="제목을 입력하세요.">
			</div>
			<div class="form-group">
				<label for="adver_Content">내용</label>
				<textarea class="form-control" rows="15" id="adver_Content"
					name="adver_Content" placeholder="여기에 내용을 작성하세요."></textarea>
			</div>
			<div class="form-group">
				<label for="adver_Photo">사진</label> <input type="file"
					name="adver_Photo" id="adver_Photo" name="adver_Photo">
			</div>
			<input type="submit" class="btn btn-primary" value="입력">
		</form>
	</div>

	<!-- 푸터 시작 -->
	<footer>
		<div>
			<p
				style="text-align: center; font-size: 12px; margin-top: 10px; opacity: 0.8">
				이용약관 | <span style="font-weight: 900;">개인정보처리방침 </span>| 책임의 한계와 |
				법적고지 | 회원정보 | 고객센터
			</p>
		</div>
	</footer>
	<!-- 푸터 끝 -->


</body>
</html>