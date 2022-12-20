<%@page import="web.team.one.BuyDTO"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>refundForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<script >
		function checkField(){
			let inputs = document.refund;
			if(!inputs.hreason.value){
				alert("환불사유을 입력해주세요.")
				return false;
			}
			
			
		}
	
	
	</script>
	
	
	<style>
		.side {
            background-color: #9A9483;
       	  	 width: 180px;
       	  	 height: 820px;
			 float: left;
	   		
        }
        .box1 {
            background-color: silver;
            width: 130px;
            height : 620px;
            margin: 0px;
            padding: 20px;
            float: left;
        }
        .box2 {
            background-color: silver;
            width: 410px;
            height : 330px;
            margin: 10px;
            padding: 20px;
            float: left;
        }
        .box3 {
            background-color: silver;
            width:  600px;
            height : 170px;
            margin: 10px;
            padding: 30px;
            clear: both;
        }
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
</head>
<%	
	//로그인 확인
	String Mid =(String)session.getAttribute("memId");
	int Pnum =Integer.parseInt(request.getParameter("Pnum"));
	int Bnum =Integer.parseInt(request.getParameter("Bnum"));
	
	MemberDAO memDAO = new MemberDAO();
	int Mnum= memDAO.getMnum(Mid); 
	 
	ProductDAO dao =new ProductDAO();
	ProductDTO product =dao.getOneProduct(Pnum);
	
	BuyDAO buy = new BuyDAO();  
	BuyDTO bnum = buy.getbuyreview(Pnum);  
%>

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
	<br />
	<div class="side">
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
	<br /><br /><br /><br />
	<form action="refundPro.jsp" method="post" name="refund" onsubmit="return checkField()" enctype="multipart/form-data">
		<input type="hidden" name="Bnum" value="<%=Bnum%>" />
		<input type="hidden" name="Pname" value="<%=product.getPname()%>" />
		<input type="hidden" name="Snum" value="<%=bnum.getSnum()%>" />
			<table width="680"height="500">
				<tr height="60">
					<td colspan="3"> <h2>환불 상품 정보</h2> </td> 
				</tr>
				<tr>
					<td>이미지</td>
					<td>
						<img src="/furnitureone/oneimg/<%=product.getPimg()%>" width="150" height="150"/>
						<%-- 히든으로는 기존에 사용자가 등록했던 이미지 파일명 숨겨서 보내기 --%>
						<input type="hidden" name="exMimg" value="<%=product.getPimg()%>" />
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td> <%= Mid %> </td>
				</tr>
				<tr>
					<td>상품명</td>
					<td> 
						<%= product.getPname()  %>
					</td>
				</tr>
				<tr>
					<td>색상</td>
					<td> <%= product.getPcolor() %> </td>
				</tr>
				
				<tr>
					<td>개수</td>
					<td> <%= bnum.getBbuyst() %>개 </td>
				</tr>
				<tr>
					<td>가격</td>
					<td> <%= bnum.getBprice() %>원 </td>
				</tr>
				<tr>
					<td>환불 사유</td>
					<td> 
						<textarea rows="10" cols="50" name="hreason"></textarea>
					</td>
				</tr>
				<tr height="30">
					<th></th>
					<th align="right" height="30"> 
						<input type="submit" value="환불 신청"/>
						<input type="button" value="취소" onclick="history.go(-1)" />
					</th>
				</tr>
			</table>
		</form>
	
	
	
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