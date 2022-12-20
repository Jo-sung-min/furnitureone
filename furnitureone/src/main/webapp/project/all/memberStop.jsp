<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memberStop</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

    String mid = (String)session.getAttribute("memId");
    int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	String Mid = request.getParameter("Mid");
	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(Mid);
	System.out.println(mnum);
	dao.memberLongStop(mnum);
%>
	
	<script> 
		alert("계정이 중지 되었습니다."); 
		window.location="memberListForm.jsp?mnum="+<%=mnum%>+"&pageNum="+<%=pageNum%>;
	</script>
<body>

</body>
</html>