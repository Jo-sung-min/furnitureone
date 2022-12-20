<%@page import="web.team.one.InquiryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	int inum = Integer.parseInt(request.getParameter("inum"));
	String answer = request.getParameter("answer");
	
	InquiryDAO inDAO = new InquiryDAO();
	inDAO.insertAnswer(inum,answer);
	
	response.sendRedirect("myQuestionList.jsp");
%>
	
<body>

</body>
</html> 