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
<%
	int no = Integer.parseInt(request.getParameter("no"));

	//db접근
	RentCarDAO rdao = new RentCarDAO();
	CarListBean bean = rdao.getOneCar(no);
	
	int category = bean.getCategory();
	String temp = "";
	if(category == 1) temp="소형";
	else if(category==2)temp="중형";
	else if(category==3)temp="대형";
%>
<center>
<form action="RentCarMain.jsp?center=CarOptionSelect.jsp" method="post">
<table width="1040">
	<tr height="100">
<td align="center" colspan="3">
<font size="6" color="gray"><%=bean.getName() %>차량선택</font>
</td>
</tr>
<tr>
<td rowspan="6" width="500">
<img src="image/<%=bean.getImg() %>" width="450"></td>
<td width="250" align="center">차량 이름</td>
<td width="250" align="center"><%=bean.getName() %></td>
</tr>
<tr>
<td width="250" align="center">차량 수량</td>
<td width="250" align="center"><select name="qty">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
</select></td>
</tr>
<tr>
<td width="250" align="center">차량 분류</td>
<td width="250" align="center"><%=temp%></td>
</tr>
<tr>
<td width="250" align="center">대여 가격</td>
<td width="250" align="center"><%=bean.getPrice() %></td>
</tr>
<tr>
<td width="250" align="center">제조 회사</td>
<td width="250" align="center"><%=bean.getCompany() %></td>
</tr>
<tr>
<td align="center" colspan="2">
<input type="hidden" name="no" value="<%=bean.getNo() %>">
<input type="hidden" name="img" value="<%=bean.getImg() %>">
<input type="submit" value="옵션선택 후 구매하기">
</table>
<br><br><br>
<font size="6" color="gray">차량 정보보기</font>
<p>
<%=bean.getInfo() %>
</p>
</form>
</center>
</body>
</html>