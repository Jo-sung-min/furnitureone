<%@page import="web.team.one.HwanDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.team.one.HwanDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>refundPro</title>
</head>

<%
		request.setCharacterEncoding("UTF-8");
		String hreason=request.getParameter("hreason");
		String Pname=request.getParameter("Pname");
		
		if(hreason != "null"){
		String Mid =(String)session.getAttribute("memId");
	
		MemberDAO memDAO = new MemberDAO();
		int Mnum= memDAO.getMnum(Mid); 
		HwanDTO hwan  = new HwanDTO(); // 담을 바구니 생성 
		
		String path = request.getRealPath("oneimg");
		int max = 1024*1024*5;
		String enc="utf-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		
		MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp);
		
		int bnum =Integer.parseInt(mr.getParameter("Bnum"));
		hwan.setBnum(bnum);
		hwan.setHreason(mr.getParameter("hreason"));
		hwan.setMnum(Mnum);
		hwan.setSnum(Integer.parseInt(mr.getParameter("Snum")));
		hwan.setPname(mr.getParameter("Pname"));
		
		HwanDAO dao = new HwanDAO();
		dao.insertHwan(hwan); 
		
		
		response.sendRedirect("mypageBuyerForm.jsp");
		
		}else{
			
 %>
	
	<script >
		alert("환불 사유를 입력해주세요");
		history.go(-1);
	</script>

 
 
 <%} %>
 
<body>

</body>
</html>