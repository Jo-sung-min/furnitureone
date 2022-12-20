<%@page import="web.team.one.HwanDAO"%>
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
	int hnum = Integer.parseInt(request.getParameter("hnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int number = Integer.parseInt(request.getParameter("number"));
	HwanDAO dao = new HwanDAO();
	if(number == 0){
		dao.hwanOk(hnum);
	}else{
		dao.hwanNo(hnum);
	}
	response.sendRedirect("hwanListForm.jsp?pageNum="+pageNum);
%>
<body>
 
</body>
</html>