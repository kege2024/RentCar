<%@page import="java.util.Vector"%>
<%@page import="db.CarListBean"%>
<%@page import="db.RentCarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<center>
<table width="14500">
<tr height="100">
<td align="center" colspan="3">
<font size="6" color="gray">전체 자동차</font>
</td>
</tr>
<%
		
		RentCarDAO rdao = new RentCarDAO();
		Vector<CarListBean> v = rdao.getAllCar();

		//tr을 3개씩 보여주고 다시 tr보여주는 로직
		int j = 0;
		for(int i=0; i<v.size(); i++) {
			
			CarListBean bean = v.get(i);
			if(j%3==0) {
%>	
<tr height="220">		
		<% } %>
	<td width="400" align="center">
	<a href="RentCarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo() %>">
	<img src="image/<%=bean.getImg() %>" width="400" height="200">
	</a><p>
	<font size="3" color="gray"></font> <b>차량명  :  <%=bean.getName() %></b></font></td>
	<% 
	j=j+1; // j값을 증가시켜 하나의 행에 3개씩 보여주게 함
		}
%>
</table>
</center>
</body>
</html>