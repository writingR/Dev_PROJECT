<%@page import="tmiService.UpdateService"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="tmi.TmiDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%
	String uId = request.getParameter("uId");
	String tId = request.getParameter("tId");
	String tTitle = request.getParameter("tTitle");
	String tContent = request.getParameter("tContent");

	UpdateService service=UpdateService.getInstance();

	boolean chkResult = service.chkResult(uId, tId);

	if (tTitle.isEmpty()) {
		out.print("NT");
	} else if (tContent.isEmpty()) {
		out.print("NC");
	} else if (!tTitle.isEmpty() && !tContent.isEmpty() && chkResult) {
		service.updateTmi(tId, tTitle, tContent);
		out.print("Y");
	}else {
		out.print("N");
	}
%>