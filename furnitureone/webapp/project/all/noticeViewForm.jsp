<%@page import="web.team.one.NoticeDTO"%>
<%@page import="web.team.one.NoticeDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.QnaDTO"%>
<%@page import="web.team.one.QnaDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>qnaListForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	
</head>
	<%-- 로그인확인 & 로그인처리 --%>
<%
		//로그인 확인
		String Mid =(String)session.getAttribute("memId");
		MemberDAO dao0 = new MemberDAO();
		int mnum = dao0.getMnum(Mid);
		MemberDTO member = dao0.getMember(mnum); 
		// DB에서 전체 글 개수 가져오기 
		
		
		
%>


<%
	// 공지사항 
	int nnum = Integer.parseInt(request.getParameter("nnum"));
	System.out.println(nnum);
	NoticeDAO dao1 = new NoticeDAO();
	NoticeDTO notice = new NoticeDTO();
	notice = dao1.getNotice(nnum);
	//조회수 올려주는 메서드	
		int readCount=dao1.addReadCount(nnum); 
		dao1.setReadCount(readCount,nnum); 
	
%> 


<body>
	<br />
	
	<%if(Mid==null){ %>
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
          	 	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
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
		<div class="side1">
			<br/><br/><br/>
				<h2 align="center" onclick="window.location='mainForm.jsp'"> 메인으로 </h2>
				<br/><br/>
				<h4 align="center"> 
					문의 전화번호 <br/>
					1577-5670
				</h4>
		</div>	
	
	
	
	
	
		<br/><br/><br/>	
		<div class="container">
				<table width="680" height="500" >
					<tr height="60">
						<td colspan="2"> <h2>Q & A </h2> </td>
					</tr>
					<tr>
						<td>제목</td>
						<td><%=notice.getNtitle()%></td>
					</tr>
					<tr>
						<td>이미지</td>
						<td> <img src="/furnitureone/oneimg/<%=notice.getNimg()%>" width="150"> </td>
					
					</tr>
					<tr>
						<td>내용</td>
						<td>
							<textarea cols="50" rows="15" readonly> <%=notice.getNcontent() %></textarea>
						</td>
					</tr>
					<tr>
						<td>등록일</td>
						<td><%=notice.getNreg() %></td>
					</tr>
					<tr>
						<td>조회수</td>
						<td><%=notice.getNreadcount() %></td>
					</tr>
					<tr height="30">
						<th colspan="2" align="right">
							<%if(Mid==null){ %>
								<input type="button" value="뒤로" onclick="window.location='supportForm.jsp'" /> 
							<%}else if(Mid.equals("admin")){%>
								<input type="button" value="뒤로" onclick="window.location='supportForm.jsp'" /> 
							<%}else if(Mid!=null){%>
								<input type="button" value="뒤로" onclick="window.location='supportForm.jsp'" /> 
							<%} %>
						</th>
					</tr>
				</table>
			
				</div>	
		
		
		
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