<%@page import="web.team.one.SellregisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <title>sellApproveForm</title>
 <link rel="stylesheet" href="./basic.css" />
 <link rel="stylesheet" href="./style.css" />
</head>
<%
	int mnum= Integer.parseInt(request.getParameter("mnum"));
	int pageNum= Integer.parseInt(request.getParameter("pageNum"));
	
	SellregisDAO sellDAO = new SellregisDAO();
	sellDAO.approveRegis(mnum);
	
	response.sendRedirect("sellRegisListForm.jsp?pageNum="+pageNum);
	
%>
<body>

</body>
</html> 