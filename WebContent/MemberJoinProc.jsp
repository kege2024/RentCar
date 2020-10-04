<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="model.MemberDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
	

	//다중선택은 별도로 읽어 빈클래스에 저장시킴 //배열로 담은 후 하나의 String으로 저장
	String []hobby = request.getParameterValues("hobby");
	String texthobby = "";
	for(int i=0; i<hobby.length; i++) {
		texthobby += hobby[i]+" ";
	}
%>


<jsp:useBean id="mbean" class="model.MemberBean">
<jsp:setProperty name="mbean" property="*" />
</jsp:useBean>


<% 
	mbean.setHobby(texthobby); //하나의 String으로 저장한 hobby를 다시 입력해줌

	MemberDAO mdao = new MemberDAO();
	mdao.insertMember(mbean);
	
	// 회원가입 후 회원정보 리스트 페이지로 이동
	response.sendRedirect("RentCarMain.jsp?center=MemberList.jsp");
%>
오라클 성공
</body>
</html>