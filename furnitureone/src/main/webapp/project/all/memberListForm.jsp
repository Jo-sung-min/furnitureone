<%@page import="web.team.one.SellregisDTO"%>
<%@page import="web.team.one.SellregisDAO"%>
<%@page import="web.team.one.AddressDTO"%>
<%@page import="web.team.one.AddressDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   <link href="style.css" rel="stylesheet" type="text/css"/>
  
   
   
</head>
<jsp:useBean id="memDTO" class="web.team.one.MemberDTO"/>
<%	
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
   	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("memId");
	int mnum = Integer.parseInt(request.getParameter("mnum"));
	MemberDAO memDAO = new MemberDAO();
	memDTO = memDAO.getMember(mnum);
	MemberDTO member = memDAO.getMember(mnum);
	AddressDAO addrDAO = new AddressDAO();
	AddressDTO addrDTO = null;
	addrDTO = addrDAO.getOneAddress(mnum);
   //현재 요청된 게시판 페이지 번호 
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   SellregisDAO sellDAO = new SellregisDAO();
   SellregisDTO sellDTO = sellDAO.getSeller(mnum);
   
 
%>
<body>
	<br />
		<header>
	       <div class="inner">
	          	<div class="header-container">
           	 	 	<div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	  	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
          	  	 	<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
          	  	 		<% if(id.equals("admin"))  { %>
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

	<div class="side1">
		<form action="modifyForm.jsp" method="post">
			<br/><br/><br/><br/>
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>


		<br/><br/><br/><br/><br/><br/>	
		<div class ="container">
		<div class="box3">
		<table width="500" height="400">
			<tr height="60">
				<td colspan="3"><h2>회원 정보</h2></td>
			</tr>
			<tr width="380">
				<td rowspan="7">
				<%if(memDTO.getMimg() != null){%>
					<img width="300px" src="/furnitureone/oneimg/<%=memDTO.getMimg()%>"/>
				<%}else{ %>
					<img width="300px" src="/furnitureone/oneimg/default.png"/>
				<% }%>
				</td>
				<td>아이디</td>
				<td><%=memDTO.getMid() %></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=memDTO.getMname() %></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><%=memDTO.getMtel() %></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><%=memDTO.getMemail() %></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><%=addrDTO.getMaddr() %></td>
			</tr>
			<tr>
				<td>가입일</td>
				<td><%=sdf.format(memDTO.getMreg()) %></td>
			</tr>
			<tr>
				<td>상태</td>
				<%	int mcon = memDAO.getMcon(memDTO.getMid());
					if(mcon==0) {%>
					<td>
						일반 계정 <br />
						<input type="button" value="휴면 계정 전환" onclick="window.location='memberStop.jsp?Mid=<%=memDTO.getMid()%>&pageNum=<%=pageNum %>'" />
					</td>
				<%}else {%>
					<td>
						휴면 계정 <br />
						<input type="button" value="일반 계정 전환" onclick="window.location='memberBack.jsp?Mid=<%=memDTO.getMid()%>&pageNum=<%=pageNum %>'" />
					</td>
				<%} %>
			</tr>
			<tr height="40">
				<td colspan="3"></td>
			</tr>
		</table>
		</div>
		
	<% if(memDTO.getMtype().equals("seller") && sellDTO != null){%>
	
		<div class="box3">
		<table width="500" height="400">
			<tr height="30">
				<td colspan="3"><h2>회사 정보</h2></td>
			</tr>
			<tr>
				<td>회사명</td>
				<td><%=sellDTO.getScompany() %></td>
			</tr>
			<tr>
				<td>회사대표</td>
				<td><%=sellDTO.getSrepresent() %></td>
			</tr>
			<tr>
				<td>회사번호</td>
				<td><%=sellDTO.getScall() %></td>
			</tr>
			<tr>
				<td>회사주소</td>
				<td><%=sellDTO.getSaddr() %></td>
			</tr>
			<tr>
				<td>사업자 번호</td>
				<td><%=sellDTO.getSbnum() %></td>
			</tr>
			<tr>
				<td>신청일</td>
				<td><%=sdf.format(sellDTO.getSreg()) %></td>
			</tr>
			<tr height="40">
				<td align="right" colspan="2">
					<input type="button" value="뒤로" onclick="history.go(-1)"/>
					<%if(sellDTO.getScon()==0){ %>
						<input type="button" value="판매자 등록 승인" onclick="window.location.href='sellApproveForm.jsp?mnum=<%=sellDTO.getMnum()%>&pageNum=<%=pageNum%>'"/>
					<% }%>
				</td>
			</tr>
		</table>
		</div>
		</div>
	<% }%>
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