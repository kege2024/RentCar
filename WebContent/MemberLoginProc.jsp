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
		request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	RentCarDAO rdao = new RentCarDAO();//회원아이디와 패스워드 일치하는지 비교
	
	int result = rdao.getMember(id, pass);
	if(result == 0) {
	%>
	<script>
	alert("아이디 또는 비밀번호 오류");
	location.href="RentCarMain.jsp?center=MemberLogin.jsp";
	</script>
	<%
	}else {
	session.setAttribute("id", id);
	response.sendRedirect("RentCarMain.jsp");
	}
	%>
	
</body>
</html>