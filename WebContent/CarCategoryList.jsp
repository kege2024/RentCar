<%@page import="db.CarListBean"%>
<%@page import="java.util.Vector"%>
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
int category = Integer.parseInt(request.getParameter("category"));
String temp = "";
if(category == 1) temp="소형";
else if(category==2)temp="중형";
else if(category==3)temp="대형";
%>
<center>
<table width="1000">
<tr height="100">
<td align="center" colspan="3">
<font size="6" color="gray"><%=temp %>자동차</font>
</td>
</tr>
<%
		//카테고리 분류값 가져오기
		RentCarDAO rdao = new RentCarDAO();
		Vector<CarListBean> v = rdao.getCategoryCar(category);

		//tr을 3개씩 보여주고 다시 tr보여주는 로직
		int j = 0;
		for(int i=0; i<v.size(); i++) {
			
			CarListBean bean = v.get(i);
			if(j%3==0) {
%>	
<tr height="220">		
		<% } %>
	<td width="333" align="center">
	<a href="RentCarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo() %>">
	<img src="image/<%=bean.getImg() %>" width="300" height="200">
	</a><p>
	<font size="3" color="gray"></font> <b>차량명:<%=bean.getName() %></b></font></td>
	<% 
	j=j+1; // j값을 증가시켜 하나의 행에 3개씩 보여주게 함
		}
%>
</table>
<br>
<br>
<br>
<p>
<font size="6" color="gray"><b>차량검색하기</b></font> <br><br><br>
<form action="RentCarMain.jsp?center=CarCategoryList.jsp" method="post">
<font size="3" color="gray"><b>차량검색</b></font> &nbsp;&nbsp;
<select name="category">
<option value="1">소형</option>
<option value="2">중형</option>
<option value="3">대형</option>
</select> &nbsp;&nbsp;
<input type="submit" value="검색"> &nbsp;&nbsp;
</form>
<br>
<br>
<button style="background-color: #7F0B0B; color: white; font-size:25px; padding:20px 10px" onclick="location.href='RentCarMain.jsp?center=CarAllList.jsp'">전체차량보기</button>
</center>
</body>
</html>