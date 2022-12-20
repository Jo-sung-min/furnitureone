<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>reviewForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	
<% 
	//로그인 확인
	String Mid =(String)session.getAttribute("memId");
	int Pnum =Integer.parseInt(request.getParameter("Pnum"));
	int Bnum =Integer.parseInt(request.getParameter("Bnum"));
	System.out.println(Pnum);
	System.out.println(Bnum);
	MemberDAO dao1 = new MemberDAO(); 
	int Mnum =dao1.getMnum(Mid);
	//로그인했으면 맴버넘버 가져와주기
	
	
	//Pnum 해당하는 상품 가져오는 메서드
	ProductDAO dao =new ProductDAO();
	ProductDTO product =dao.getOneProduct(Pnum); 
%>	
	
	<script>
		//유효성 검사
		function checkField() {
			let inputs = document.reviewForm;
			if(!inputs.rcontent.value) {
				alert("리뷰내용을 입력해주세요.")
				return false;
			
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
          	  	 		<button onclick="window.location='mypageBuyerForm.jsp'"> 마이페이지 </button>
          	  	 	</div>  
          		</div>   
      		</div>
   		</header>
	<br /><br /><br /><br /><br /><br />
	
	
	
	<%--마이페이지에서 구매한 상품 리뷰 눌렀을때 오는 페이지 --%>
	<div class="container">
	<div class="box1">
		<table width="500" height="450">
			<tr height="70">
				<td colspan="5"> <h2>리뷰 남길 상품 </h2>  </td>
			</tr>
			
			<tr >
				<td rowspan="1"><div1 align="center"> <img src="/furnitureone/oneimg/<%=product.getPimg()%>" width= 150px></div1></td> 
					<th align="left">
						상품명 : <%=product.getPname()%>	<br/><br/>
						가격 : <%=product.getPprice()%>원	<br/><br/>
						색상 : <%=product.getPcolor()%>		<br/><br/>
						상품설명 : <%=product.getPcontent()%>	<br/><br/>
					</th>
			</tr>
			<tr height="30" >
				<td colspan="2"></td>
			</tr>
				
		</table>
	</div>
   	<div class="box2">
   		<form action="reviewPro.jsp" method="post" name="reviewForm" onsubmit="checkField()" enctype="multipart/form-data">
   			<input type="hidden" name="Pnum" value="<%=Pnum%>" /> 
   			<input type="hidden" name="Mnum" value="<%=Mnum%>" /> 
   			<input type="hidden" name="Bnum" value="<%=Bnum%>" /> 
			<table width="500" height="450">
				<tr height="70">
					<th > 이미지 등록 </th>
					<th colspan="6"> <input type="file" name="rimg"/> </th>
				</tr>
				<tr>
					<td onselect="5" align="left" colspan="7">　　평점　　　　　　　　　　　　　　　　
						<select name="rgrade" >
			          		<option value="5"  selected>★★★★★</option>
			           		<option value="4" >★★★★☆</option>
			           		<option value="3" >★★★☆☆</option>
			           		<option value="2" >★★☆☆☆</option>
			           		<option value="1" >★☆☆☆☆</option>
		   				</select>
					</td>
				</tr>
				
				<tr>
					<th > 리뷰 </th>
					<th colspan="5">
						<textarea cols="30" rows="10" name="rcontent"></textarea>
					</th>
				</tr>
				<tr height="30">
					<th colspan="6">
						<input type="submit" value="등록" /> 
						<input type="button" value="취소" onclick="history.go(-1)" /> 
						<%-- onclick="window.location='detailForm.jsp?Pnum=<%=Pnum%>'" --%>
					</th>
				</tr>
			</table>
		</form>
   	</div>
   	</div>
   	
   	
   	
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