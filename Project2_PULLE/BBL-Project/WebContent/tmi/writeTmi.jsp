<%@page import="tmiService.WriteService"%>
<%@page import="tmi.Tmi"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="tmi.TmiDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>
<%-- <jsp:useBean id="tmi" class="tmi.Tmi" /> --%>
<%-- <jsp:setProperty property="*" name="tmi" /> --%>
<%
	Tmi tmi = new Tmi();

	WriteService Service=WriteService.getInstance();

	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {

		String fileName = "";
		String saveFileName = "";
		String uploadpath = "/uploadImg";
		String dir = request.getSession().getServletContext().getRealPath(uploadpath);
		String fullpath = "";

		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);

		List<FileItem> items = upload.parseRequest(request);

		Iterator<FileItem> itr = items.iterator();

		while (itr.hasNext()) {
	FileItem item = itr.next();
	if (item.getFieldName().equals("user_ID")) {
		tmi.setUser_ID(item.getString("utf-8"));
	}
	if (item.getFieldName().equals("tmi_Title")) {
		tmi.setTmi_Title(item.getString("utf-8"));
	}
	if (item.getFieldName().equals("tmi_Content")) {
		tmi.setTmi_Content(item.getString("utf-8"));
	}
	if (item.getFieldName().equals("tmi_Photo")) {
		if (item.getName().length()>0) {
			fileName = item.getName();
			saveFileName = System.nanoTime() + "_" + fileName;
			item.write(new File(dir, saveFileName));
			fullpath = "../uploadImg/" + saveFileName;

			tmi.setTmi_Photo(fullpath);
		}
	}

		}

	}

	int rcnt=Service.write(tmi);
	//int rcnt = dao.insert(tmi);;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#contents{
	margin-left: 3%;
	padding-bottom: 2%;
}	#show{
	margin-left: 2%;
}#photo{
	position:fixed;
 	bottom: 50px;
    right: 2%;
    width: 80px;
 
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
<script src="../js/bootstrap.js"></script>
<body>

<!----------------- 네비게이션  시작-------------------->
	<jsp:include page ="/WEB-INF/nav/nav.jsp"/>
	<script>
		$(document).ready(function(){
			$('#tmi').addClass('active');
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

	
	<br>
	<%-- <%=tmi.toString()%>
 --%>	
 	<div id="contents">
		<h4><%=tmi.getUser_ID()%>님이 작성한
			<%=rcnt%>개의 이야기가 추가되었어요!
		</h4>
	</div>
	<a id="show"  href="tmiList.jsp">게시글 보러가기</a>
	<img id="photo" src="../img/fork.png">

	
</body>
</html>