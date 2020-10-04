<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="board.Board" %>
    <%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP게시판 웹사이트</title>
</head>
<body>
<%
String userID = null;
if(session.getAttribute("userID") != null) {
	userID = (String) session.getAttribute("userID");
}
if(userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다')");
	script.println("location.href = 'login.jsp'");
	script.println("</script>");
} 
int boardID = 0;
if(request.getParameter("boardID") != null) {
	 boardID = Integer.parseInt(request.getParameter("boardID"));
}
if(boardID == 0) {
	 PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
}
Board board = new BoardDAO().getBbs(boardID);

if(!userID.equals(board.getUserID())) {
	 PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
}else {
	if (request.getParameter("boardTitle") == null || request.getParameter("boardContent") == null
			|| request.getParameter("boardTitle").equals("") || request.getParameter("boardContent").equals(""))  {
				PrintWriter script = response.getWriter(); 
				script.println("<script>");
				script.println("alert('입력이 안된 항목이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				BoardDAO boardDAO = new BoardDAO();
				int result = boardDAO.update(boardID, request.getParameter("boardTitle"),request.getParameter("boardContent"));
				if(result == -1) {
					PrintWriter script = response.getWriter(); 
					script.println("<script>");
					script.println("alert('수정 실패')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter(); 
					script.println("<script>");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
			}
}
	
	

%>
</body>
</html>