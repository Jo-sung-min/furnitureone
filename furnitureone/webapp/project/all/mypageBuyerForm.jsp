<%@page import="web.team.one.InquiryDTO"%>
<%@page import="web.team.one.InquiryDAO"%>
<%@page import="web.team.one.ReviewDTO"%>
<%@page import="web.team.one.HwanDTO"%>
<%@page import="web.team.one.HwanDAO"%>
<%@page import="web.team.one.ReviewDAO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.BuyDTO"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head> 
	<meta charset="UTF-8">
	<title>mypageBuyerForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
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
	request.setCharacterEncoding("UTF-8");
	// 로그인했을때만 접근가능한 페이지 
	String mid = (String)session.getAttribute("memId");
%>
<jsp:useBean id="dto" class="web.team.one.BuyDTO"/>
<%	
	MemberDAO dao = new MemberDAO();
	int mnum = dao.getMnum(mid);
	MemberDTO member = dao.getMember(mnum);
	
	ProductDAO proDAO = new ProductDAO();
	//List orderList = null;
	
	//현재 요청된 게시판 페이지 번호 
	String pageNum = request.getParameter("pageNum"); 
	if(pageNum == null){ // pageNum 파라미터가 안넘어왔을때는 (../jsp08/list.jsp 라고만 요청했을때)
		pageNum = "1";   // 1페이지 보여주기위해 pageNum 값 "1"로 체워주기 
	}
	System.out.println("pageNum : " + pageNum);
	
	// 작성시간 원하는 형태로 화면에 출력하기위한 보조 클래스 객체 생성 
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	// DB에서 전체 글 개수 가져오기 우하하
	BuyDAO dao1 = new BuyDAO();  
	List buyList = dao1.getBuy(mnum);
	
	
	//리뷰 작성 여부
	ReviewDAO reviewdao = new ReviewDAO();
	
	//환불
	HwanDAO hwanDAO = new HwanDAO(); 
	List hwanList = hwanDAO.getBuyerHwan(mnum);
