<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.BuyDTO"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   <link href="style.css" rel="stylesheet" type="text/css"/>
  <style>
   		footer {
		    background-color: #fff;
		    width: 100%;
		    height: 120px;
		    bottom : 0;
		    left: 0;
		    position: absolute; /* 위치를 하단에 고정 */
		    z-index: 1000;
			}
   
  	 .container{
	   	  	background-color: #FFF8DC;
	       	width: 100%;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
	       	padding : 30px;
   		}
        .box1 {
            background-color: #FFF8DC;
       	  	 width: 300;
       	  	 height:500;
			justify-content: center;
	   		
        }
        .box2 {
        	background-color: #FFF8DC;
			width: 300;
			height:500;
			justify-content: center;
	   		
        }
        .box3 {
            background-color: black;
	       	width: 300;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
            
        }
    
        .box4 {
            background-color: black;
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
	int Mnum = memDAO.getMnum(id);
	MemberDTO member = memDAO.getMember(Mnum); 
	
	BuyDAO buyDAO = new BuyDAO();
	List orderList = null;

   //현재 요청된 게시판 페이지 번호 
   String pageNum = request.getParameter("pageNum"); 
   if(pageNum == null){ // pageNum 파라미터가 안넘어왔을때는 (../jsp08/list.jsp 라고만 요청했을때)
      pageNum = "1";   // 1페이지 보여주기위해 pageNum 값 "1"로 체워주기 
   }
   System.out.println("pageNum : " + pageNum);

   // 현재 페이지에서 보여줄 게시글의 시작과 끝 등의 정보 세팅
   int pageSize = 5;                          // 한페이지에 보여줄 게시글의 개수 
   int currentPage = Integer.parseInt(pageNum);    // 연산을 위해 pageNum을 숫자로 형변환
   int startRow = (currentPage -1) * pageSize + 1; // DB에서 잘라올 페이지 시작글 번호 
   int endRow = currentPage * pageSize; // DB에서 잘라올 페이지 마지막 글 번호 
   
   // 작성시간 원하는 형태로 화면에 출력하기위한 보조 클래스 객체 생성
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
 
   // DB에서 전체 글 개수 가져오기 
   int count = 0; 
   int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글 번호 (DB상 글 고유번호 아님)
   
   
   String search = request.getParameter("search");
	int mnum = memDAO.getMnum(search);
   
	   
   if(search != null) { // 검색일때
	   if(memDAO.confirmId(search)){
	      count = buyDAO.getOrderSearchCount(mnum);  // 검색에 맞는 게시글에 개수 가져오기 
	      number = count - (currentPage - 1) * pageSize;
	      if(count > 0) { 
	         // 검색한 글 목록 가져오기 
	         orderList = buyDAO.getOrderSearch(startRow, endRow, mnum);
	      }
	   }else{%>
		 <script>
		 	alert('똑바로 입력해');
		 	history.go(-1);
		 </script>
	   <%}
   }else { // 일반 게시판일때 
      count = buyDAO.getOrderCount();// 그냥 전체 게시글 개수 가져오기
      // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
      if(count > 0){
    	  orderList = buyDAO.getOrderList(startRow, endRow);
      }
   }
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
	<div class="side1">
		<form action="modifyForm.jsp" method="post">
			<br/><br/><br/><br/>
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>
   		
   		
   		
   	<br/><br/><br/>
   	<table>
   		<tr>
   			<td>
			<form action="allOrderListForm.jsp" method="post">
				<table width="680"height="500">
					<tr height="60">
						<td colspan="3"><h2>전체 주문 목록</h2></td>
					</tr>
					<tr height="30">
						<td>구매자 ID</td>
						<td>판매자 ID</td>
						<td>거래시간</td>
					</tr>
					<%if(orderList != null){ 
						for(int i = 0; i< orderList.size();i++){
							BuyDTO buyDTO = (BuyDTO)orderList.get(i);%>
							<tr>
							<%
							MemberDTO buyerDTO = memDAO.getMember(buyDTO.getMnum());
							MemberDTO sellerDTO = memDAO.getMember(buyDTO.getSnum());
							%>
								<td><a onclick="window.location.href='memberListForm.jsp?pageNum=<%=pageNum%>&mnum=<%=buyDTO.getMnum()%>'"><%=buyerDTO.getMid() %></a></td>
								<td><a onclick="window.location.href='memberListForm.jsp?pageNum=<%=pageNum%>&mnum=<%=buyDTO.getSnum()%>'"><%=sellerDTO.getMid() %></a></td>
								<td><%=sdf.format(buyDTO.getBreg()) %></td>
							</tr>
						<%}%>
					<%}else{ %>
						<tr>
							<td colspan="3"><h3>주문 내역이 없습니다.</h3></td>
						</tr>
					<%} %>
					<tr height="30">
						<td align="right" colspan="5"><input type="button" value="뒤로" onclick="window.location.href='mypageAdminForm.jsp'"/></td>
					</tr>
				</table>
			</form>
			</td>
		</tr>
 		<tr>
   			<td>
		   <%-- 게시판 목록 페이지 번호 뷰어 --%>
		   <div1 align="center">
		   <% if(count > 0) { 
		      // 한페이지에 보여줄 번호의 개수 
		      int pageNumSize = 5; 
		      // 총 몇페이지 나오는지 계산 
		      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		      // 현재 페이지에 띄울 첫번째 페이지 번호 
		      int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
		      // 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
		      int endPage = startPage + pageNumSize - 1; 
		      if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 
		
		      if(startPage > pageNumSize) { 
		         if(search != null) { %>
		            <a class="pageNums" href="allOrderListForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>"> &lt; &nbsp; </a>
		         <%}else{%>
		            <a class="pageNums" href="allOrderListForm.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
		         <%}
		      }
		      
		      for(int i = startPage; i <= endPage; i++) { 
		         if(search != null) { %>
		            <a class="pageNums" href="allOrderListForm.jsp?pageNum=<%=i%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
		         <%}else{ %>
		            <a class="pageNums" href="allOrderListForm.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
		         <%} 
		      }
		      
		      if(endPage < pageCount) { 
		         if(search != null) { %>
		            <a class="pageNums" href="allOrderListForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>"> &nbsp; &gt; </a>
		      <%   }else{ %>
		            <a class="pageNums" href="allOrderListForm.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
		      <%   }
		      } 
		      
		      }//if count > 0 %>
		      
		      <%-- 작성자/내용 검색 --%>
		      <form action="allOrderListForm.jsp">
		         <input type="text" name="search" placeholder="ID를 검색하세요" /> 
		         <input type="submit" value="검색" />
		      </form>
		      <br />
		      <button onclick="window.location='allOrderListForm.jsp'"> 전체 목록 </button>
		   		</div1>
   			</td>
		</tr>
   </table>
   
   
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