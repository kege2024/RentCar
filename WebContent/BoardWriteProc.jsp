<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="boardbean" class="model.BoardBean">
<jsp:setProperty name="boardbean" property="*" />
</jsp:useBean>

<%
	BoardDAO bdao = new BoardDAO(); //db로 빈클래스 넘겨주기

	bdao.insertBoard(boardbean); 
	
	//작성된 게시글 저장후 전체게시판 보기
	response.sendRedirect("RentCarMain.jsp?center=BoardList.jsp");
%>
</body>
</html>