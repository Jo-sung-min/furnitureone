<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>idpwfindForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<script>
		//유효성 검사
		function checkField() {
			let inputs = document.loginForm;
			if(! inputs.mname.value) {
				alert("이름을 입력해주세요.")
				return false;
			}
			if(! inputs.memail.value) {
				alert("이메일을 입력해주세요.")
				return false;
			}
		}
		function pwcheckField() {
			let inputs = document.loginpwForm;
			if(! inputs.mid.value) {
				alert("아이디를 입력해주세요.")
				return false;
			}
			if(! inputs.memail.value) {
				alert("이메일을 입력해주세요.")
				return false;
			}
		}
	</script>
	<style>
  
        .box1 {
            background-color: #E5DCC3;
       	  	 width: 100;
       	  	 height:150;
			justify-content: center;
	   		
        }
        .box2 {
        	background-color: #E5DCC3;
			width: 100;
			height:150;
			justify-content: center;
	   	}	
        
        
	
	</style>       
</head>
<body>
	<br />
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
	<br />
	
	
	<div class="container">
	<div class="box1">
		<form action="idfindPro.jsp" method="post" name="loginForm" onsubmit="return checkField()">
		<br /><br /><br /><br />
			<table width="300" height="250">
				<tr height="30">
					<td colspan="2"> <h2>아이디 찾기</h2> </td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="mname" /></td>
				</tr>
				<tr>
					<td>e-mail</td>
					<td><input type="text" name="memail" /></td>
				</tr>
				<tr height="30">
					<td colspan="2"> 
						<input type="submit" value="찾기"/> 
						<input type="button" value="취소" onclick="window.location='premainForm.jsp'" /> 
					</td>
				</tr>
			</table>
		</form>
	</div>
   	<div class="box2">
   		<form action="pwfindPro.jsp" method="post" name="loginpwForm" onsubmit="return pwcheckField()">
		<br /><br /><br /><br />	
			<table width="300" height="250">
				<tr height="30">
					<td colspan="2"> <h2>비밀번호 찾기</h2> </td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="mid" /></td>
				</tr>
				<tr>
					<td>e-mail</td>
					<td><input type="text" name="memail" /></td>
				</tr>
				<tr height="30">
					<td colspan="2"> 
						<input type="submit" value="찾기"/> 
						<input type="button" value="취소" onclick="window.location='premainForm.jsp'" /> 
					</td>
				</tr>
			</table>
		</form>
   	</div>
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