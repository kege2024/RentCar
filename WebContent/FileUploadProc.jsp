<%-- <%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	String realfolder="";
	String savefolder="/upload"; //저장될 파일 폴더
	String encType="UTF-8"; //한글인코딩
	int maxSize = 1024*1024*5; // 5메가
	ServletContext context = getServletContext();
	realfolder = context.getRealPath(savefolder); //하위폴더
	
	try{
		MultipartRequest multi = new MultipartRequest(request, realfolder, maxSize, encType,
				new DefaultFileRenamePolicy()); // 파일이름변경 자동
%>
당신의 이름은 <%=multi.getParameter("name") %>	
<% 
	out.println(realfolder);
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html> --%>