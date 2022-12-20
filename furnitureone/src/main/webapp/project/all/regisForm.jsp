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
	<style >
		footer {
			    background-color: #fff;
			    width: 100%;
			    height: 120px;
			    bottom : 0;
			    left: 0;
			    position: fixed; /* 위치를 하단에 고정 */
			    z-index: 1000;
				}
	</style>
	<script>
		//유효성 검사
		function checkField() {
			let inputs = document.regisForm;
			if(!inputs.pname.value) {
				alert("상품명을 입력해주세요.")
				return false;
			}
			if(!inputs.pimg.value) {
				alert("이미지를 등록해주세요.")
				return false;
			}
			if(!inputs.pprice.value) {
				alert("가격를 입력해주세요.")
				return false;
			}
			if(!inputs.pstock.value) {
				alert("개수를 입력해주세요.")
				return false;
			}
			if(!inputs.pcontent.value) {
				alert("설명란을 입력해주세요.")
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
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
          	  	 		<button onclick="window.location='mypageSellerForm.jsp'"> 마이페이지 </button>
          	  	 	</div>  
          		</div>         
      		</div>
   		</header>
</head>
<br/>
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
	
	<br/><br/><br/><br/>
<%
	String id = (String)session.getAttribute("memId");
	MemberDAO memDAO = new MemberDAO();
	int mnum = memDAO.getMnum(id);
	SellregisDAO sellDAO = new SellregisDAO();
	SellregisDTO sellDTO = sellDAO.getSeller(mnum);
	
	if(sellDTO.getScon() == 0){%>
		<script>
			alert('판매자 등록 후 이용하세요');
		</script>
	<%
	response.sendRedirect("sellRegistFrom.jsp");
	}
	
%>
<body>
	<%if(id == null){ %>
		<script>
			alert('로그인 후 이용하세요.');
			history.window.location.href = "loginForm.jsp";
		</script>
	<%}else{ %>
	<br/>
	<form action="regisPro.jsp" align="center" name="regisForm" onsubmit="return checkField()"  method="post" enctype="multipart/form-data" >
		<table width="550"height="450">
			<tr>
				<td colspan="2" align="center"><h1>상품 등록 양식<h1/></td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="pname"/></td>
			</tr>
			<tr>
				<td>상품 사진</td>
				<td><input type="file" name="pimg"/></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="number" name="pprice"/></td>
			</tr>
			<tr>
				<td>개수</td>
				<td><input type="number" name="pstock"/></td>
			</tr>
			<tr>
				<td>상품 종류</td>
				<td><select name="ptype">
						<option value="sofa">소파</option>
						<option value="storageCloset">수납장</option>
						<option value="topper">거실장</option>
						<option value="mattress">매트리스</option>
						<option value="dressingTable">화장대</option>
						<option value="closet">옷장</option>
						<option value="diningTable">식탁</option>
						<option value="diningChair">의자</option>
						<option value="shelf">선반</option>
						<option value="desk">책상</option>
						<option value="chair">의자</option>
						<option value="bookcase">책장</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>색상</td>
				<td>
					<select name="pcolor">
						<option value="white">백색</option>
						<option value="gray">회색</option>
						<option value="black">흑색</option>
						<option value="brown">갈색</option>
						<option value="navy">청색</option>
						<option value="red">적색</option>
						<option value="green">녹색</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>상세 설명</td>
				<td><textarea rows="15" cols="50" name="pcontent"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="등록"/>
					<input type="button" value="취소" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
	</form>	
	<%} %>
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