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
<center>
<body>
<!-- DB연결 후 최신순 파일 3개 가져오기 -->
<%
	RentCarDAO rdao = new RentCarDAO();
	//벡터를 이용해 저장
	Vector<CarListBean> v = rdao.getSelectCar();
%>
<table width="1200">
<tr height="100">
<td align="center" colspan="3">
<font size="6" color="gray">Top 3 렌트카</font>
</td>
</tr>
<%
	for(int i=0; i< v.size(); i++) {
	CarListBean bean = v.get(i);
%>
<td width="400" align="center">
<a href="RentCarMain.jsp?center=CarReserveInfo.jsp?no=<%=bean.getNo()%>">
<img src="image/<%= bean.getImg()%>" width="400" height="350"></a><p><br>
차량명  :  <%=bean.getName() %>
</td>
<%
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
<!-- <button style="background-color: #7F0B0B; color: white; font-size:25px; padding:20px 10px" onclick="location.href='RentCarMain.jsp?center=CarAllList.jsp'">전체차량보기</button>
 --></body>
</center>
</html>