<%@page import="model.BoardBean"%>
<%@page import="model.BoardDAO"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<center>
<br>
<br>
<font size="6" color="gray">자유게시판</font>
<br>
<br>
<br>
<br>
<!-- 게시판 페이징 -->

<%
	//화면에 보여질 게시글 갯수 지정
	int pageSize = 10;
	//현재 클릭한 페이징 번호 번호값 읽기
	String pageNum = request.getParameter("pageNum");
	//수정, 삭제 등을 마치면 BoardList로 바로 이동하는데 이때 pageNum이 없기애 null처리 필요
	if(pageNum == null) {
		pageNum = "1";
	}
	int count = 0; // 전체 게시글 수 저장 변수
	int number = 0; // 페이지 넘버링 변수
	int currentPage = Integer.parseInt(pageNum); // 현재 볼 페이징 숫자 저장

	//전체 게시글 jsp로 가져오기
	BoardDAO bdao = new BoardDAO();
	// 전체 게시글 수 읽어드린 메소드 호출
	count = bdao.getAllCount();
	
	// 현재 페이지에 보여줄 시작 페이지 설정
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage *pageSize;
	//전체 게시글 리턴 소스
	Vector<BoardBean> vec = bdao.getAllBoard(startRow, endRow);
	
	number = count - (currentPage -1) *pageSize;
%>











<table width="1200" border="1" bgcolor="bisque">
<tr hegiht="40">

</tr>
<tr height="40">
<td bgcolor="#585858" width="50" align="center"><font size="4" color="white">번호</font></td>
<td bgcolor="#585858" width="320" align="center"><font size="4" color="white">제목</font></td>
<td bgcolor="#585858" width="50" align="center"><font size="4" color="white">작성자</font></td>
<td bgcolor="#585858" width="150" align="center"><font size="4" color="white">작성일</font></td>
<td bgcolor="#585858" width="70" align="center"><font size="4" color="white">조회수</font></td>
</tr>

<% 
	//데이터 추출을 위한 for문
	for(int i = 0; i<vec.size(); i++) {
		BoardBean bean = vec.get(i); // 벡터에 저장된 빈클래스 하나씩 추출하기
%>
<tr height="40">
<td width="50" align="center"><%= number-- %></td>
<td width="320" align="left"><a href="RentCarMain.jsp?center=BoardInfo.jsp?num=<%=bean.getNum() %>" style="text-decoration:none;">
<%  //답글 들여쓰기
	if(bean.getRe_step() > 1) {
		for(int j=0; j < (bean.getRe_step()-1)*5; j++) {
%>&nbsp;
<% }

}
%>

<%=bean.getSubject() %></a></td>
<td width="50" align="center"><%=bean.getWriter() %></td>
<td width="150" align="center"><%=bean.getReg_date() %></td>
<td width="70" align="center"><%= bean.getReadcount()%></td>
</tr>
<%} %>

</table>
<p>
<br>
<br>

<!-- 페이지 카운팅 -->
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // 카운터 숫자 얼마까지 보여줄지 설정
				//시작페이지 설정
				int startPage = 1;
		if(currentPage % 10 != 0) {
			startPage=(int)(currentPage/10)*10+1;
		}else {
			startPage=((int)(currentPage/10)-1)*10+1;
		}
		int pageBlock = 10; //카운터링 처리숫자
		int endPage = startPage+pageBlock-1;
		
		if(endPage > pageCount) endPage = pageCount;
		//이전 버튼 만들기
		if(startPage > 10){
%>			
	<a href="BoardList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<%
		} //페이징 처리
		for(int i = startPage; i <= pageCount; i++) {
%>		
	<a href="BoardList.jsp?pageNum=<%=i%>">[<%=i %>]</a>	
<% 
		}
		//다음 버튼 만들기
		if(endPage < pageCount) {
%>			
	<a href="BoardList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<% 
		} 
	}
%>
</center>
<br>
<input style="background-color: #7F0B0B; color: white; font-size:15px;" type="button" value="게시판 작성" onclick="location.href='RentCarMain.jsp?center=BoardWriteForm.jsp'">
</body>
</html>