<%@page import="java.sql.Timestamp"%>
<%@page import="web.team.one.NoticeDTO"%>
<%@page import="web.team.one.NoticeDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>noticePro</title>
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


	NoticeDAO dao1 = new NoticeDAO();
	NoticeDTO notice = new NoticeDTO();
	
	
	
	notice.setNtitle(mr.getParameter("ntitle"));
	notice.setNcontent(mr.getParameter("ncontent"));
	
	if(mr.getFilesystemName("nimg") != null){ // 파일 업로드를 했다면 
		notice.setNimg(mr.getFilesystemName("nimg")); 
	}else {	// 파일 업로드를 안했다면 
		notice.setNimg("default.png");
	}
	
	notice.setNreg(new Timestamp(System.currentTimeMillis()));
	
	dao1.insertNotice(notice); 
	
	response.sendRedirect("supportForm.jsp");
	
	
	

%>






</body>
</html>