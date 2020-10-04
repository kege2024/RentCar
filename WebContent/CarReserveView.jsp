<%@page import="db.CarViewBean"%>
<%@page import="db.CarReserveBean"%>
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
	String id = (String)session.getAttribute("id");
	if(id == null){
		
	
%>
<script>
	alert("로그인이 필요합니다");
	location.href="RentCarMain.jsp?center=MemberLogin.jsp";
</script>
<%
	}
	//로그인 되어있는 아이디 읽어오기
	RentCarDAO rdao = new RentCarDAO();
	Vector<CarViewBean> v = rdao.getAllReserve(id);
%>
<center>
<table width="1200" border="1">
<tr height="100">
<br>
<br>
<font size="6" color="gray">차량예약화면</font>
</tr>
<tr height="40">
<div class="tablestyle">
<td bgcolor="#585858" width="140" align="center"><font size="4" color="white">차량이미지</font></td>
<td bgcolor="#585858" width="140" align="center"><font size="4" color="white">차량명</font></td>
<td bgcolor="#585858"" width="140" align="center"><font size="4" color="white">대여일</font></td>
<td bgcolor="#585858" width="60" align="center"><font size="4" color="white">대여기간</font></td>
<td bgcolor="#585858" width="80" align="center"><font size="4" color="white">차량금액</font></td>
<td bgcolor="#585858" width="80" align="center"><font size="4" color="white">차량수량</font></td>
<td bgcolor="#585858" width="80" align="center"><font size="4" color="white">보험</font></td>
<td bgcolor="#585858" width="80" align="center"><font size="4" color="white">wift</font></td>
<td bgcolor="#585858" width="80" align="center"><font size="4" color="white">베이비시트</font></td>
<td bgcolor="#585858" width="80" align="center"><font size="4" color="white">네비게이션</font></td>
<td bgcolor="#585858" width="60" align="center"><font size="4" color="white">삭제</font></td>
</div>
</tr>
<%
	for(int i=0; i<v.size(); i++) {
		CarViewBean bean = v.get(i);
%>
<tr height="60">
<td width="150" align="center"><img src="image/<%=bean.getImg() %>" width="120" height="70"></td>
<td width="150" align="center"><%=bean.getName() %></td>
<td width="150" align="center"><%=bean.getRday() %></td>
<td width="60" align="center"><%=bean.getDday() %></td>
<td width="100" align="center"><%=bean.getPrice() %>원</td>
<td width="60" align="center"><%=bean.getQty() %></td>
<td width="60" align="center"><%=bean.getUsein() %></td>
<td width="60" align="center"><%=bean.getUsewifi() %></td>
<td width="60" align="center"><%=bean.getUseseat() %></td>
<td width="60" align="center"><%=bean.getUsenavi() %></td>
<td width="90" align="center"><button onclick="location.href='CarReserveDel.jsp?id=<%=id%>&rday=<%=bean.getRday()%>'">삭제</td>
</tr>
<%
	}
%>
</table>
</center>
</body>
</html>