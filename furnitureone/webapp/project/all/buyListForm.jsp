<%@page import="web.team.one.HwanDAO"%>
<%@page import="web.team.one.ReviewDAO"%>
<%@page import="web.team.one.HwanDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.BuyDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>buyListForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<style >
	
	.side1 {
		background-color: 9A9483;
		height: 870px;
       } 
	
	</style>	
		
		
</head>
<%
   	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
%>
<jsp:useBean id="dto" class="web.team.one.BuyDTO"/>
<%
	MemberDAO memDAO = new MemberDAO();
	int mnum= memDAO.getMnum(id);
	MemberDTO memDTO = memDAO.getMember(mnum);
	
	ProductDAO proDAO = new ProductDAO();
	
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
	BuyDAO dao = new BuyDAO();  
	int count = 0;    
	List<BuyDTO> list = null;//dao.getBuyProduct(mnum, startRow, endRow);  // 글 가져올 변수 미리 선언 
	
	String search = null;
	
	if(request.getParameter("search") != null) {
		search = request.getParameter("search").trim(); 
	}
	if(search != null) { // 검색일때 
		count = dao.getBuySearchCount(search, mnum);  // 검색에 맞는 게시글에 개수 가져오기 
		 if(count > 0) {   
		   	// 검색한 글 목록 가져오기 
		    list = dao.getBuySearch(startRow, endRow, search, mnum);
		}
	}else { // 일반 게시판일때 
		count = dao.getbuyCount(mnum);// 그냥 전체 게시글 개수 가져오기
	    // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
	    if(count > 0){
	    	list = dao.getBuyList(startRow, endRow, mnum);
	    } 
	}  
	
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글 번호 (DB상 글 고유번호 아님)
	
	//리뷰 작성 여부
	ReviewDAO reviewdao = new ReviewDAO();
		
	//환불
	HwanDAO hwandao = new HwanDAO();  
	
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
          	  	 		<button onclick="window.location='prebuyForm.jsp'"> 장바구니 </button>
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
	
		<table>
			<tr>
				<td>
				<form action="buyListForm.jsp" method="post" enctype="multipart/form-data">
					<table width="720"height="500">
						<tr height="60">
							<td colspan="10"> <h2>내가 구매한 상품 목록</h2> </td>
						</tr>
						<tr height="30">
							<th>　No　</th> 
							<th>이미지</th>
							<th>상품명</th>
							<th>개수</th>
							<th>가격</th>
							<th colspan ="3">
								상품 상태
							</th>
							<th colspan ="2">구매일자</th>
						</tr>
					<%if(list != null) { 
		        		 for(int i = 0 ; i<list.size(); i++) {
		            		BuyDTO buy = (BuyDTO)list.get(i); %>
							<tr>
								<td>
									<%= number-- %>
								</td>
								<%ProductDTO pro = proDAO.getOneProduct(buy.getPnum()); %>
								<%BuyDTO bcon = dao.getbuy(buy.getBnum()); %> 
								<td>
									<a href="detailForm.jsp?Pnum=<%=buy.getPnum()%>"> 
									<img src="/furnitureone/oneimg/<%=pro.getPimg()%>" width="100" />
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
								</td>
								<% if(bcon.getBdelcon() == 1)  { %>
									<% HwanDTO hwan = hwandao.gethwan(buy.getBnum()); %> 
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
						<%
						}else { %>
		            	<tr>
		             	  <td colspan="9"><h3>구매한 상품이 없슴둥</h3></td>
		            	</tr>
		         		<%} %>
		         		
					</table>
				</form>
				</td>
			</tr>
	   <%-- 게시판 목록 페이지 번호 뷰어 --%>
			<tr>
				<td>
				   <div1 align="center" >
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
					            <a class="pageNums" href="buyListForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>"> &lt; &nbsp; </a>
					         <%}else{%>
					            <a class="pageNums" href="buyListForm.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
					         <%}
					      }
					      
					      for(int i = startPage; i <= endPage; i++) { 
					         if(search != null) { %>
					            <a class="pageNums" href="buyListForm.jsp?pageNum=<%=i%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
					         <%}else{ %>
					            <a class="pageNums" href="buyListForm.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
					         <%} 
					      }
					      
					      if(endPage < pageCount) { 
					         if(search != null) { %>
					            <a class="pageNums" href="buyListForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>"> &nbsp; &gt; </a>
					      <%   }else{ %>
					            <a class="pageNums" href="buyListForm.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
					      <%   }
					      } 
				      
				      }//if count > 0 %>
				      
				      <%-- 작성자/내용 검색 --%>
				      <br />
						<form action="buyListForm.jsp">
							<input type="text" name="search" placeholder="상품명을 입력하세요" /> 
							<input type="submit" value="검색" />
						</form>
				      <br />
							<button onclick="window.location='buyListForm.jsp'"> 전체 상품 </button>
				      </div>
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