<%@page import="web.team.one.InquiryDTO"%>
<%@page import="web.team.one.InquiryDAO"%>
<%@page import="web.team.one.HwanDTO"%>
<%@page import="web.team.one.HwanDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.BuyDTO"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.SellregisDTO"%>
<%@page import="web.team.one.ProductDAO"%>
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
		<style>
		 .container{
	   	  	 background-color: #E5DCC3;
	       	width: 100%;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
	       	padding : 30px;
   		}
        .box1 {
            background-color: #E5DCC3;
       	  	 width: 300;
       	  	 height:500;
			justify-content: center;
	   		
        }
        .box2 {
        	background-color: #E5DCC3;
			width: 300;
			height:500;
			justify-content: center;
	   		
        }
        .box3 {
            background-color: E5DCC3;
	       	width: 300;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
            
        }
    
        .box4 {
            background-color: E5DCC3;
	       	width: 300;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: left;
            
        }
    
	</style> 
</head>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("memId");
	
	MemberDAO memDAO = new MemberDAO();
	int mnum= memDAO.getMnum(id);
	MemberDTO memDTO = memDAO.getMember(mnum); 
	
	
	SellregisDAO sellDAO = new SellregisDAO();
	SellregisDTO sellDTO = sellDAO.getSeller(mnum);
	
	ProductDAO proDAO = new ProductDAO();
	List proList = proDAO.getMyProduct(id);
	
	BuyDAO buyDAO = new BuyDAO();
	List delList = buyDAO.getDelProduct(mnum);
	
	HwanDAO hwanDAO = new HwanDAO();
	List hwanList = hwanDAO.getMyHwan(mnum);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int ok = 0;
	int no = 1;
	
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
          	  	 </div>  
          	</div>         
      	</div>
   	</header>
	<%if(id == null){ %>
		<script>
			alert('로그인 후 이용하세요.');
			window.location.href = "loginForm.jsp";
		</script>
	<%}else{ %>
	<br/><br />
	
	<div class="container">
	<div class="box1">
		<form action="modifyForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530" height="407.38">
				<tr height="60">
					<td colspan="2"><h2>회원 정보</h2></td>
				</tr>
				<tr>
					<td>프로필 사진</td>
					<td>
						<%if(memDTO.getMimg() != null){ %>
							<img width="140" height="140" src="/furnitureone/oneimg/<%=memDTO.getMimg()%>"/>
						<%}else{ %>
							<img width="140" height="140" src="/furnitureone/oneimg/default.png"/>
						<%} %>
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><%=memDTO.getMid() %></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><%=memDTO.getMname() %></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><%=memDTO.getMemail() %></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><%=memDTO.getMtel() %></td>
				</tr>
				<tr height="55">
					<td colspan="2" align="right">
						<input type="submit" value="정보 수정"/><br/>
						<input type="button" value="휴면 계정 전환" onclick="window.location.href='stop.jsp'" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="box2">
		<form>
			<table width="530" height="407.38">
				<tr height="60">
					<td colspan="2"><h2>회사 정보</h2></td>
				</tr>
				<%if(sellDTO != null){ %>
					<tr>
						<td>회사 이름</td>
						<td><%=sellDTO.getScompany() %></td>
					</tr>
					<tr>
						<td>회사 대표</td>
						<td><%=sellDTO.getSrepresent() %></td>
					</tr>
					<tr>
						<td>회사 번호</td>
						<td><%=sellDTO.getScall() %></td>
					</tr>
					<tr>
						<td>회사 주소</td>
						<td><%=sellDTO.getSaddr() %></td>
					</tr>
					<tr height="54.88">
						<td colspan="2" align="right">
						정보 수정 시 고객센터에 문의해주세요.<br />
						문의 전화번호 1577-5670
						</td>
					</tr>
				<%}else{ %>
					<tr>
						<td colspan="2" >
							<h3>정보가 없습니다. 판매자 신청 후 확인하세요</h3> 
						</td>
					</tr>
					<tr height="55">
						
					</tr>
				<%} %>
			</table>
		</form>
	</div>
	</div>
	
	
	<div class="container">
	<div class="box3">
		<form action="delSellListForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530" height="551">
				<tr height="83.75">
					<td colspan="8"><h2>배송 상품</h2></td>
				</tr>
				<tr height="30">
					<td>상품명</td>
					<td>개수</td>
					<td>가격</td>
					<td>구매자 ID</td>
					<td>구매자 전화번호</td>
					<td>구매 일자</td>
				</tr>
				<%if(delList == null){ %>
					<tr>
						<td colspan="8"><h3>배송중인 상품이 없습니다.</h3></td>
					</tr>
					<tr height="35">
						<td colspan="8"></td>
					</tr>
				<%} 
				else if(delList.size() <= 3){
					for(int i=0; i<delList.size(); i++){ 
						BuyDTO buyDTO = (BuyDTO)delList.get(i);
					%>
				<tr>
					<%ProductDTO dto = proDAO.getOneProduct(buyDTO.getPnum()); %>
					<td><%=dto.getPname() %></td>
					<td><%=buyDTO.getBbuyst() %>개</td>
					<td><%=buyDTO.getBprice() %>원</td>
					<% MemberDTO dto2 = memDAO.getMember(buyDTO.getMnum());%>
					<td><%=dto2.getMid() %></td>
					<td><%=dto2.getMtel() %></td>
					<td><%=sdf.format(buyDTO.getBreg()) %></td>
				</tr>
				<%}%>
				<tr height="30">
					<td align="right" colspan="8"><input type="submit" value="더보기"/></td>
				</tr>
				<%}else if(delList.size() > 3){
					for(int i=0; i<3; i++){ 
						BuyDTO buyDTO = (BuyDTO)delList.get(i);
					%>
				<tr>
					<%ProductDTO dto = proDAO.getOneProduct(buyDTO.getPnum()); %>
					<td><%=dto.getPname() %></td>
					<td><%=buyDTO.getBbuyst() %>개</td>
					<td><%=buyDTO.getBprice() %>원</td>
					<% MemberDTO dto2 = memDAO.getMember(buyDTO.getMnum());%>
					<td><%=dto2.getMid() %></td>
					<td><%=dto2.getMtel() %></td>
					<td><%=sdf.format(buyDTO.getBreg()) %></td>
				</tr>
				<%}%>
				<tr height="30">
					<td align="right" colspan="8"><input type="submit" value="더보기"/></td>
				</tr>
				<%} %>
			</table>
		</form>
	</div>
	<br/>
	<div class="box3">
		<form action="uploadListForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530" height="551">
				<tr height="60">
					<td  align="center" colspan="9" ><h2>등록 상품</h2>
						<%if(sellDTO == null){ %>
							<input type="button" value="판매자 등록 신청" onclick="window.location.href='sellRegistForm.jsp'"/>
						<%}else{ 
							if(sellDTO.getScon()==0){%>
								관리자 승인 대기 중
							<%}else{%>
								<input type="button" value="상품 등록" onclick="window.location.href='regisForm.jsp'"/>
							<%}%>
						<%} %>
					</td>
				</tr>
				<tr height="30">
					<td>이미지</td>
					<td>상품명</td>
					<td>판매량</td>
					<td>판매이익</td>
					<td>재고</td>
					<td>등록 일자</td>
				</tr>
				<%if(proList == null){ %>
					<tr>
						<td colspan="9"><h3>등록된 상품이 없습니다.</h3></td>
					</tr>
					<tr height="35">
						<td colspan="8"></td>
					</tr>
				<%}else if(proList.size() < 3){ 
					for(int i =0;i<proList.size();i++){
						ProductDTO proDTO = (ProductDTO)proList.get(i);%>
					<tr>
						<td><img width="50px" src="/furnitureone/oneimg/<%=proDTO.getPimg()%>"/></td>
						<td><%=proDTO.getPname() %></td>
						<td><%=proDTO.getPsellst() %>개</td>
						<td><%=proDTO.getPprice() * proDTO.getPsellst() %>원</td>
						<td><%=proDTO.getPstock() %>개</td>
						<td><%=sdf.format(proDTO.getPreg()) %></td>
					</tr>
					<%} %>
					<tr height="30">
						<td align="right" colspan="9"><input type="submit" value="더보기"/></td>
					</tr>
				<%}else if(proList.size() >= 3){ 
					for(int i =0;i<3;i++){
						ProductDTO proDTO = (ProductDTO)proList.get(i);%>
					<tr>
						<td><img width="100px" src="/furnitureone/oneimg/<%=proDTO.getPimg()%>"/></td>
						<td><%=proDTO.getPname() %></td>
						<td><%=proDTO.getPsellst() %>개</td>
						<td><%=proDTO.getPprice() * proDTO.getPsellst() %>원</td>
						<td><%=proDTO.getPstock() %>개</td>
						<td><%=sdf.format(proDTO.getPreg()) %></td>
					</tr>
					<%} %>
					<tr height="30">
						<td align="right" colspan="9"><input type="submit" value="더보기"/></td>
					</tr>
				<%} %>
			</table>
		</form>
		</div>
		</div>
		
		
		<div class="container">
		<div class="box3">
		<form action="hwanListForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530"height="450">
				<tr height="60">
					<td  align="center" colspan="5"><h2>환불 요청 상품</h2>
					</td>
				</tr>
				<tr height="30">
					<td>상품명</td>
					<td>사유</td>
					<td>환불 신청 일자</td>
				</tr>
				<%if(hwanList == null){ %>
					<tr>
						<td colspan="5"><h3>환불 신청된 상품이 없습니다.</h3></td>
					</tr>
					<tr height="35">
						<td colspan="3"></td>
					</tr>
				<%}else if(hwanList.size() <= 3){
					for(int i =0;i<hwanList.size();i++){
						HwanDTO hwanDTO = (HwanDTO)hwanList.get(i);%>
					<tr>
						<%int pnum = proDAO.getPnum(hwanDTO.getBnum()); 
						System.out.println(pnum);
						ProductDTO proDTO = proDAO.getOneProduct(pnum);				
						%>
						<td><%=proDTO.getPname() %></td>
						<td><%=hwanDTO.getHreason() %></td>
						<td><%=sdf.format(hwanDTO.getHreg()) %></td>
					</tr>
					<%} %>
					<tr height="35">
						<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
					</tr>
				<%}else if(hwanList.size() > 3){ 
					for(int i =0;i<3;i++){
						HwanDTO hwanDTO = (HwanDTO)hwanList.get(i);%>
					<tr>
						<%int pnum = proDAO.getPnum(hwanDTO.getBnum()); 
						ProductDTO proDTO = proDAO.getOneProduct(pnum);				
						%>
						<td><%=proDTO.getPname() %></td>
						<td><%=hwanDTO.getHreason() %></td>
						<td><%=sdf.format(hwanDTO.getHreg()) %></td>
					</tr>
					<%} %>
					<tr height="35">
						<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
					</tr>
				<%} %>
			</table>
		</form>
		</div>
<%
	InquiryDAO inDAO = new InquiryDAO();
	InquiryDTO inDTO = new InquiryDTO();
	List inList = inDAO.getsellerInquiry(id);
	

%>		

		<div class="box3">
		<form action="myQuestionList.jsp" method="post">
			<table width="530"height="450">
				<tr height="60">
					<td colspan="3" >
						<h2>상품 문의 내역</h2>
					</td>
				</tr>
				<tr height="30">
					<td>ID</td>
					<td>내용</td>
					<td>작성시간</td>
				</tr>
				<%if(inList.size() == 0){ %>
					<tr >
						<td colspan="3">
							<h3>상품문의가 없습니다</h3>
						</td>
					</tr>
					<tr height="35">
						<td colspan="3"></td>
					</tr>
				<%}else if(inList.size() <= 3){ 
					for(int i = 0; i<inList.size(); i++){
						inDTO = (InquiryDTO)inList.get(i);
					%>
						<tr>
							<td><%=inDTO.getMid() %></td>
							<td><%=inDTO.getQuestion() %></td>
							<td><%=sdf.format(inDTO.getQreg()) %></td>
						</tr>
					<%}
				%>
					<tr height="35">
						<td colspan="3" align="right">
							<input type="submit" value="더보기"/>
						</td>
					</tr>
				<%}else if(inList.size() >= 3){ 
					for(int i = 0; i<3; i++){
						inDTO = (InquiryDTO)inList.get(i);
					%>
						<tr>
							<td><%=inDTO.getMid() %></td>
							<td><%=inDTO.getQuestion() %></td>
							<td><%=inDTO.getQreg() %></td>
						</tr>
					<%}
				%>
					<tr height="35">
						<td colspan="3" align="right">
							<input type="submit" value="더보기"/>
						</td>
					</tr>
				<%} %>
			</table>
		</form>
		</div>
		</div>
		
		
	<div class="box4">
	<footer1>
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
	<%} %>
</body>
</html>