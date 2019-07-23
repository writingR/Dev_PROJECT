<%@page import="tmiService.DeleteService"%>
<%@page import="jdbc.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="tmi.TmiDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%
	String uId = request.getParameter("uId");
	String tId = request.getParameter("tId");
	
	
	DeleteService service= DeleteService.getInstance();
	boolean chkResult=service.chkResult(uId, tId);
	if (chkResult) {
		service.deleteTmi(tId);
		out.print("Y");
	} else {
		out.print("N");
	}
%>