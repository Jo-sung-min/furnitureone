<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.InquiryDTO"%>
<%@page import="web.team.one.InquiryDAO"%>
<%@page import="web.team.one.ZzimDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.ReviewDAO"%>
<%@page import="web.team.one.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="style.css" rel="stylesheet" type="text/css"/>
<style >
	
			
	 .center{
 	  	 background-color: #E5DCC3;
	       	width: 100%;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
		} 
		    
		.box1 {
		   background-color: #E5DCC3;
		       	  	 width: 300;
		       	  	 height:350;
					justify-content: center;
		}
		
		.divFrame {
			width: 450px; 
			height: 350px;
			background-color: #E5DCC3;
			justify-content: center;
		}
		
		.box2 {
		   background-color: #E5DCC3;
		       	  	 width: 300;
		       	  	 height:500;
					justify-content: center;
		    
		    
		}
		.box3 {
			background-color: #E5DCC3;
			width: 100%;
			float: right;
			display: flex;
		    flex-direction: row;
		}
		.box4 {
			background-color: #E5DCC3;
			width: 100%;
			float: right;
			display: flex;
		    flex-direction: row;
		}
		.box5 {
			background-color: #E5DCC3;
			width: 100%;
			float: right;
			display: flex;
		    flex-direction: row;
			justify-content: center;
		}
    	 .box6 {
            background-color: E5DCC3;
	       	width: 100%;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: left;
            
        }
    
    		
			
	</style>


</head>
<%
	//로그인 확인
	String Mid =(String)session.getAttribute("memId");



    //물건 정보 누르고 들어오는 상세페이지
	int Pnum =Integer.parseInt(request.getParameter("Pnum"));
	//int Snum =Integer.parseInt(request.getParameter("Snum"));
	//리뷰 가져오는 메서드
	ReviewDAO dao = new ReviewDAO();
	//가져온 리뷰 담을 객체
	List<ReviewDTO>list = dao.getReview(Pnum,1,5);
	//리뷰 세어주는 메서드
	int count = dao.reviewCount(Pnum);
	int number = count;

%>


<%
	//이페이지 눌렀을때 가pnum 가져옴
	//물건 정보 가져와서 뿌려주는 get 메서드
	ProductDAO dao1   = new ProductDAO(); 
	ProductDTO product= dao1.getOneProduct(Pnum); 
	
	
	
	//아이디 가져오기 위해서
	MemberDAO dao2 = new MemberDAO(); 
	int Mnum =dao2.getMnum(Mid);
	MemberDTO member =dao2.getMember(Mnum); 

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>


<body>

