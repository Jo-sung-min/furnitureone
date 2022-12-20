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
	<script >
		function checkField(){
			let inputs = document.answerForm;
			if(!inputs.acontent.value){
				alert("답변을 입력해주세요");
				return false;
			}
			
			
		}
	
	</script>





	<%-- 로그인확인 & 로그인처리 --%>
<%
		//로그인 확인
		String Mid =(String)session.getAttribute("memId");

		MemberDAO dao0 = new MemberDAO();
		int mnum = dao0.getMnum(Mid);
		MemberDTO member = dao0.getMember(mnum); 
		int qnum = Integer.parseInt(request.getParameter("qnum")); 
				
		
		QnaDAO dao1 = new QnaDAO(); 
		QnaDTO qna = new QnaDTO();
		qna = dao1.getQna(qnum);
		
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
			<br/><br/>
				<h2 align="center" onclick="window.location='mainForm.jsp'"> 메인으로 </h2>
				<h4 align="center"> 
					문의 전화번호 <br/>
					1577-5670
				</h4>
		</div>	
	
	
	
	
	
		<br/><br/><br/>	
		<div class="container">
		
		
		 
		<form action="answerPro.jsp" method="post" name="answerForm" onsubmit="return checkField()" >
		<input type="hidden" name="qnum" value="<%=qnum%>"/>
		<table width="680" height="500" >
			<tr height="60">
				<td colspan="2"> <h2>Answer </h2> </td>
			</tr>
			<tr>
				<td>문의 내용</td>
				<td> <textarea cols="50" rows="15" name="qcontent" readonly><%=qna.getQcontent()%></textarea></td>
			</tr>
			<tr>
				<td>답변 내용</td>
				<td>
					<textarea cols="50" rows="15" name="acontent" placeholder="답변을 입력해 주세요"></textarea>
				</td>
			</tr>
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