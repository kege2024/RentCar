<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
</head>
<body>
<!-- 세션을 이용한 로그인처리 -->
<%
	String id = (String)session.getAttribute("id");
	if(id==null) {
		id="GUEST";
	}
%>

<table width="1200" borderColor="white">
<tr height="100">
<td colspan="2">
<a href="RentCarMain.jsp" style="text-decoration:none">
<img src="image/logo.jpg" height="65"></a>
<a href="/RentCar/index2.jsp" style="text-decoration:none"><font size="4" color="#7F0B0B">메인페이지 이동</font></a>
</td>
<td align="center" colspan="1">
<a href="RentCarMain.jsp" style="text-decoration:none"><font size="8" color="#7F0B0B">Rent Car</font></a>
</td>
<td colspan="2" align="right" width="200"><%=id %>님
<%
	if(id.equals("GUEST")) { %>
		<button type="button" class="btn btn-light" onclick="location.href='RentCarMain.jsp?center=MemberLogin.jsp'">로그인</button>
<%
	}else{ %>
		<button type="button" class="btn btn-light" onclick="location.href='MemberLogoutProc.jsp'">로그아웃</button>
<%
}
%>
<button type="button" class="btn btn-light" onclick="location.href='RentCarMain.jsp?center=MemberJoin.jsp'">회원가입</button>


</td>

</tr>

<tr height="50">
<td class="menubar" align="center" width="200" >
<a class="menubartext" href="RentCarMain.jsp?center=CarReserveMain.jsp" style="text-decoration:none">예 약 하 기</a>
</td>
<td class="menubar" align="center" width="200" >
<a class="menubartext" href="RentCarMain.jsp?center=CarReserveView.jsp" style="text-decoration:none">예 약 확 인</a>
</td>
<td class="menubar" align="center" width="200" >
<a class="menubartext" href="RentCarMain.jsp?center=BoardList.jsp" style="text-decoration:none">자 유 게 시 판</a>
</td>
<td class="menubar" align="center" width="200" >
<a class="menubartext" href="RentCarMain.jsp?center=CarEvent.jsp" style="text-decoration:none">이 벤 트</a>
</td>
<td class="menubar" align="center" width="200" >
<a class="menubartext" href="#" style="text-decoration:none">고 객 센 터</a>
</td>
</tr>

</table>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="js/bootstrap.js"></script>
</body>
</html>