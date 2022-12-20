<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	
</head>
<%
	String mid = request.getParameter("mid");

	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(mid);
	MemberDTO member = dao.getMember(mnum);

%>

	<script >
		function checkField(){
			let inputs = document.hewForm;
			if(!inputs.mpw.value){
				alert("비밀번호를 입력해주세요");
				return false;
			}
			if(!inputs.mpwch.value){
				alert("비밀번호확인을 입력해주세요");
				return false;
			}
			if(inputs.mpw.value!=inputs.mpwch.value){
				alert("비밀번호가 다릅니다");
				return false;
			}
			
		}
	</script>

<body>
	<br />
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
   		<br />
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
	
	<div class="box3">
	<form action="hewPro.jsp" method="post" name="hewForm" onsubmit="return checkField()" >
		<input type="hidden" name="mid" value="<%=mid%>">
		<table width="500" height="600">
			<tr height="60">
				<td colspan="2"><h2> 휴면해제 </h2></td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<img src="/furnitureone/oneimg/<%=member.getMimg()%>" width="200" />
				</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><%=member.getMid()%></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="mpw"  /></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="mpwch"  /></td>
			</tr>
			<tr>
				<td> 이름  </td>
				<td><%=member.getMname()%></td>
			</tr>
			<tr>
				<td> 전화번호  </td>
				<td><%=member.getMtel()%></td>
			</tr>
			<tr>
				<td> email </td>
				<td><%=member.getMemail()%></td>
			</tr>
			<tr height="30">
				<td colspan="2" align="right">
					<input type="submit" value="휴면해제" />     
				</td>
			</tr>
		</table>
	</form>
	</div>
	<br/><br/><br/><br/><br/><br/>
	
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

