<%@page import="web.team.one.CartDAO"%>
<%@page import="web.team.one.CartDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>prebuyDelete</title>
</head>
<%
   	request.setCharacterEncoding("UTF-8");
%>
<%
	//로그인 확인
	String Mid =(String)session.getAttribute("memId");
	MemberDAO daom = new MemberDAO();
	int mnum = daom.getMnum(Mid);

	CartDTO cart = new CartDTO(); 
	cart.setCnum(Integer.parseInt(request.getParameter("Cnum")));  
	System.out.println("Cnum : "+cart.getCnum());
	
	//DB가서 저장
	CartDAO dao = new CartDAO();
	dao.deleteCart(cart.getCnum()); 
	 
	
	//처리 후 main 페이지 이동
	response.sendRedirect("prebuyForm.jsp?Pnum="+request.getParameter("Pnum"));
	
%>	

<body>

</body>
</html>