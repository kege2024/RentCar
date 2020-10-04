<%@page import="db.CarListBean"%>
<%@page import="db.RentCarDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
<jsp:useBean id="rbean" class="db.CarReserveBean">
<jsp:setProperty name="rbean" property="*" />
</jsp:useBean>
<% 
	String id = (String)session.getAttribute("id");

	if(id==null)
	{
%>
<script>
alert("로그인 후 이용가능합니다");
location.href='RentCarMain.jsp?center=MemberLogin.jsp';
</script>

<%
	}
	
	//날짜 비교하기
	Date d1 = new Date();
	Date d2 = new Date();
	//날짜 포맷해주는 클래스 선언
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	d1 = sdf.parse(rbean.getRday());
	d2 = sdf.parse(sdf.format(d2));
	
	int compare = d1.compareTo(d2);
	//예약 날짜보다 현재날짜가 크면 -1
	//예약 날짜가 현재날짜와 같으면 0
	//예약 날짜가 더 크면 1
	if(compare < 0) { //오늘보다 적은 날짜 선택시
		%>
		<script>
		alert("현재날짜보다 이전 날짜는 선택불가합니다");
		history.go(-1);
		</script>

		<%
	}
	//id 값이 bean클래스에 없기에  가져와야함
	String id1 = (String)session.getAttribute("id");
	rbean.setId(id1);
	//db에 bean클래스 저장하기
	RentCarDAO rdao = new RentCarDAO();
	rdao.setReserveCar(rbean);
	
	CarListBean cbean = rdao.getOneCar(rbean.getNo());
	int totalcar = cbean.getPrice()*rbean.getQty()*rbean.getDday();
	
	int usein = 0;
	if(rbean.getUsein()==1)usein=10000;
	int usewifi = 0;
	if(rbean.getUsein()==1)usewifi=10000;
	int useseat = 0;
	if(rbean.getUsein()==1)useseat=10000;	
	
	int totaloption = (rbean.getQty()*rbean.getDday())*(usein+usewifi+useseat);
%>
<center>
<table width="1040">
<tr height="100">
<td align="center">
<font size="6" color="gray">차량예약 완료화면</font></td>
</tr>
<tr>
<td align="center">
<img src="image/<%=cbean.getImg() %>" width="470"></td>
</tr>
<tr>
<td align="center">
<font size="5" color="red">차량 금액<%=totalcar %>원</font></td>
</tr>
<tr>
<td align="center">
<font size="5" color="red">차량 옵션 금액<%=totaloption %>원</font></td>
</tr>
<tr>
<td align="center">
<font size="5" color="red">전체가격<%=totaloption + totalcar %>원</font></td>
</tr>
</table>
</center>
</body>
</html>