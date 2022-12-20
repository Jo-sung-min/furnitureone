<%@page import="web.team.one.SellregisDTO"%>
<%@page import="web.team.one.SellregisDAO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>
	
</head>
	<script >
		function checkField(){
		let	inputs = document.sellRegisForm;
			if(!inputs.scompany.value){
				alert("회사명을 입력해 주세요.");
				return false;
			}
			if(!inputs.saddr.value){
				alert("회사주소를 입력해 주세요.");
				return false;
			}
			if(!inputs.scall.value){
				alert("회사 전화번호를 입력해 주세요.");
				return false;
			}
			if(!inputs.srepresent.value){
				alert("회사대표를 입력해 주세요.");
				return false;
			}
			if(!inputs.shwanaddr.value){
				alert("배송주소를 입력해 주세요.");
				return false;
			}
			if(!inputs.sbnum.value){
				alert("사업자번호를 입력해 주세요.");
				return false;
			}
		}


	</script>





<%
	String id = (String)session.getAttribute("memId");
	
%>
<body>
	<header>
	       <div class="inner">
	          	<div class="header-container">
           	 	 	<div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	  	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
          	  	 	<div class="header-text">
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
	<%if(id == null){ %>
		<script>
			alert('로그인 후 이용하세요.');
			window.location.href="loginForm.jsp";
		</script>
	<%}else{ %>
	<br/><br/><br/><br/>
	<form action="sellRegistPro.jsp" align="center" name="sellRegisForm" onsubmit="return checkField()" method="post">
		<table width="450" height="300">
			<tr>
				<td colspan="2" align="center"><h1>판매자 등록 양식<h1/></td>
			</tr>
			<tr>
				<td>회사명</td>
				<td><input type="text" name="scompany"/></td>
			</tr>
			<tr>
				<td>회사 주소</td>
				<td><input type="text" name="saddr"/></td>
			</tr>
			<tr>
				<td>회사 전화번호</td>
				<td><input type="text" name="scall" placeholder="'-'없이 입력"/></td>
			</tr>
			<tr>
				<td>회사 대표</td>
				<td><input type="text" name="srepresent"/></td>
			</tr>
			<tr>
				<td>환불 시 배송 주소</td>
				<td><input type="text" name="shwanaddr"/></td>
			</tr>
			<tr>
				<td>사업자 번호</td>
				<td><input type="number" name="sbnum" placeholder="'-'없이 입력"/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="신청"/>
					<input type="button" value="취소" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
	</form>	
		
	<%} %>
	<br/><br/><br/><br/><br/><br/><br/>

	<div class="box4">
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
	</div>
	
	
	
</body>
</html>