<%@page import="mainpage.model.MainPage"%>
<%@page import="mainpage.model.MainPageList"%>
<%@page import="mainpage.service.GetMainPageListService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int pageNumber = Integer.parseInt(request.getParameter("pageNum"));

	//핵심처리할 서비스 객체
	GetMainPageListService service = GetMainPageListService.getInstance();
	MainPageList dataList = null;
	if(pageNumber==1){
		dataList = service.getMainPageList(pageNumber, 9);
	}else{
		dataList = service.getMainPageList(pageNumber, 3);
	}
	//응답 데이터의 결과
	
%>

<% for(MainPage mainpage : dataList.getMainpageList()){ %>
				<li class="posts">
					<div class="stPosts">
						<div class="posts-text">
							<div class="posts-user">
								<%= mainpage.getUser_ID() %>
								<div class="posts-edit ">
									<a class="mainATag2" href="BBLDelete.jsp?mainpageId=<%= mainpage.getMainpage_ID() %>" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
									<a class="mainATag2" href="BBLEdit.jsp?mainpageId=<%= mainpage.getMainpage_ID() %>">편집</a>
								</div>
							</div>
							<div class="posts-content"><%if(mainpage.getMainpage_Content()!=null){if(mainpage.getMainpage_Content().length()>100){out.print(mainpage.getMainpage_Content().substring(0, 100)+"...");}else{out.print(mainpage.getMainpage_Content());}} %></div>
							<div class="posts-title"><a class="mainATag" href="BBLContent.jsp?mainpageId=<%= mainpage.getMainpage_ID() %>"><%= mainpage.getMainpage_Title() %></a></div>
							<div class="date"><%= mainpage.getMainpage_Date() %></div>
						</div>
						<div class="posts-photo">
							<img src='../mainpage_photo/<% if(mainpage.getMainpage_Photo()!=null){out.print(mainpage.getMainpage_Photo());}else{out.print("noImg.jpg");}%>' class="thumbnail">
							
						</div>
						

					</div>
				</li> 
			<% } %>