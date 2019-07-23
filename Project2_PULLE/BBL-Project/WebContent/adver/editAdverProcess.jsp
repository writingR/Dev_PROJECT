<%@page import="adver.service.AdverAuthorityException"%>
<%@page import="adver.service.EditAdverService"%>
<%@page import="adver.model.Adver"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.File"%>
<%@page
	import="org.apache.commons.fileupload.FileUploadBase.InvalidContentTypeException"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	try {

		Adver adver = new Adver();

		//session id 저장필요
		String companyId = (String) session.getAttribute("company_ID");
		adver.setCompany_ID(companyId);

		String fileName = "";
		String saveFileName = "";
		long fileSize = 0;
		String path = "/adver_upload";
		String dir = request.getSession().getServletContext().getRealPath(path);

		boolean isMulitpart = ServletFileUpload.isMultipartContent(request);

		DiskFileItemFactory factory = new DiskFileItemFactory();

		ServletFileUpload upload = new ServletFileUpload(factory);

		//FileItem <- 홈 페이지에서 전송한 데이터들을 가져온다. uName, sNumber, report 
		List<FileItem> items = upload.parseRequest(request);

		Iterator<FileItem> itr = items.iterator();

		while (itr.hasNext()) {
			FileItem item = itr.next();

			if (item.isFormField()) {
				//타입="file"이 아닌경우
				if (item.getFieldName().equals("adverId")) {
					adver.setAdver_ID(Integer.parseInt(item.getString()));
				}
				if (item.getFieldName().equals("adver_Title")) {
					adver.setAdver_Title(item.getString("utf-8"));
				}
				if (item.getFieldName().equals("adver_Content")) {
					adver.setAdver_Content(item.getString("utf-8"));
				}

			} else {
				//타입="file"인 경우
				if (item.getFieldName().equals("adver_Photo")) {
					//파일 이름
					fileName = item.getName();
					fileSize = item.getSize();
					//saveFileName = System.currentTimeMillis()+"_"+fileName;
					saveFileName = companyId + "_" + System.nanoTime() + "_" + fileName;

					if (fileName != null && !fileName.isEmpty()) {
						adver.setAdver_Photo(saveFileName);
						item.write(new File(dir, saveFileName));
					}
				}
			}

		}

		EditAdverService update = EditAdverService.getInstance();
		int cnt = 0;
		String msg = "";
		boolean chk = false;

		try {
			cnt = update.editMessage(adver, dir, companyId);
			chk = true;
		} catch (SQLException e) {
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
<script src="js/bootstrap.js"></script>
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
		<h1 class="display-4">광고 글 수정 처리 게시판</h1>
		<hr>
		<div>
			<%
				if (cnt > 0) {
			%>
			수정 성공했습니다. 곧 페이지 이동합니다.
			<%
				} else {
			%>
			수정 실패했어요. 곧 페이지 이동합니다.
			<%=msg%>
			<%
				}
			%>
			<img style="width:100px; height:100px; margin-top:150px; margin-bottom:150px; margin-left:250px;" src="${pageContext.request.contextPath}/img/loadingDefault.gif">
		</div>
	</div>

	<script>
		$(document).ready(function() {
			setTimeout(function() {

				location.href = "adver_list.jsp";

			}, 3000);
		});
	</script>
</body>
</html>


<%
	} catch (InvalidContentTypeException e) {
		e.printStackTrace();
		response.sendRedirect("adver_list.jsp");
	}
%>