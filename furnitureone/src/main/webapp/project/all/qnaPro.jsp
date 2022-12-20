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
	
	String Mid = (String)session.getAttribute("memId");
	
	MemberDAO dao  = new MemberDAO();
	int Mnum= dao.getMnum(Mid);


	request.setCharacterEncoding("UTF-8");

	String path= request.getRealPath("oneimg");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, max, enc,dp);
	

	//조회수 세어주는 메서드 
	





	QnaDAO dao1 = new QnaDAO();
	QnaDTO qna = new QnaDTO();
	
	
	
	qna.setQtitle(mr.getParameter("qtitle"));
	qna.setQcontent(mr.getParameter("qcontent"));
	qna.setMnum(Mnum);
	
	if(mr.getFilesystemName("qimg") != null){ // 파일 업로드를 했다면 
		qna.setQimg(mr.getFilesystemName("qimg"));
	}else {	// 파일 업로드를 안했다면 
		qna.setQimg("default.png");
	}
	
	qna.setQreg(new Timestamp(System.currentTimeMillis()));
	
	dao1.insertQna(qna); 
	
	response.sendRedirect("supportForm.jsp");
	
	
	

%>






</body>
</html>