<%@page import="web.team.one.InquiryDTO"%>
<%@page import="web.team.one.InquiryDAO"%>
<%@page import="java.util.List"%>
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
			let inputs = document.writeAForm;
			if(! inputs.answer.value) {
				alert("답변을 입력해주세요.")
				return false;
			}
		}
</script>
	
</head>
<%
	String id = (String)session.getAttribute("memId");
	request.setCharacterEncoding("utf-8");
	int inum = Integer.parseInt(request.getParameter("inum"));
	InquiryDAO inDAO = new InquiryDAO();
	InquiryDTO inDTO = new InquiryDTO();
	inDTO = inDAO.getOneInquiry(inum);
%>
	
<body>
<%if(id==null){%>
		<script >
			alert("로그인 후 이용해 주세요");
			window.location.href="loginForm.jsp";
		</script>
	<%}else{%>
  	<div class="inner">
         <div class="header-container">
         	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
         	 	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
        	  	 		<div class="header-text">
         	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
         	  	 		<button onclick="window.location='mypageSellerForm.jsp'"> 마이페이지 </button>
         	  	 </div>  
         	</div>         
     	</div>
     <div class="side1">
		<form action="modifyForm.jsp" method="post">
			<br /><br />
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br /><br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>	
     	
     	
	<form action="writeAPro.jsp?inum=<%=inum %>" method="post" name="writeAForm" onsubmit="return checkField()">
	<br /><br /><br />
			<table>
				<tr>
					<td colspan="2">
						<h3>문의 답변</h3>
					</td>
				</tr>
				<tr>
					<td>문의 내용</td>
					<td><textarea cols="40" rows="15" placeholder="<%=inDTO.getQuestion()%>"></textarea></td>
				</tr>
				<tr>
					<td>답변 내용</td>
					<td><textarea cols="40" rows="15" name="answer" ></textarea></td>
				</tr>
				<tr> 
					<td colspan="2" align="right">
						<input type="submit" value="작성" />
						<input type="button" value="취소" onclick="history.go(-1)"/>
					</td>
				</tr>
			</table>
		</form>
		<%} %>
	<br /><br /><br /><br /><br /><br /><br />
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