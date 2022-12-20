<%@page import="web.team.one.BuyDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.SellregisDTO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.SellregisDAO"%>
<%@page import="java.util.List"%>
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
            background-color: #E5DCC3;
	       	width: 300;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
            
        }
    
        .box4 {
            background-color: #9A9483;
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
	//Mid 로그인 했을때 관리자인지 확인 분기처리
	String Mid = (String)session.getAttribute("memId");
	MemberDAO memDAO = new MemberDAO();
	int mnum = memDAO.getMnum(Mid);
	MemberDTO member = memDAO.getMember(mnum); 
	
	List buyMemList = memDAO.getBuyers(); 
	
	List sellMemList = memDAO.getSellers(); 
	
	SellregisDAO sellDAO = new SellregisDAO();
	List sellregisList = sellDAO.getRegisSeller();
	
	BuyDAO buyDAO = new BuyDAO();
	List orderList = buyDAO.getAllOrders();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
%>


<%if(Mid.equals("admin")){ %>

<body>
	
	
	<br />
		<header>
	       <div class="inner">
	          	<div class="header-container">
           	 	 	<div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	  	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
          	  	 	<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
          	  	 		<button onclick="window.location='supportForm.jsp'"> 고객센터 </button>
          	  	 	</div>  
          		</div>   
      		</div>
   		</header>
	<br /><br /><br />

	<%--구매회원 목록 --%>
	<div class="container"> 
	<div class="box1">
		<form action="buyMemListForm.jsp" method="post">
			<table width="600" height="350">
				<tr height="60">
					<td colspan="5"><h2>구매회원목록</h2></td>
				</tr>
				<tr height="30">
					<td>아이디</td>
					<td>이름</td>
					<td>이메일</td>
					<td>전화번호</td>
					<td>가입일</td>
				</tr>
				<%if(buyMemList == null){ %>
					<tr>
						<td colspan="5"><h3>회원이 없습니다.</h3></td>
					</tr>
				<%}else if(buyMemList.size()<5){ 
					for(int i = 0; i< buyMemList.size();i++){
						MemberDTO memDTO = (MemberDTO)buyMemList.get(i);%>
						<tr>
							<td><%=memDTO.getMid() %></td>
							<td><%=memDTO.getMname() %></td>
							<td><%=memDTO.getMemail() %></td>
							<td><%=memDTO.getMtel() %></td>
							<td><%=sdf.format(memDTO.getMreg()) %></td>
						</tr>
					<%}%>
				<tr height="30">
					<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
				</tr>
				<%}else if(buyMemList.size()>=5){ 	
					for(int i = 0; i<5;i++){
						MemberDTO memDTO = (MemberDTO)buyMemList.get(i);%>
						<tr>
							<td><%=memDTO.getMid() %></td>
							<td><%=memDTO.getMname() %></td>
							<td><%=memDTO.getMemail() %></td>
							<td><%=memDTO.getMtel() %></td>
							<td><%=sdf.format(memDTO.getMreg()) %></td>
						</tr>
					<%}%>
				<tr height="30">
					<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
				</tr>
				<%} %>
			</table>
		</form>
	</div>
	
	
	
	<%--판매회원 목록 --%>
	<div class="box1">
		<form action="sellMemListForm.jsp" method="post">
			<table width="600" height="350">
				<tr height="60">
					<td colspan="5"><h2>판매회원목록</h2></td>
				</tr>
				<tr height="30">
					<td>아이디</td>
					<td>이름</td>
					<td>이메일</td>
					<td>전화번호</td>
					<td>가입일</td>
				</tr>
				 <%if(sellMemList == null){ %>
					<tr>
						<td colspan="5"><h3>회원이 없습니다.</h3></td>
					</tr>
				<%}else if(sellMemList.size()<5){ 
					for(int i = 0; i< sellMemList.size();i++){
						MemberDTO memDTO = (MemberDTO)sellMemList.get(i);%>
						<tr>
							<td><%=memDTO.getMid() %></td>
							<td><%=memDTO.getMname() %></td>
							<td><%=memDTO.getMemail() %></td>
							<td><%=memDTO.getMtel() %></td>
							<td><%=sdf.format(memDTO.getMreg()) %></td>
						</tr>
					<%}%>
				<tr height="30">
					<td align="right" colspan="5" ><input type="submit" value="더보기"/></td>
				</tr>
				<%}else if(sellMemList.size()>=5){ 
					for(int i = 0; i<5;i++){
						MemberDTO memDTO = (MemberDTO)sellMemList.get(i);%>
						<tr>
							<td><%=memDTO.getMid() %></td>
							<td><%=memDTO.getMname() %></td>
							<td><%=memDTO.getMemail() %></td>
							<td><%=memDTO.getMtel() %></td>
							<td><%=sdf.format(memDTO.getMreg()) %></td>
						</tr>
					<%}%>
				<tr height="30">
					<td align="right" colspan="5" ><input type="submit" value="더보기"/></td>
				</tr>
				<%}%>
			</table>
		</form>
	</div>
	</div>
	
	
	
	<%--판매자 신청 목록 --%>
	<div class="container">
	<div class="box1">
		<form action="sellRegisListForm.jsp" method="post">
			<table width="600" height="390">
				<tr height="60">
					<td colspan="5"><h2>판매자 신청 목록</h2></td>
				</tr>
				<tr height="30">
					<td>아이디</td>
					<td>이름</td>
					<td>이메일</td>
					<td>전화번호</td>
					<td>신청일</td>
				</tr>
				<%if(sellregisList == null){ %>
				
					<tr>
						<td colspan="5"><h3>신청 회원이 없습니다.</h3></td>
					</tr>
				<%}else if(sellregisList.size()<5){ 
					for(int i = 0; i< sellregisList.size();i++){
						SellregisDTO sellDTO = (SellregisDTO)sellregisList.get(i);%>
						<%MemberDTO memDTO = memDAO.getMember(sellDTO.getMnum()); %>
						<tr>
							<td><%=memDTO.getMid() %></td>
							<td><%=memDTO.getMname() %></td>
							<td><%=memDTO.getMemail() %></td>
							<td><%=memDTO.getMtel() %></td>
							<td><%=sdf.format(sellDTO.getSreg()) %></td>
						</tr>
					<%}%>
				<tr height="30">
					<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
				</tr>
				<%}else if(sellregisList.size()>=5){ 
					for(int i = 0; i<5;i++){
						SellregisDTO sellDTO = (SellregisDTO)sellregisList.get(i);%>
						<%MemberDTO memDTO = memDAO.getMember(sellDTO.getMnum()); %>
						<tr>
							<td><%=memDTO.getMid() %></td>
							<td><%=memDTO.getMname() %></td>
							<td><%=memDTO.getMemail() %></td>
							<td><%=memDTO.getMtel() %></td>
							<td><%=sdf.format(sellDTO.getSreg()) %></td>
						</tr>
					<%}%>
				
				<tr height="30">
					<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
				</tr>
				<%}%>
			</table>
		</form>
	</div>
	
	
	
	<%--전체 주문목록 --%>
	<div class="box1">
	<form action="allOrderListForm.jsp" method="post">
		<table width="600" height="390">
			<tr height="60">
				<td colspan="3"><h2>전체 주문 목록</h2></td>
			</tr>
			<tr height="30">
				<td>구매자 ID</td>
				<td>판매자 ID</td>
				<td>거래시간</td>
			</tr>
			<%if(orderList==null){ %>
				<tr>
					<td colspan="3"><h3>주문 내역이 없습니다.</h3></td>
				</tr>
			<%}else if(orderList.size()<5){ 
				for(int i = 0; i< orderList.size();i++){
					BuyDTO buyDTO = (BuyDTO)orderList.get(i);
					MemberDTO buyerDTO = memDAO.getMember(buyDTO.getMnum());
					MemberDTO sellerDTO = memDAO.getMember(buyDTO.getSnum());
					%>
					<tr>
						<td><%=buyerDTO.getMid() %></td>
						<td><%=sellerDTO.getMid() %></td>
						<td><%=sdf.format(buyDTO.getBreg()) %></td>
					</tr>
				<%}%>
				<tr height="30">
					<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
				</tr>
			<% }else if(orderList.size()>= 5){ 	
				for(int i = 0; i<5 ;i++){
					BuyDTO buyDTO = (BuyDTO)orderList.get(i);
					MemberDTO buyerDTO = memDAO.getMember(buyDTO.getMnum());
					MemberDTO sellerDTO = memDAO.getMember(buyDTO.getSnum());
					%>
					<tr>
						<td><%=buyerDTO.getMid()%> </td>
						<td><%=sellerDTO.getMid()%> </td>
						<td><%=sdf.format(buyDTO.getBreg())%> </td>
					</tr>
				<%}%>
				<tr height="30">
					<td align="right" colspan="5"><input type="submit" value="더보기"/></td>
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
          </div>
       </div>
    </footer1>
	
	
	<%}else{ %>
		<script>
			alert("관리자로 로그인해주세요.");
		</script> 
	<%} %>	
	
	
</body>

</html>