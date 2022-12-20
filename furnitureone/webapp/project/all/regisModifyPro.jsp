<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
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
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String id = (String)session.getAttribute("memId");
	String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="dto" class="web.team.one.ProductDTO"/>
<%
	String path = request.getRealPath("oneimg");
	int max = 1024*1024*5;
	String enc="utf-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
	
	ProductDAO dao = new ProductDAO();
	dto = dao.getOneProduct(pnum);
	String pw = mr.getParameter("mpw");
	
	if(mr.getFilesystemName("pimg") != null){
		dto.setPimg(mr.getFilesystemName("pimg").trim());
	}else{
		dto.setPimg(dto.getPimg());
	}
	dto.setPname(mr.getParameter("pname").trim());
	dto.setPprice(Integer.parseInt(mr.getParameter("pprice").trim()));
	dto.setPstock(Integer.parseInt(mr.getParameter("pstock").trim()));
	dto.setPcontent(mr.getParameter("pcontent").trim());
	
	
	MemberDAO memDAO = new MemberDAO();
	int result = memDAO.idPwCheck(id, pw);
	
	if(result == 1){
		dao.updateProduct(dto,pnum);
		response.sendRedirect("uploadListForm.jsp?pageNum="+pageNum);
	}else{%>
		<script>
			alert('비밀번호 불일치');
			history.go(-1);
		</script>
	<%} %>
<body>

</body>
</html>