<%if(Mid==null){ //로그인 분기처리%>
	<%--헤더 --%>
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
		<br/><br/>
<%}else{ %>
	<header>
	  	<div class="inner">
	         <div class="header-container">
          	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	 	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
         	  	 		<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
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
   	<br/><br/>
<%} %>



	<br/><br/><br/>	
	
		<%--상품의 색 나타내는 테이블 --%>
		<div class='center'>
		<div class="divFrame" align="center">
					<img src="/furnitureone/oneimg/<%=product.getPimg() %>" width="250"><br/><br/>
					<a id="btnWhite"><img src="/furnitureone/oneimg/white.png" width="50"> </a>
					<a id="btnGray"><img src="/furnitureone/oneimg/LightGray.png" width="50"> </a>
					<a id="btnBlack"><img src="/furnitureone/oneimg/DimGray.png" width="50"> </a>
					<a id="btnBrown"><img src="/furnitureone/oneimg/Tan.png" width="50"> </a>
					<a id="btnRed"><img src="/furnitureone/oneimg/IndianRed.png" width="50"> </a>
					<a id="btnGreen"><img src="/furnitureone/oneimg/SeaGreen.png" width="50"> </a>
					<a id="btnBlue"><img src="/furnitureone/oneimg/LightBlue.png" width="50"> </a>
		</div>
	<script>
	$(document).ready(function(){
		
		// white버튼에 이벤트 달기 
		$("#btnWhite").click(function(){
			$(".divFrame").css("background-color","#FFF8DC"); 
		}); 
		// gray버튼에 이벤트 달기 
		$("#btnGray").click(function(){
			$(".divFrame").css("background-color","LightGray"); 
		}); 
		// black버튼에 이벤트 달기 
		$("#btnBlack").click(function(){
			$(".divFrame").css("background-color","DimGray"); 
		}); 
		// brown버튼에 이벤트 달기 
		$("#btnBrown").click(function(){
			$(".divFrame").css("background-color","Tan"); 
		}); 
		// red버튼에 이벤트 등록
		$("#btnRed").click(function(){
			$(".divFrame").css("background-color","#CD5C5C"); 
		}); 
		// green버튼에 이벤트 등록
		$("#btnGreen").click(function(){
			$(".divFrame").css("background-color","DarkSeaGreen"); 
		}); 
		// blue버튼에 이벤트 등록
		$("#btnBlue").click(function(){
			$(".divFrame").css("background-color","LightBlue"); 
		}); 
	
	});
	</script>

	
	<%
			String zzimCon = "0";
		if(session.getAttribute("memId")==null){
			 zzimCon = "0";
		}else{
			ZzimDAO dao4 =new ZzimDAO();
			int con =dao4.getZzimCon(Pnum, Mnum);
			
			if(con==1){
				zzimCon ="1";
				System.out.println(zzimCon+"쮬컨");
			}else if(con==0){			
				zzimCon ="0";
				System.out.println(zzimCon+"쮬");
			}
			
		}
	%>
		<%--상품 나타내는 테이블 --%>	
	<div class="box2">	
	<form action="buyForm.jsp" method="post">
		<%--<input type="hidden" name="Snum" value="<%=Snum%>" /> --%> 
		<input type="hidden" name="Pnum" value="<%=Pnum%>" />  
	
		<table width="450" height="350">
			<tr >
				<td align="left"  >상품명</td> 
				<td colspan="2" ><%=product.getPname()%></td> 
			</tr>
			<tr>
				<td align="left" >재고량</td> 
				<%if(product.getPstock()!=0){ %>
					<td  colspan="2"><%=product.getPstock()%></td> 
				<%}else{%>
					<td  colspan="2">제품 준비중 입니다.</td> 
				<%} %>
			</tr>
			<tr>
				<td align="left" >가격</td> 
				<td colspan="2"><%=product.getPprice()%></td> 
			</tr>
			
			<tr>
				<%if(zzimCon.equals("0")){// 찜 안했을때 %>
					<td align="center" rowspan="3"> <a href="pickPro.jsp?Pnum=<%=product.getPnum()%>" ><img src="/furnitureone/oneimg/bbiin.png" width=100></a></td> 
				<%}else if(zzimCon.equals("1")){ %>
					<td align="center" rowspan="3"> <a href="pickPro.jsp?Pnum=<%=product.getPnum()%>" ><img src="/furnitureone/oneimg/zziim.png" width=100></a></td> 
				<%} %>
			</tr>
			
			<tr><%if(session.getAttribute("memId") != null){ %>
					<%if(session.getAttribute("memId").equals("admin") || member.getMtype().equals("seller")){ %>
					<%}else if(session.getAttribute("memId") != null){%>
						<td align="center"> <input type="button" value="장바구니 추가" onclick="window.location='prebuyPro.jsp?Pnum=<%=Pnum%>&Ccount=<%=product.getPstock()%>&Pname=<%=product.getPname()%>'"></td>  
					<%} %>
				</tr>
				<tr>
					<%if(session.getAttribute("memId").equals("admin") || member.getMtype().equals("seller")){ %>
					<%}else if(session.getAttribute("memId") != null){%>
						<td align="center"  >	<input type="submit" value="구매"> </td>  
					<%} %>
				<%} %>
			</tr>
		</table>
	</form>
	</div>
	</div>



		<%--상품의 설명--%>
		<div class="box3">
		<table width="900" height="250">
			<tr height="60">
				<td> <h2>상 품 설 명</h2> </td>
			</tr>
			<tr>
				<td > <textarea rows="10" cols="45" readonly ><%=product.getPcontent()%></textarea>  </td>
			</tr>
		</table>
		</div>
	
	
	
	
	<%--상품의 리뷰 나타내는 테이블 --%>
		<div class="box4">
		<table width="900" height="250">
			<tr height="60">
				<td colspan="6"> <h2> <%=product.getPname()%>의 리뷰</h2> </td>
			</tr>
			<tr height="30">
				<td>리뷰</td>
				<td>ID</td>
				<td>이미지</td>
				<td>내용</td>
				<td>평점</td>
				<td>등록일</td>
			</tr>
				<%
				
				if(count>5){
				for(int i = 0 ;i<5 ;i++){
				ReviewDTO review = list.get(i);   
				member= dao2.getMember(review.getMnum()); 
				%>
				<tr>
					<td><%=number--%></td>
					<td><%=member.getMid()%></td>
					<td align="center">
						<img src="/furnitureone/oneimg/<%=review.getRimg()%>" width="150" />
					</td>				
					<td><%=review.getRcontent() %></td>
					<td><%=review.getRgrade() %></td>
					<td><%=sdf.format(review.getRreg()) %></td>
				</tr>
				<%}
				}else if(count<=5&&count>0){
				for(int i = 0 ;i<list.size() ;i++){
				ReviewDTO review = list.get(i);   
				member= dao2.getMember(review.getMnum()); 
				%>
				<tr>
					<td><%=number--%></td>
					<td><%=member.getMid()%></td>
					<td align="center">
						<img src="/furnitureone/oneimg/<%=review.getRimg()%>" width="150" />
					</td>				
					<td><%=review.getRcontent() %></td>
					<td><%=review.getRgrade() %></td>
					<td><%=sdf.format(review.getRreg()) %></td>
				</tr>
				
				<%}
				}else{%>
					<tr>
						<td colspan="7">등록된 리뷰가 없습니다.</td>
					</tr>
				<%} %>
				
			<tr height="30">
				<td align="right" colspan="6">
				 <input type="button" value="리뷰 전체보기" onclick="window.location='reviewListForm.jsp?Pnum=<%=Pnum%>'"></td>
			</tr>
		</table>
		</div>
		