%>
<%
	if(mid == null) { //로그인 안함. %> 
		<script>
			alert("로그인 후 사용 가능한 페이지입니다.");
			window.location.href = "loginForm.jsp";
		</script>
		
<%	}else { //로그인했다. %>
<body>
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
	<br /><br />
	
	<div class="container">
	<div class="box1">
		<form action="modifyForm.jsp" method="post" enctype="multipart/form-data">
			<table width="620" height="467">
				<tr height="60">
					<td colspan="2"> <h2>회원정보</h2> </td> 
				</tr>
				<tr>
					<td>이미지</td>
					<td>
						<%-- 사용자 저장유무를 떠나 DB에 들어가있는 파일명으로 화면에 띄워주기 --%>
						<%if(member.getMimg() == null || member.getMimg().equals("null")){ %>
							<img src="/furnitureone/oneimg/default.png" width="160" height="160"/>
						<%}else{ %>
							<img src="/furnitureone/oneimg/<%=member.getMimg()%>" width="160" height="160"/>
						<%} %>
						<%-- 히든으로는 기존에 사용자가 등록했던 이미지 파일명 숨겨서 보내기 --%>
						<input type="hidden" name="exMimg" value="<%=member.getMimg()%>" />
					</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><%=member.getMid() %></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><%=member.getMname()%></td>
				</tr>
				<tr>
					<td>e-mail</td>
					<td><%=member.getMemail()%></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><%=member.getMtel()%></td>
				</tr>
				<tr>
					<th colspan="2"  align="right"> 
						<input type="submit" value="수정하기"/> 
					</th>
				</tr>
				<tr>
					<th colspan="2"  align="right"> 
						<input type="button" value="휴면계정 전환" onclick="window.location='stop.jsp'" />
					</th>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="box2">
		<form action="buyListForm.jsp" method="post" enctype="multipart/form-data">
		
			<table width="620" height="467">
				<tr height="60">
					<td colspan="9"> <h2> 내가 구매한 상품 목록 </h2> </td>
				</tr>
				<tr height="30">
					<th>이미지</th>
					<th>상품명</th>
					<th>개수</th>
					<th>가격</th>
					<th colspan ="3">
						상품 상태
					</th>
					<th colspan ="2">구매일자</th>
				</tr>
	
         	<%if(buyList == null){ %>
				<tr>
					<td colspan="9"><h3>구매하신 상품이 없습니다.</h3></td>
				</tr> 
				<tr height="30">
					<td colspan="9"></td>
				</tr>
			<%}else if(buyList.size()<=5){ 
				 for(int i = 0 ; i<buyList.size(); i++) {
	            		BuyDTO buy = (BuyDTO)buyList.get(i); %>
						<tr>
						<%ProductDTO pro = proDAO.getOneProduct(buy.getPnum()); %> 
						<%BuyDTO bcon = dao1.getbuy(buy.getBnum()); %>
							<td> 
								<a href="detailForm.jsp?Pnum=<%=buy.getPnum()%>"> 
								<img src="/furnitureone/oneimg/<%=pro.getPimg()%>" width="50" />
							</td>
							<td>
								<%= pro.getPname() %>
							</td>
							<td >
								<%= buy.getBbuyst() %>개
							</td>
							<td >
								<%= buy.getBprice() %>원 
							</td>
							<% if(bcon.getBdelcon() == 1)  { %>
							<% HwanDTO hwan = hwanDAO.gethwan(buy.getBnum()); %> 
								<% if(hwan == null) { %>
									<td> 구매 확정 </td>
									<%if(buy.getBcon()==0) { %>
										<td>
											<input type="button" value="환불신청" onclick="window.location='refundForm.jsp?Pnum=<%=pro.getPnum()%>&Bnum=<%=buy.getBnum() %>'" />
										</td>
										<td>
											<input type="button" value="리뷰작성" onclick="window.location='reviewForm.jsp?Pnum=<%=pro.getPnum()%>&Bnum=<%=buy.getBnum() %>'" />
										</td>
									<% }else {%>
										<td colspan="2">
											리뷰 작성 완료 <br />
											<input type="button" value="리뷰보기" onclick="window.location='reviewListForm.jsp?Pnum=<%=pro.getPnum()%>'" />
										</td>
									<% } %>	
								<% }else if(hwan.getHcon() == 2) { %>
									<td> 구매 확정 </td>
									<%if(buy.getBcon()==0) { %>
										<td>
											환불 불가
										</td>
										<td>
											<input type="button" value="리뷰작성" onclick="window.location='reviewForm.jsp?Pnum=<%=pro.getPnum()%>&Bnum=<%=buy.getBnum() %>'" />
										</td>
									<% }else {%>
										<td colspan="2">
											리뷰 작성 완료 <br />
											<input type="button" value="리뷰보기" onclick="window.location='reviewListForm.jsp?Pnum=<%=pro.getPnum()%>'" />
										</td>
									<% } %>	
								<% }else if(hwan.getHcon() == 0) { %>
									<td colspan ="3">
										환불 진행중인 상품입니다. <%=hwan.getHcon() %>
									</td>
								<% }else { %>
									<td colspan ="3">
										환불 완료 <%=hwan.getHcon() %>
									</td>
								<% } %>	
								
	   	       	  	 		<% }else { %>
	      	  	 				<td colspan ="3">
									배송중인 상품입니다.
								</td>
	      	  	 			<%} %>
								<td colspan ="2">
									<%= sdf.format(buy.getBreg()) %>
								</td>
							</tr>
							
							<%
	       			}%>
	       			<tr>
						<tr height="30" >
						<th align="right" colspan="9">
							<input type="submit" value="더보기"  /> 
						</th>
					</tr>
			<% }else if(buyList.size()> 5){ 	
				 for(int i = 0 ; i<5; i++) {
	            		BuyDTO buy = (BuyDTO)buyList.get(i); %>
						<tr>
						<%ProductDTO pro = proDAO.getOneProduct(buy.getPnum()); %> 
						<%BuyDTO bcon = dao1.getbuy(buy.getBnum()); %>
							<td> 
								<a href="detailForm.jsp?Pnum=<%=buy.getPnum()%>"> 
								<img src="/furnitureone/oneimg/<%=pro.getPimg()%>" width="50" />
							</td>
							<td>
								<%= pro.getPname() %>
							</td>
							<td >
								<%= buy.getBbuyst() %>개
							</td>
							<td >
								<%= buy.getBprice() %>원 
							</td>
							<% if(bcon.getBdelcon() == 1)  { %>
							<% HwanDTO hwan = hwanDAO.gethwan(buy.getBnum()); %> 
								<% if(hwan == null) { %>
									<td> 구매 확정 </td>
									<%if(buy.getBcon()==0) { %>
										<td>
											<input type="button" value="환불신청" onclick="window.location='refundForm.jsp?Pnum=<%=pro.getPnum()%>&Bnum=<%=buy.getBnum() %>'" />  
										</td>
										<td>
											<input type="button" value="리뷰작성" onclick="window.location='reviewForm.jsp?Pnum=<%=pro.getPnum()%>&Bnum=<%=buy.getBnum() %>'" />
										</td>
									<% }else {%>
										<td colspan="2">
											리뷰 작성 완료 <br />
											<input type="button" value="리뷰보기" onclick="window.location='reviewListForm.jsp?Pnum=<%=pro.getPnum()%>'" />
										</td>
									<% } %>	
								<% }else if(hwan.getHcon() == 2) { %>
									<td> 구매 확정 </td>
									<%if(buy.getBcon()==0) { %>
										<td>
											환불 불가
										</td>
										<td>
											<input type="button" value="리뷰작성" onclick="window.location='reviewForm.jsp?Pnum=<%=pro.getPnum()%>&Bnum=<%=buy.getBnum() %>'" />
										</td>
									<% }else {%>
										<td colspan="2">
											리뷰 작성 완료 <br />
											<input type="button" value="리뷰보기" onclick="window.location='reviewListForm.jsp?Pnum=<%=pro.getPnum()%>'" />
										</td>
									<% } %>	
								<% }else if(hwan.getHcon() == 0) { %>
									<td colspan ="3">
										환불 진행중인 상품입니다.
									</td>
								<% }else { %>
									<td colspan ="3">
										환불 완료
									</td>
								<% } %>	
								
	   	       	  	 		<% }else { %>
	      	  	 				<td colspan ="3">
									배송중인 상품입니다.
								</td>
	      	  	 			<%} %>
								<td colspan ="2">
									<%= sdf.format(buy.getBreg()) %>
								</td>
							</tr>
							
					<%
	       				}%>
	       				<tr>
							<tr height="30" >
							<th align="right" colspan="9">
								<input type="submit" value="더보기"  /> 
							</th>
						</tr>
			<%}%>
				
			</table> 
		</form>
	</div>  
	</div>
	<%
		InquiryDAO inDAO = new InquiryDAO();
		InquiryDTO inDTO = new InquiryDTO();
		List inlist = inDAO.myQBuyer(mid); 
	%>
	<div class="container">
	<div class="box3">
		<form action="buyerQList.jsp">
			<table width="620" height="480">
				<tr height="60">
					<td colspan="5">
						<h2>내가 문의한 내역</h2>
					</td>
				</tr>
				<tr height="30">
					<th>이미지</th>
					<th>상품명</th>
					<th>내용</th>
					<th>답변</th>
					<th>작성시간</th>
				</tr>
				<%if(inlist == null){ %>
					<tr>
						<td colspan="5"><h3>문의하신 내역이 없습니다</h3></td>
					</tr>
					<tr height="40">
						<td colspan="5"></td>
					</tr>
				<%}else if(inlist.size() >= 5) { 
						for(int i=0; i < 5 ; i++ ){
							inDTO = (InquiryDTO)inlist.get(i);%>
								<tr >
									<%ProductDTO proDTO = proDAO.getOneProduct(inDTO.getPnum()); %>
									<td>
										<a href="detailForm.jsp?Pnum=<%=inDTO.getPnum()%>"> 
										<img width="50" src="/furnitureone/oneimg/<%=proDTO.getPimg()%>"/>
									</td>
									<td><%=proDTO.getPname() %></td>
									<td><%=inDTO.getQuestion() %></td>
									<%if(inDTO.getAnswer() != null){ %>
										<td><%=inDTO.getAnswer() %></td>
									<%}else{ %>
										<td>아직 답변이 없습니다.</td>
									<%} %>
									<td><%=sdf.format(inDTO.getQreg()) %></td>
								</tr>
						<%}%>
						<tr height="40">
							<td colspan="5" align="right"><input type="submit" value="더보기"/></td>
						</tr>
				<%}else if(inlist.size() < 5){ 
						for(int i=0; i < inlist.size() ; i++ ){
							inDTO = (InquiryDTO)inlist.get(i);%>
								<tr >
									<%ProductDTO proDTO = proDAO.getOneProduct(inDTO.getPnum()); %>
									<td>
										<a href="detailForm.jsp?Pnum=<%=inDTO.getPnum()%>"> 
										<img width="50" src="/furnitureone/oneimg/<%=proDTO.getPimg()%>"/>
									</td>
									<td><%=proDTO.getPname() %></td>
									<td><%=inDTO.getQuestion() %></td>
									<%if(inDTO.getAnswer() != null){ %>
										<td><%=inDTO.getAnswer() %></td>
									<%}else{ %>
										<td>아직 답변이 없습니다.</td>
									<%} %>
									<td><%=sdf.format(inDTO.getQreg()) %></td>
								</tr>
					<%}%>
						<tr height="40">
							<td colspan="5" align="right"><input type="submit" value="더보기"/></td>
						</tr>
				<%} %>
			</table>
		</form>	
	</div>
	
	
	
		
	<div class="box3">
		<form action="hwanList.jsp" method="post" enctype="multipart/form-data">
			
			<table  width="620" height="480">
			
			<tr height="60">
				<td align="center" colspan="9"><h2>환불 요청 상품</h2>
				</td>
			</tr>
			<tr height="30">
				<th>이미지</th>
				<th>상품명</th>
				<th>개수</th>
				<th>가격</th>
				<th colspan ="2">환불 상태</th>
				<th>환불 신청 일자</th>
			</tr>
			<%if(hwanList == null){%>
				<tr>
					<td colspan="9"><h3>요청된 환불이 없습니다</h3></td>
				</tr>
				<tr height="40">
					<td colspan="9"></td>
				</tr>
			<%}else if(hwanList.size()<=5){ %>
				<%for(int i =0;i<hwanList.size();i++){
					 HwanDTO hwanDTO = (HwanDTO)hwanList.get(i);%>
				<tr>
					<%int pnum = proDAO.getPnum(hwanDTO.getBnum()); 
					ProductDTO proDTO = proDAO.getOneProduct(pnum);
					BuyDTO buyDTO = dao1.getbuy(hwanDTO.getBnum());
					%>
					<td>
						<a href="detailForm.jsp?Pnum=<%=pnum%>"> 
						<img src="/furnitureone/oneimg/<%=proDTO.getPimg() %>" width="50" />
					</td>	
					<td><%=proDTO.getPname() %></td>
					<td><%=buyDTO.getBbuyst() %>원</td>
					<td><%=buyDTO.getBprice() %>개</td>
					<%if(hwanDTO.getHcon()==0) {%>
						<td>
							환불 진행중
						</td>
						<td>
							<input type="button" value="환불취소" onclick="window.location='hwanCancle.jsp?Bnum=<%=hwanDTO.getBnum()%>'" />
						</td>
					<%}else if(hwanDTO.getHcon()==1) {%>
						<td colspan ="2">
							환불 완료
						</td>
					<%}else {%>
						<td colspan ="2">
							환불 거절된 상품입니다.
						</td>
					<%} %>
					<td><%=sdf.format(hwanDTO.getHreg()) %></td>
				</tr>
				<%
				} %>
				<tr height="40" >
					<th align="right" colspan="9">
						<input type="submit" value="더보기"  /> 
					</th>
				</tr>
			<%} else if(hwanList.size() >5) { 
				for(int i =0;i<5;i++){
					 HwanDTO hwanDTO = (HwanDTO)hwanList.get(i); %>	
					 	<tr>
					<%int pnum = proDAO.getPnum(hwanDTO.getBnum()); 
					ProductDTO proDTO = proDAO.getOneProduct(pnum);
					BuyDTO buyDTO = dao1.getbuy(hwanDTO.getBnum());
					%>
					<td>
						<a href="detailForm.jsp?Pnum=<%=pnum%>"> 
						<img src="/furnitureone/oneimg/<%=proDTO.getPimg() %>" width="50" />
					</td>	
					<td><%=proDTO.getPname() %></td>
					<td><%=buyDTO.getBbuyst() %>개</td>
					<td><%=buyDTO.getBprice() %>원</td>
					<%if(hwanDTO.getHcon()==0) {%>
						<td>
							환불 진행중
						</td>
						<td>
							<input type="button" value="환불취소" onclick="window.location='hwanCancle.jsp?Bnum=<%=hwanDTO.getBnum()%>'" />
						</td>
					<%}else if(hwanDTO.getHcon()==1) {%>
						<td colspan ="2">
							환불 완료
						</td>
					<%}else {%>
						<td colspan ="2">
							환불 거절된 상품입니다.
						</td>
					<%} %>
					<td><%=sdf.format(hwanDTO.getHreg()) %></td>
				</tr>
			<%	} %>
				<tr height="40" >
					<th align="right" colspan="9">
						<input type="submit" value="더보기"  /> 
					</th>
				</tr>
		<%}%>
		</table>  
			
		</form>
	</div>
	</div>
		
	<footer1>
       <div class="inner">
          <div class="footer-container">
            <h2 align="left">Furniture One</h2>
			<a>개인정보 처리 방침． 서비스이용약관． 위치서비스 약관． 회사소개． 채용정보．</a> 
			<a>상호명：㈜F.O ｜ 대표이사 : 김대헌 ｜ 주소 : 서울특별시 마포구 신촌로 94, 7층(노고산동, 그랜드플라자)</a> 
			<a>사업자등록번호：187-85-01021｜개인정보보호책임자 : 더조은｜사업자정보확인</a> 
			<br /> 
          </div>
       </div>
    </footer>

	

</body>
<%	} %>
</html>