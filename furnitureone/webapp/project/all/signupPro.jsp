<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.AddressDAO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signupPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="web.team.one.MemberDTO" />
<jsp:useBean id="address" class="web.team.one.AddressDTO" />
<%
	// 파일업로드처리시 <jsp:setProperty > 사용불가 
	String path = request.getRealPath("oneimg"); // 서버상의 save 폴더 경로 찾기
	System.out.println(path);
	int max = 1024*1024*50; // 파일 최대 크기 
	String enc = "UTF-8"; 
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request, path, max, enc, dp); // 실제 파일은 저장
	
	member.setMid(mr.getParameter("mid").trim());
	String mid = member.getMid();

	MemberDAO dao1 = new MemberDAO();
	int count =  dao1.getMidCheck(mid);
	System.out.println("mid : "+mid);
	System.out.println("count : "+count);
	
	if(count == 0) { 
		//member.setMid(mr.getParameter("mid")); 
		member.setMpw(mr.getParameter("mpw").trim());
		member.setMname(mr.getParameter("mname").trim());
		member.setMemail(mr.getParameter("memail").trim());
		member.setMtel(mr.getParameter("mtel").trim());
		member.setMtype(mr.getParameter("mtype"));
		String id = member.getMid();
		
		address.setMaddr(mr.getParameter("maddr").trim()); //주소
		
		if(mr.getFilesystemName("mimg") != null){ // 파일을 업로드했을 경우 
			member.setMimg(mr.getFilesystemName("mimg"));
		}else { // 파일 업로드를 안했을 경우 
			member.setMimg("");
		}	
		//DB가서 저장
		MemberDAO dao = new MemberDAO();
		dao.insertMemeber(member);
		 
		int Mnum = dao.getMnum(id);
		dao.insertAddress(address, Mnum);
		
		//처리 후 main 페이지 이동
		response.sendRedirect("premainForm.jsp");
	} else { %> 
		<script>
			alert("중복된 아이디입니다. 중복확인을 체크해주세요.");
			history.go(-1);
		</script>
		
<%		
	}
	
%>
<body>

</body>
</html>