<%
	InquiryDAO inDAO = new InquiryDAO();
	InquiryDTO inDTO = new InquiryDTO(); 
	List inList = inDAO.getInquiry(Pnum);
	

%>		

		<div class="box5">
		<form action="inquiryList.jsp?pnum=<%=Pnum %>" method="post">
			<table width="900" height="300">
				<tr height="60">
					<td colspan="3">
						<h2> <%=product.getPname()%> 문의</h2>
						<%if(session.getAttribute("memId") != null){%>
							<input type="button" value="질문 작성" onclick="window.location.href='writeQForm.jsp?pnum=<%=Pnum%>'"/>
						<% }%>
					</td>
				</tr>
				<tr height="30">
					<td>작성자ID</td>
					<td>내용</td>
					<td>작성시간</td>
				</tr>
				<%if(inList == null){ %>
					<tr>
						<td colspan="3">
							<h3>답변 완료된 문의가 없습니다</h3>
						</td>
					</tr>
				<%}else if(inList.size() <= 3){ 
					for(int i = 0; i<inList.size(); i++){
						inDTO = (InquiryDTO)inList.get(i);
					%>
						<tr>
							<td><%=inDTO.getMid() %></td>
							<%if(inDTO.getMid().equals(Mid)){ %>
									<td><textarea placeholder="<%=inDTO.getQuestion() %>"></textarea></td>
								<%}else if(inDTO.getIcon() == 1){%> 
									<td><textarea placeholder="비공개 문의입니다"></textarea></td>
								<%} %>
							<td><%=sdf.format(inDTO.getQreg()) %></td>
						</tr>
					<%}
				%>
					<tr height="30">
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
							<%if(inDTO.getIcon() == 1){ %>
								<td>비공개 문의입니다.</td>
							<%}else{ %>
								<td><%=inDTO.getQuestion() %></td>
							<%} %>
							<td><%=inDTO.getQreg() %></td>
						</tr>
					<%}
				%>
					<tr height="30">
						<td colspan="3" align="right">
							<input type="submit" value="더보기"/>
						</td>
					</tr>
				<%} %>
			</table>
		</form>
		</div>
		
	<footer1>
	<div class="box5">	
       <div class="inner">
          <div class="footer-container">
            <h2 align="left">Furniture One</h2>
			<a>개인정보 처리 방침． 서비스이용약관． 위치서비스 약관． 회사소개． 채용정보．</a> 
			<a>상호명：㈜F.O ｜ 대표이사 : 김대헌 ｜ 주소 : 서울특별시 마포구 신촌로 94, 7층(노고산동, 그랜드플라자)</a> 
			<a>사업자등록번호：187-85-01021｜개인정보보호책임자 : 더조은｜사업자정보확인</a>  
          </div>
       </div>
    </div>
    </footer1>
</body>
</html>