<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.team.one.QnaDTO"%>
<%@page import="web.team.one.QnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<body>
<%
	
	request.setCharacterEncoding("UTF-8");
	int qnum = Integer.parseInt(request.getParameter("qnum"));

	QnaDAO dao1 = new QnaDAO();
	QnaDTO qna = new QnaDTO();
	
	qna.setAcontent(request.getParameter("acontent"));
	qna.setAreg(new Timestamp(System.currentTimeMillis()));
	
	dao1.insertAnswer(qna, qnum); 
	

%>
	<script >
		alert("답변완료");
		window.location="qnaViewForm.jsp?qnum=<%=qnum%>";
	</script>





</body>
</html>