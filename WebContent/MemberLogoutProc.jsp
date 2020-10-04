<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP게시판 웹사이트</title>
</head>
<body>
<% 
session.removeAttribute("id");
%>
<script>
	location.href = 'RentCarMain.jsp?center=MemberLogin.jsp';
</script>
</body>
</html>