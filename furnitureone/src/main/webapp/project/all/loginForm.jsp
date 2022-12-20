<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginForm.jsp</title>
	<link href="style.css" rel="stylesheet" type="text/css" />

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
	<br/><br/><br/><br/><br/><br/><br/><br/><br/>
	
	<form action="loginPro.jsp" method="post" name="loginForm" onsubmit="return checkField()">
		<table width="330" height="270">
			<tr height="50">
				<td colspan="3"> <h2>로그인</h2> </td>
			</tr>
			<tr>
				<td>ID</td>
				<td><input type="text" name="mid" /></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" name="mpw" /></td>
			</tr>
			
			<tr height="40">
				<td colspan="3">
					자동로그인 <input type="checkbox" name="auto" value="1" />
					<input type="submit" value="로그인" />
					<input type="button" value="취소" onclick="window.location='premainForm.jsp'" />
				</td>
			</tr>
			<tr height="40">
				<td colspan="2">
					<input type="button" value="회원가입" onclick="window.location='signupForm.jsp'"/>
					<input type="button" value="id/pw 찾기" onclick="window.location='idpwfindForm.jsp'"/>
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
</body>

</html>