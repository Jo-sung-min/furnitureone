<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>
	
	<script>
		//유효성 검사
		function checkField() {
			let inputs = document.loginForm;
			if(! inputs.mid.value) {
				alert("아이디를 입력해주세요.")
				return false;
			}
			if(! inputs.mpw.value) {
				alert("비밀번호를 입력해주세요.")
				return false;
			}
		}
	</script>
</head>
<%
	// 로그인했을때만 접근가능한 페이지 
	String mid = (String)session.getAttribute("memId");
	
	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(mid); 
	MemberDTO member = dao.getMember(mnum);
%>
<body>
	<br />
	
	
<%
	if(mid==null){%>
		
		<script >
			alert("로그인 후 이용해 주세요");
			window.location.href="loginForm.jsp";
		</script>
	<%}else{%>
		
		<header>
	       <div class="inner">
	          	<div class="header-container">
           	 	 	<div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	  	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
          	  	 	<div class="header-text">
          	  	 		<button onclick="window.location='loginForm.jsp'"> 로그아웃 </button>
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
   		
   		
	<div class="side1">
		<form action="modifyForm.jsp" method="post">
			<br /><br />
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>
   		
   		
   		
</head>
<%
	request.setCharacterEncoding("utf-8");
	int pnum = Integer.parseInt(request.getParameter("pnum"));
%>

<body>

	<br/><br/><br/><br/><br/>
	<form action="writeQPro.jsp?pnum=<%=pnum %>" method="post">
			<table width="680"height="450">
				<tr height="60">
					<td colspan="2">
						<h2>상품 문의</h2>
					</td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea cols="50" rows="20" name="question"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						비공개<input type="checkbox" name="check" value="check"/>
					</td>
				</tr>
				<tr height="60">
					<td colspan="2" align="right">
						<input type="submit" value="작성" />
						<input type="button" value="취소" onclick="history.go(-1)"/>
					</td>
				</tr>
			</table>
		</form>
		<br /><br />
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
<%} %>
</body>
</html>