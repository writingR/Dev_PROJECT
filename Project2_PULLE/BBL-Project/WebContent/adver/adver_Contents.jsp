<%@page import="adver.model.Adver"%>
<%@page import="adver.model.AdverListView"%>
<%@page import="adver.service.GetAdverListService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int pageNumber = Integer.parseInt(request.getParameter("pageNum"));

	//핵심처리할 서비스 객체
	GetAdverListService service = GetAdverListService.getInstance();

	//응답 데이터
	AdverListView viewData = service.getAdverListView(pageNumber);
%>
<%
	for (Adver adver : viewData.getAdverList()) {
%>
	<div class="col-sm-4">
				<div class="card">
					<div class="card-body">
						<div class="card-header">
							<p>
								no.
								<%=adver.getAdver_ID()%></p>
							<p>
								date.
								<%=adver.getAdver_Date()%></p>
							<a href="adver_Content.jsp?adverId=<%=adver.getAdver_ID()%>"><%=adver.getAdver_Title()%></a>
						</div>

						<img class="card-img-top" style="width: 100%; height: 250px;"
							src="../adver_upload/<%=adver.getAdver_Photo()%>">
					</div>
				</div>
			</div>
		<br>
	<%
		}
	%>