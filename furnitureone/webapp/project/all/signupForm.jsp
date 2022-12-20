<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signupForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<style >
	footer {
		    background-color: #fff;
		    width: 100%;
		    height: 120px;
		    bottom : 0;
		    left: 0;
		    position: absolute; /* 위치를 하단에 고정 */
		    z-index: 1000;
			}
	</style>
	<script>
	//유효성 검사
	function checkField() {
		let inputs = document.inputForm;
		if(! inputs.mid.value) { //name속성이 id인 요소의 value가 없으면 true
			alert("아이디를 입력하세요.");
			return false; //submit의 기본 기능인 action에 지정한 pro페이지로 이동하는 기능을 막겠다
		}
		if(! inputs.mpw.value) { 
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if(! inputs.mpwch.value) { 
			alert("비밀번호 확인란을 입력하세요.");
			return false;
		}
		if(! inputs.mname.value) { //name속성이 id인 요소의 value가 없으면 true
			alert("이름를 입력하세요.");
			return false;
		}
		if(! inputs.mtel.value) { 
			alert("전화번호를 입력하세요.");
			return false;
		}
		if(! inputs.memail.value) { 
			alert("이메일을 입력하세요.");
			return false;
		}
		if(! inputs.maddr.value) { 
			alert("주소를 입력하세요.");
			return false;
		}
		if(inputs.mpw.value != inputs.mpwch.value) {
			alert("비밀번호와 비밀번호 확인란이 일치하지 않습니다.")
			return false;
		}
	}
	//중복성 검사
	function openConfirmId(inputForm) {
		//사용자 id 입력란에 작성을 했는지 체크
		if(inputForm.mid.value == "") {
			alert("아이디를 입력하세요.");
			return;	//이 함수 강제 종료
		}
		//아이디 중복 검사 팝업 열기
		let url = "confirmId.jsp?mid=" + inputForm.mid.value;
		open(url, "confirmId", "width=300, height=200,toolbar=no, location=no, status=no, menubar=no, scrollbasr=no, resizable=no");
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
	<br/>
	
	
	<br/><br/><br/>
	<form action="signupPro.jsp" method="post" enctype="multipart/form-data" name="inputForm" onsubmit="return checkField()">
		<table>
			<br /><br />
			<tr>
				<td colspan="2"> 
					<h2> 회원가입 </h2>
					<h5> 이미지를 제외한 모든 칸은 필수 기입입니다. </h5>
				</td>
			</tr>
			<tr>
				<td> 이미지 </td>
				<td> 
					<input type="file" name="mimg"/> 
				</td>
			</tr>
			<tr>
				<td> 아이디 </td>
				<td> 
					<input type="text" name="mid" />
					<input type="button" value="중복확인" onclick="openConfirmId(this.form)"/>  
				</td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td> <input type="password" name="mpw" /> </td>
			</tr>
			<tr>
				<td> 비밀번호 확인 </td>
				<td> <input type="password" name="mpwch" /> </td>
			</tr>
			<tr>
				<td> 이름  </td>
				<td> <input type="text" name="mname" /> </td>
			</tr>
			<tr>
				<td> 전화번호  </td>
				<td> <input type="text" name="mtel" placeholder="' - ' 없이 입력"/> </td>
			</tr>
			<tr>
				<td> email </td>
				<td> 
					<input type="text" name="memail" /> 
				</td>
			</tr>
			<tr>
				<td> 주소 </td>
				<td> 
					<input type="text" name="maddr" /> 
				</td>
			</tr>
			<tr>
				<td> 구분 </td>
				<td> 
					구매자 <input type="radio" name="mtype" value="buyer" checked/> 
					판매자 <input type="radio" name="mtype" value="seller"/> 
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					<input type="submit" value="회원가입"/> 
					<input type="button" value="취소" onclick="window.location='premainForm.jsp'" /> 
				</td>
			</tr>
			<tr>
				<td colspan="2" > 이미 계정이 있으시나요 ? 
					<input type="button" value="로그인" onclick="window.location='loginForm.jsp'"/>
				</td>
			</tr>
		</table>
	</form>
	<br />
		

    
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