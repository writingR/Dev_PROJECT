<%@page import="adver.service.AdverAuthorityException"%>
<%@page import="java.io.File"%>
<%@page import="adver.service.AdverNotFoundException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="adver.service.DeleteAdverService"%>
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
<%
	int adverId = Integer.parseInt(request.getParameter("AdverId"));

	String companyId = (String) session.getAttribute("company_ID");

	String fileName = "";
	String msg = "";
	boolean chk = false;

	//서비스 객체 생성
	DeleteAdverService service = DeleteAdverService.getInstance();

	try {
		//데이터베이스 삭제 및 로컬 파일 삭제
		fileName = service.deleteMessage(adverId, companyId);

		String dir = request.getSession().getServletContext().getRealPath("/adver_upload/");
		File file = new File(dir + fileName);
		if (file.exists()) {
			if (file.delete()) {
				System.out.println("파일삭제 성공");
			} else {
				System.out.println("파일삭제 실패");
			}
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}

		chk = true;

	} catch (SQLException e) {
		msg = e.getMessage();
	} catch (AdverNotFoundException e) {
		msg = e.getMessage();
	} catch (AdverAuthorityException e) {
		msg = e.getMessage();
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
		<hr>
		<h3>
			메세지 삭제<small>들어오셨습니다.</small>
		</h3>
		<%
			if (chk) {
		%>
		삭제 성공했어요. 곧 페이지 이동합니다.
		<%
			} else {
		%>
		삭제 실패했어요. 곧 페이지 이동합니다.
		<%=msg%>
		<%
			}
		%>
		<img style="width:100px; height:100px; margin-top:150px; margin-bottom:150px; margin-left:250px;" src="${pageContext.request.contextPath}/img/loadingDefault.gif">

		<script>
			$(document).ready(function() {
				setTimeout(function() {

					location.href = "adver_list.jsp";
				}, 3000);
			})
		</script>
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