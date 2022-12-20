<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.MemberDTO"%>
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
%>
<jsp:useBean id="dto" class="web.team.one.MemberDTO"/>
<%
	String id = (String)session.getAttribute("memId");
	if(id == null){%>
		<script>
			alert('로그인 후 이용하세요')
		</script>
	<%
		response.sendRedirect("loginForm.jsp");
	}
	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(id);
	dto = dao.getMember(mnum);
	
	if(dto.getMtype().equals("seller")){
		dao.memberStop(mnum); 
		dao.sellerStop(id);
		session.invalidate();%>
		<script >
			alert("계정이 정지 되었습니다.")
			window.location="loginForm.jsp";
		</script>
	<%}else{
		dao.memberStop(mnum); 
		session.invalidate();%>
		<script >
			alert("계정이 정지 되었습니다.")
			window.location="loginForm.jsp";
		</script>
		<%
	} 
%>
<body>

</body>
</html>