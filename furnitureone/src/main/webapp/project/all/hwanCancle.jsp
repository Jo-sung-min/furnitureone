<%@page import="web.team.one.HwanDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>hwanCancle.jsp</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	// 로그인했을때만 접근가능한 페이지 
	String mid = (String)session.getAttribute("memId");

	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(mid);
	MemberDTO member = dao.getMember(mnum);
	
	int Bnum =Integer.parseInt(request.getParameter("Bnum"));
	
	HwanDAO hwandao = new HwanDAO();
	hwandao.cancle(Bnum); 
	 
	response.sendRedirect("mypageBuyerForm.jsp");
%>
<body>

</body>
</html>