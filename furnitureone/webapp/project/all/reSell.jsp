<%@page import="web.team.one.ProductDAO"%>
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
%>
<jsp:useBean id="dto" class="web.team.one.ProductDTO"/>
<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));	

	ProductDAO dao = new ProductDAO();
	dao.reSell(pnum);
	String pageNum = request.getParameter("pageNum");
	response.sendRedirect("uploadListForm.jsp?pageNum="+pageNum);
%>
<body>

</body>
</html>