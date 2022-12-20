<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.BuyDTO"%>
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
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	String pageNum = request.getParameter("pageNum");
	BuyDAO dao = new BuyDAO();
	dao.changeDelcon(bnum);
	
	response.sendRedirect("delSellListForm.jsp?pageNum="+pageNum);
%>
<body>

</body>
</html>