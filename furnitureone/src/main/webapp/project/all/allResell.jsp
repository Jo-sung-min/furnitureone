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
	String id = (String)session.getAttribute("memId");
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	ProductDAO dao = new ProductDAO();
	dao.allResell(id);
%>
<script >
	alert("판매가 재개 되었습니다.");
	window.location="uploadListForm.jsp?pageNum=<%=pageNum%>";
</script>
<body>

</body>
</html>