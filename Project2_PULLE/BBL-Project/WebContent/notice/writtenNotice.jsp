<%@page import="notice.service.WriteNoticeService"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="notice.model.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Notice notice = new Notice();

	notice.setUser_ID((String)session.getAttribute("userID"));

	String fileName = "";
	String saveFileName = "";
	long fileSize = 0;
	String uploadPath = "/upload";
	String dir = request.getSession().getServletContext().getRealPath(uploadPath);
	
	
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	DiskFileItemFactory factory = new DiskFileItemFactory();
	
	ServletFileUpload upload = new ServletFileUpload(factory);
	
	// FileItem <- 폼 페이지에서 전송한 데이터들  , uName, sNumber, report
	List<FileItem> items= upload.parseRequest(request);
	
	Iterator<FileItem> itr = items.iterator();
	while(itr.hasNext()){
		
		FileItem item = itr.next();
		
		if(item.isFormField()){
			// type="file" 이 아닌경우
			
			if(item.getFieldName().equals("title")){
				/* name = item.getString("utf-8"); */
				notice.setTitle(item.getString("utf-8"));
			}
			
			if(item.getFieldName().equals("con")){
				/* sNum = item.getString("utf-8"); */
				notice.setCon(item.getString("utf-8"));
			}
					
					
		} else {
			// type="file" 인 경우
			if(item.getFieldName().equals("photo")){
				// 파일 이름
				fileName = item.getName();
				fileSize = item.getSize();
				// saveFileName = System.currentTimeMillis()+"_"+fileName;
				saveFileName = System.nanoTime()+"_"+fileName;
				item.write(new File(dir, saveFileName));
				notice.setPhoto(saveFileName);
			}
		}
		
	}	
%>
<%
	/* writeNoticeAction */
	WriteNoticeService service = WriteNoticeService.getInstance();
	int rCnt = service.write(notice);
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
		<br>
		<hr>
		<%-- <div id="view">
			<div id="title">
			 <%=notice.getTitle()%>
			</div>
			<div id="cons">
				<img src="../upload/<%=saveFileName%>" width="90%"><br>
				<%=notice.getCon()%>
			</div>
		</div>
		<div id="btn">
			<a href="noticeList.jsp"><input type="submit" name="list"
				value="목록"></a>
		</div> --%>
		<h4>공지사항이 작성되었습니다!</h4>
	</div>
		<script>
		$(document).ready(function() {
			setTimeout(function() {

				location.href = "noticeList.jsp";
			}, 1000);
		})
	</script>
	<br>
	<br>
	<img src="../img/fork.png" id="fork">
</body>
</html>