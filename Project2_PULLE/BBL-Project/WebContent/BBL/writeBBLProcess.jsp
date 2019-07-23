<%@page import="mainpage.service.WriteMainpageService"%>
<%@page import="org.apache.commons.fileupload.FileUploadBase.InvalidContentTypeException"%>
<%@page import="mainpage.model.MainPage"%>
<%@page import="java.io.File"%>
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
	try{
		
		MainPage mainpage = new MainPage(); 
	
		//session id 저장필요
		String userId = (String)session.getAttribute("userID");
		mainpage.setUser_ID(userId);
	
		String fileName = "";
		String saveFileName="";
		long fileSize = 0;
		String path = "/mainpage_photo";
		String dir = request.getSession().getServletContext().getRealPath(path);
		
		
		boolean isMulitpart = ServletFileUpload.isMultipartContent(request);
	
		DiskFileItemFactory factory = new DiskFileItemFactory();
	
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		//FileItem <- 홈 페이지에서 전송한 데이터들을 가져온다. uName, sNumber, report 
		List<FileItem> items = upload.parseRequest(request);
		
		Iterator<FileItem> itr = items.iterator();
		
		while(itr.hasNext()){
			FileItem item = itr.next();
			
			if(item.isFormField()){
				//타입="file"이 아닌경우
				if(item.getFieldName().equals("mainpage_Title")){
					mainpage.setMainpage_Title(item.getString("utf-8"));
				}
				if(item.getFieldName().equals("mainpage_Content")){
					mainpage.setMainpage_Content(item.getString("utf-8"));
				}
				if(item.getFieldName().equals("mainpage_Loc")){
					mainpage.setMainpage_Loc(item.getString("utf-8"));
				}
			}else{
				//타입="file"인 경우
				if(item.getFieldName().equals("mainpage_Photo")){
					//파일 이름
					fileName = item.getName();
					fileSize = item.getSize();
					//saveFileName = System.currentTimeMillis()+"_"+fileName;
					saveFileName = userId+"_"+System.nanoTime()+"_"+fileName;
					
					if(fileName!=null && !fileName.isEmpty()){
						mainpage.setMainpage_Photo(saveFileName);
						item.write(new File(dir, saveFileName));
					}
				}
			}
			
		}
		WriteMainpageService write = WriteMainpageService.getInstance();
		
		int cnt = write.write(mainpage);
			
		System.out.println(dir);
	
%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#wrap{
		width: 960px;
		height: 400px;
		position: absolute;
		top:50%;
		left:50%;
		margin-top: -200px;
		margin-left: -480px;
		text-align: center;
	}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<div id="wrap">
	<img src="../img/Pacman200px.gif">
	<% if(cnt>0){ %>
	<h1>작성이 완료되었습니다.</h1>
	<h2>잠시 후 페이지로 이동합니다.</h2>
	<% }else { %>
	<h1>작성이 실패했습다.</h1>
	<h2>로그인 후 이용해주세요.</h2>
	<h2>잠시 후 페이지로 이동합니다.</h2>
	<% }%>
</div>

<script>
	$(document).ready(function () {
	        	setTimeout(function(){
					location.href = "BBL.jsp";
	        	}, 1000);
	    });
</script>
</body>
</html>


<%
	}catch(InvalidContentTypeException e){
		e.printStackTrace();
		response.sendRedirect("BBL.jsp");
	}
%>
