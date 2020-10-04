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
<center>
<body>
<%
	String center = request.getParameter("center");
	if(center == null) {
		center = "Center.jsp"; //디폴트 center값 부여
	}
%>
<table width="1000">
	<!-- Top -->
	<tr height="120" aligh="center">
	<td align="center" width="1000"><jsp:include page="Top.jsp"/><td>
	</tr>
	
	<!-- Center -->
	<tr aligh="center">
	<td align="center" width="1000"><jsp:include page="<%=center %>"/><td>
	</tr>
	
	<!-- Bottom -->
	<tr height="100" aligh="center">
	<td align="center" width="1000"><jsp:include page="Bottom.jsp"/><td>
	</tr>
</table>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="js/bootstrap.js"></script>
</body>
</center>
</html>