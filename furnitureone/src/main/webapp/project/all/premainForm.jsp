<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>premainForm</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
<%
    String id = (String)session.getAttribute("memId");

	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(id);
	MemberDTO member = dao.getMember(mnum); 
	
%>
</head>
	
<body>
	<br />
	<%if(session.getAttribute("memId") == null) { 
		//쿠키가 있는지 검사
				String mid = null, mpw = null, auto=null;
				Cookie[] coos = request.getCookies();
				if(coos != null) {
					for(Cookie c : coos) {
						//쿠키가 있다면 쿠키에 저장된 값꺼내 변수에 담기
						if(c.getName().equals("autoId")) mid = c.getValue();
						if(c.getName().equals("autoPw")) mpw = c.getValue();
						if(c.getName().equals("autoCh")) auto = c.getValue();
					}
				}
				
				//세개 변수에 값이 들어있을 경우 (쿠키 제대로 생성되어서 다 갖고 있다)
				if(auto != null && mid != null && mpw != null) {
					//로그인 처리되도록 loginPro.jsp 처리 페이지로 이동시키기
					response.sendRedirect("loginPro.jsp");
				}
	%>
	<header>
	  	<div class="inner">
	         <div class="header-container">
          	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	 	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
         	  	 		<div class="header-text">
          	  	 			<button onclick="window.location='loginForm.jsp'"> 로그인 </button>
          	  	 			<button onclick="window.location='signupForm.jsp'"> 회원가입 </button>
          		</div>  
          	</div>         
      	</div>
   	</header>
	<%}else{ %>
	
		<header>
	  	<div class="inner">
	         <div class="header-container">
          	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	 	 	<h1 align="center">Furniture One</h1>            
         	  	 		<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
          	  	 		<% if(member.getMid().equals("admin"))  { %>
      	  	 				<button onclick="window.location='mypageAdminForm.jsp'"> 마이페이지 </button>
   	       	  	 		<% }else if(member.getMtype().equals("buyer")){ %>
          	  	 			<button onclick="window.location='mypageBuyerForm.jsp'"> 마이페이지 </button>
          	  	 			<button onclick="window.location='prebuyForm.jsp'"> 장바구니 </button>
      	  	 			<% }else if(member.getMtype().equals("seller")){ %>
      	  	 				<button onclick="window.location='mypageSellerForm.jsp'"> 마이페이지 </button>
      	  	 		<%} %>
          	  	 		
          	  	 </div>  
          	</div>         
      	</div>
   	</header>
   	<%} %>
	<br /><br /><br /><br /><br />
	<table>
		<tr>
			<td>
				<div align="center">
				<a href="mainForm.jsp">
				<img src="img/desgin.png" width="1100px" height="650px"></a>	
				</div> 
			</td>
		</tr>
	</table>
	<br /><br /><br />
	<footer>
       <div class="inner">
          <div class="footer-container">
            <h2 align="left">Furniture One</h2>
			<a>개인정보 처리 방침． 서비스이용약관． 위치서비스 약관． 회사소개． 채용정보．</a> 
			<a>상호명：㈜F.O ｜ 대표이사 : 김대헌 ｜ 주소 : 서울특별시 마포구 신촌로 94, 7층(노고산동, 그랜드플라자)</a> 
			<a>사업자등록번호：187-85-01021｜개인정보보호책임자 : 더조은｜사업자정보확인</a>  
          </div>
       </div>
    </footer>
	

</body>

</html>