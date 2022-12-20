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

	
		
%>

<script >

	function checkField(){
		let inputs = document.noticeForm;
		
		if(!inputs.ntitle.value){
			alert("제목을 입력해주세요");
			return false;
		}
		if(!inputs.ncontent.value){
			alert("내용을 입력해주세요");
			return false;
		}
		
		
	}


</script>



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
			<form >
			<br/><br/>
				<h2 align="center" onclick="window.location='mainForm.jsp'"> 메인으로 </h2>
			<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>	
			<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
				<h4 align="center"> 
					문의 전화번호 <br/>
					1577-5670
				</h4>
			</form>
		</div>	




		<br/><br/><br/>	
		<div class="container"> 
		
		<form action="noticePro.jsp" method="post" name="noticeForm"  onsubmit="return checkField()" enctype="multipart/form-data" >	
		<table width="680" height="500" >
			<tr height="60">
				<td colspan="2"> <h2>공 지 사 항 </h2> </td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="ntitle"></td>
			</tr>
			
			<tr>
				<td>상품 이미지</td>
				<td><input type="file" name="nimg"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea cols="50" rows="20" name="ncontent" placeholder="문의사항을 입력해 주세요"></textarea>
				</td>
			<tr height="30">
				<th colspan="2" align="right">
					<input type="submit" value="등록" /> 
					<input type="button" value="취소" onclick="history.go(-1)" /> 
				</th>
			</tr>
		</table>
		</form>
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