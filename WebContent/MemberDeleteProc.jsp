<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="mbean" class="model.MemberBean">
<jsp:setProperty name="mbean" property="*"/> 
</jsp:useBean>
<%

MemberDAO mdao = new MemberDAO();
//스트링 타입으로 저장된 비밀번호를 가져옴 //db에서 가져온 비밀번호 저장	
String pass = mdao.getPass(mbean.getId());

//기존 패스워드와 수정을 위해 입력한 패스워드 비교
if(mbean.getPass1().equals(pass)) { //일치하면 테이블 수정
	mdao.deleteMember(mbean.getId());
	response.sendRedirect("MemberList.jsp");
	
}else {
%>	
<script type="text/javascript">
alert("비밀번호가 틀립니다");
history.go(-1);
</script>
<% 
}
%>

</body>
</html>