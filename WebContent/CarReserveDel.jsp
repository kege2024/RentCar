<%@page import="db.RentCarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
	String id = request.getParameter("id");
	String rday = request.getParameter("rday");
	
	RentCarDAO rdao = new RentCarDAO();
	rdao.carRemoveReserve(id, rday);
	response.sendRedirect("RentCarMain.jsp");
%>
</body>
</html>