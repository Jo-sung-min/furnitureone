<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
%>
<jsp:useBean id="dto" class="web.team.one.ProductDTO"/>
<%
	String path = request.getRealPath("oneimg");
	int max = 1024*1024*5;
	String enc="utf-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	
	dto.setPimg(mr.getFilesystemName("pimg").trim());
	dto.setPname(mr.getParameter("pname").trim());
	dto.setPprice(Integer.parseInt(mr.getParameter("pprice").trim()));
	dto.setPcolor(mr.getParameter("pcolor").trim());
	dto.setPtype(mr.getParameter("ptype").trim());
	dto.setPstock(Integer.parseInt(mr.getParameter("pstock").trim()));
	dto.setPcontent(mr.getParameter("pcontent").trim());
	dto.setMid(id);
	
	
	ProductDAO dao = new ProductDAO();
	dao.insertProduct(dto);
	
	response.sendRedirect("uploadListForm.jsp");
	
%>
<script>
	
</script>
<body>
	
</body>
</html>