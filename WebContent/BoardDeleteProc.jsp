<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
	String pass = request.getParameter("password");
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDAO bdao = new BoardDAO();
	String password = bdao.getPass(num);

	if(pass.equals(password)) {
		bdao.deleteBoard(num);
		response.sendRedirect("RentCarMain.jsp?center=BoardList.jsp");
	}	else {
%>
<script>
	alert("패스워드가 틀립니다");
	history.go(-1);
</script>		
<% 
	}
%>
</body>
</html>