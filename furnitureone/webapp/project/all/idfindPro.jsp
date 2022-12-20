<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idfindPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	
	String mname = request.getParameter("mname").trim();
	System.out.println("mname "+mname);
	String memail = request.getParameter("memail").trim();
	System.out.println("memail "+memail);
	MemberDTO member = new MemberDTO(); 
	 
	MemberDAO dao = new MemberDAO(); 
	//String result = dao.idfind(mname, memail);
	int count = dao.idfindCount(mname, memail); 
	
	
	
	
	if(count == 0) {  //var result = '${result}'; //""붙이니까 됨 %>
		<script> 
			alert("이름과 이메일이 맞지 않습니다.");
			history.go(-1);
		</script>
	<%}else{ 
		member = dao.idfind(mname, memail); %>
		<script>
			alert("아이디 : " + "<%=member.getMid()%>"); 
			history.go(-1);
		</script>	
	<%}%>
<body>

</body>
</html>