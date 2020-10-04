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
	request.setCharacterEncoding("UTF-8");
%>

<!-- 데이터를 한번에 받아오는 빈클래스 사용 -->
<jsp:useBean id="boardbean" class="model.BoardBean">
<jsp:setProperty name="boardbean" property="*" />
</jsp:useBean>

<%
	BoardDAO bdao = new BoardDAO();
	bdao.reWriteBoard(boardbean);
	
	//답변 데이터 모두 저장 후 전체 게시글 보기로 이동
	response.sendRedirect("RentCarMain.jsp?center=BoardList.jsp");
%>
</body>
</html>