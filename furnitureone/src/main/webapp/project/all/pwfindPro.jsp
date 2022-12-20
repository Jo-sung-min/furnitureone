<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>pwfindPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String mid = request.getParameter("mid").trim();
	System.out.println("mid "+mid);
	String memail = request.getParameter("memail").trim();
	System.out.println("memail "+memail);
	MemberDTO member = new MemberDTO(); 
	 
	MemberDAO dao = new MemberDAO(); 
	//String result = dao.idfind(mname, memail);
	int count = dao.pwfindCount(mid, memail); 
	 
	if(count == 0) {  %>
		<script> 
		//var result = '${result}'; //""붙이니까 됨
			alert("아이디와 이메일이 맞지 않습니다.");
			history.go(-1);
		</script>
	<%}else{
		member = dao.pwfind(mid, memail); %> 
		<script>
			alert("비밀번호 : " + "<%=member.getMpw()%>"); 
			history.go(-1);
		</script>	
	<%}%>
<body>

</body>
</html>