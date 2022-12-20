<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
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
	String mpw = request.getParameter("mpw");
	
	//휴면 풀려는 애 정보
	String mid = request.getParameter("mid");
	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(mid);
	MemberDTO member = dao.getMember(mnum);
	member.getMpw();
	
	if(mpw.equals(member.getMpw())){
		//휴면 해제해주는 메서드
		dao.memberBack(mnum);
										%>
		<script >
			alert("휴먼상태가 해제 되었습니다.");
			window.location="loginForm.jsp";
		</script>
		
	<%}else{%>
		<script >
			alert("비밀번호가 다릅니다.");
			window.location="loginForm.jsp"
		</script>
		
	<%}%>






</body>
</html>