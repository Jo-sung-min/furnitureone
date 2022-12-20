<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.AddressDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.AddressDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css"/>

<%
	// 로그인된 사람만 들어올 수 있게
	String Mid =(String)session.getAttribute("memId");

	
	 
%>	
<%if(Mid==null){ //로그인 분기처리%>
		<%--헤더 --%>
		<script>
			alert("로그인 후 이용해주세요");
			window.location.href = "loginForm.jsp";
		</script>
		
<%}else{ %>
	<br />
		<header>
	       <div class="inner">
	          	<div class="header-container">
           	 	 	<div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	  	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
          	  	 	<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
          	  	 		<button onclick="window.location='prebuyForm.jsp'"> 장바구니 </button>
          	  	 	</div>  
          		</div>   
      		</div>
   		</header>
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
	<br /><br />


	
<%
	// 취소 눌렀을때 왔던 상세 페이지 파라미터 가져갈 수 있게
	// 회원정보 하나 가져오는 메서드
	MemberDAO dao1 =new MemberDAO();
	int Mnum = dao1.getMnum(Mid);
	MemberDTO member =dao1.getMember(Mnum);  


	//클릭해서 들어올떄 상품 고유번호 가져와서 뿌려주는 메서드
	int Pnum =Integer.parseInt(request.getParameter("Pnum"));
	ProductDAO dao2 =new ProductDAO();
	ProductDTO product =dao2.getOneProduct(Pnum);    
//	System.out.println(product.getPcolor());
	
	int Snum = dao1.getMnum(product.getMid());
	System.out.println("에스넘"+Snum);
%>	
	
	
	
	
	
<%
	//주소 
	// 아이디 체크해서 등록된 주소 불러오는 메서드 
	// 상품 고유번호 받아서(상품 구매 누르고 넘어오니까) 등록된 주소 가져오는 메서드
	AddressDAO dao3 = new AddressDAO();
	List<AddressDTO> list =dao3.getAddress(Mnum);
	//각 아이디에 등록된 주소 세어주고 있으면 뿌려주고 없으면 안뿌려줌
	int count = dao3.addressCount(Mnum);
%>




<%
	//상품구매(현재페이지)로 들어올떄 전페이지에서 히든으로 보내줘야함 
	//가격
	//보내줘야하는 값 구매자정보, 상품정보
	
%>



<body>



	<form action="buyPro.jsp" method="post"  >
		<input type="hidden" name="Pnum" value="<%=Pnum%>" /> 
		<input type="hidden" name="Mnum" value="<%=Mnum%>" /> 
		<input type="hidden" name="Snum" value="<%=Snum%>" /> 
		<input type="hidden" name="pprice" value="<%=product.getPprice()%>" />
			<br /><br /><br />
			
			<table width="400" height="500">
				<tr height="60">
					<td colspan="2"><h2>구 매 양 식</h2></td>
				</tr>
				<tr>
					<td>구매자 이름</td>
					<td><%=member.getMname()%></td>
				</tr>
				<tr>
				<td>주소 선택</td> 
				<td align="left"> 
					<%if(count==0){//등록된 주소가 없을떄%>
							등록된 주소가 없습니다. 
					<%}else{%>
							<input type="radio" name="baddr" value="newAddr" checked/>새주소 등록<br/>
						<%for(int i = 0 ;i<list.size() ; i++){
								   //등록된 주소가 있을떄
							AddressDTO address = list.get(i);%>
							<input type="radio" name="baddr" value="<%=address.getMaddr()%>" /><%=address.getMaddr()%> <br/>
						<%}//for문 닫힘%>
					<%}//else 문 닫힘 %>
					</td>
				</tr>
				<tr>
					<td>새 주소추가</td>
					<td> <textarea rows="5" cols="25" name="addr1" placeholder="ex)00시 00구" ></textarea> </td>
				</tr>
				<tr>
					<td>상품명</td>
					<td><%=product.getPname() %></td> 
				</tr>
				<tr>
					<td>이미지</td>
					<td> <img src="/furnitureone/oneimg/<%=product.getPimg()%>" width =150px> </td> 
				</tr>
				<tr>
					<td>구매개수</td>
					<td onselect="5" align="center">
					<select name="bbuyst" >
		          		<option value="1" selected>1개</option>
		           		<option value="2" >2개</option>
		           		<option value="3" >3개</option>
		           		<option value="4" >4개</option>
		           		<option value="5" >5개</option>
		   			</select>
					</td>
				</tr>
				<tr>
					<td>개당가격</td>
					<td><%=product.getPprice() %>원</td> 
				</tr>
				<tr>
					<td>결제수단</td>
					<td>
						<select name="bpaytype">
							<option value="card" selected>카드</option>
							<option value="phone">휴대폰</option>
						</select>
					</td>
				</tr>
				<tr height="30">
					<td colspan="2">
					<input type="submit" value="구매"/>
					<input type="reset" value="재작성"/>
					<input type="button" value="취소" onclick="window.location='detailForm.jsp?Pnum=<%=Pnum%>'"/>
					</td>
				</tr>
			</table>	
			
	</form>
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
<%} %>
</html>