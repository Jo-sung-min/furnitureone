<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.SellregisDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
	MemberDAO memDAO = new MemberDAO();
	int mnum = memDAO.getMnum(id);
	MemberDTO memDTO = memDAO.getMember(mnum);
	String sid = memDTO.getMid();
%>
<jsp:useBean id="dto" class="web.team.one.SellregisDTO"/>
<%
	dto.setScompany(request.getParameter("scompany").trim());
	dto.setSaddr(request.getParameter("saddr").trim());
	dto.setSrepresent(request.getParameter("srepresent").trim());
	dto.setShwanaddr(request.getParameter("shwanaddr").trim());
	dto.setScall(request.getParameter("scall").trim());
	dto.setSbnum(Integer.parseInt(request.getParameter("sbnum").trim()));

	SellregisDAO dao = new SellregisDAO();
	dao.insertSeller(dto, mnum, sid);

	response.sendRedirect("mypageSellerForm.jsp");
%>
<body>

</body>
</html>