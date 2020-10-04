<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.MemberDAO" %>
<%@ page import="model.MemberBean" %>
<%@ page import="java.util.Vector" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<!-- 
	1. db에서 모든 회원정보 가져오기
	2. 테이블 태그로 화면에 출력하기 -->


<%
	MemberDAO mdao = new MemberDAO();
	//회원정보 리스트가 가변적이므로 vector를 이용해 데이터 저장
	Vector<MemberBean> vec = mdao.allSelectMember();



%>


<center>
<h2>모든 회원보기</h2>
<table width="800" border="1">
<tr height="50">
<td align="center" width="150">아이디</td>
<td align="center" width="250">이메일</td>
<td align="center" width="150">전화번호</td>
<td align="center" width="150">취미</td>
</tr>
<%
	for(int i=0; i< vec.size(); i++) {
		MemberBean bean = vec.get(i); //벡터에 담긴 빈클래스 하나씩 추출하기
	
%>
<tr height="50">
<td align="center" width="150">
<a href="MemberInfo.jsp?id=<%= bean.getId() %>">
<%= bean.getId() %></a></td>
<td align="center" width="250"><%= bean.getEmail() %></td>
<td align="center" width="150"><%= bean.getTel() %></td>
<td align="center" width="150"><%= bean.getHobby() %></td>
</tr>
<% } %>
</table>
</center>




</body>
</html>