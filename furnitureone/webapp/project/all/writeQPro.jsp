<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
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
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String id = (String)session.getAttribute("memId");
%>
<jsp:useBean id="inDTO" class="web.team.one.InquiryDTO"/>
<jsp:useBean id="memDTO" class="web.team.one.MemberDTO"/>
<%
	String question = request.getParameter("question");
	String check = request.getParameter("check");
	if(question == null || question.equals("")){%>
		<script>
			alert('내용을 입력하쇼');
			history.go(-1);
		</script>
	<%}else{
		InquiryDAO inDAO = new InquiryDAO();
		ProductDAO proDAO = new ProductDAO();
		ProductDTO proDTO = proDAO.getOneProduct(pnum);
		String sid = proDTO.getMid();
		if(check == null || check.equals("")){
			inDAO.insertInquiry(pnum, id, question, sid);
		}else{
			inDAO.insertInquiry(pnum, id, question, sid, check);
		}
		 
		response.sendRedirect("inquiryList.jsp?pnum="+pnum);
	}
%>
<body>

</body>
</html>