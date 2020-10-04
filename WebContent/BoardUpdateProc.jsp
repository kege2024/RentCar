<%@page import="model.BoardDAO"%>


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
<!-- 사용자 데이터를 읽는 빈클래스 설정 -->
<jsp:useBean id="boardbean" class="model.BoardBean">
<jsp:setProperty name="boardbean" property="*" />
</jsp:useBean>
<%
	BoardDAO bdao = new BoardDAO();
	//해당 게시글 패스워드값 얻어오기
	String pass = bdao.getPass(boardbean.getNum());

	//기존 패스와 수정시 입력한 패스가 같은지 비교
	if(pass.equals(boardbean.getPassword())){
		bdao.updateBoard(boardbean);
		//수정 완료 후 전체 게시글로 이동
		response.sendRedirect("RentCarMain.jsp?center=BoardList.jsp");
	} else { //패스워드 다를시
%>
<script type="text/javascript">
	alert("패스워드가 틀립니다");
	history.go(-1);
</script>
<% 
	}
%> 
</body>
</html>