<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.BuyDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>
	<style >
	
	.side1 {
		background-color: 9A9483;
		height: 870px;
       } 
	
	</style>	
		
	
	
</head>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("memId");
	
	MemberDAO memDAO = new MemberDAO();
	int mnum= memDAO.getMnum(id);
	
	ProductDAO proDAO = new ProductDAO();
	List proList = proDAO.getMyProduct(id);
	
	BuyDAO buyDAO = new BuyDAO();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ // pageNum 파라미터가 안넘어왔을때는 (../jsp08/list.jsp 라고만 요청했을때)
		pageNum = "1";   // 1페이지 보여주기위해 pageNum 값 "1"로 체워주기 
	}
	System.out.println("pageNum : " + pageNum);

	// 현재 페이지에서 보여줄 게시글의 시작과 끝 등의 정보 세팅
	int pageSize = 10; 		 						// 한페이지에 보여줄 게시글의 개수 
	int currentPage = Integer.parseInt(pageNum); 	// 연산을 위해 pageNum을 숫자로 형변환
	int startRow = (currentPage -1) * pageSize + 1; // DB에서 잘라올 페이지 시작글 번호 
 	int endRow = currentPage * pageSize; // DB에서 잘라올 페이지 마지막 글 번호 
	
	// DB에서 전체 글 개수 가져오기 
	
	List<BuyDTO> delList = null;  // 글 가져올 변수 미리 선언 
	int count = 0;  
	 
	
	String search = request.getParameter("search"); 
	if(search != null) { // 검색일때 
		count = buyDAO.getDelProductSearchCount(search, mnum);  // 검색에 맞는 게시글에 개수 가져오기 
		if(count > 0) {
			// 검색한 글 목록 가져오기 
			delList = buyDAO.getDelProDuctsSearch(startRow, endRow, search, mnum);
		}
	}else { // 일반 게시판일때 
		count = buyDAO.getDelProductCount(mnum);  // 그냥 전체 게시글 개수 가져오기
		// 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
		if(count > 0){
			delList = buyDAO.getDelProDucts(startRow, endRow, mnum);
		}
	}
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글 번호 (DB상 글 고유번호 아님)
%>

<body>
	<br/><br/>
	<header>
	  	<div class="inner">
	         <div class="header-container">
          	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	 	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
         	  	 		<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
          	  	 		<button onclick="window.location='mypageSellerForm.jsp'"> 마이페이지 </button>
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
   	
	<%if(id == null){ %>
		<script>
			alert('로그인 후 이용하세요.');
			window.location.href = "loginForm.jsp";
		</script>
	<%}else{ %>
	<br/><br/>
	<table>
		<tr>
			<td>
			<div class="box3">
				<table width="680"height="500">
					<tr height="60">
						<td colspan="8"><h2>배송 상품</h2></td>
					</tr>
					<tr height="30">
						<td>NO</td>
						<td>상품명</td>
						<td>개수</td>
						<td>가격</td>
						<td>구매자 ID</td>
						<td>구매자 전화번호</td>
						<td>구매 일자</td>
						<td>배송 상태 변경</td>
					</tr>
					<%if(delList != null){
						for(int i=0; i<delList.size(); i++){ 
							BuyDTO buyDTO = (BuyDTO)delList.get(i);
						%>
					<tr>
						<td><%=number-- %></td>
						<%ProductDTO dto = proDAO.getOneProduct(buyDTO.getPnum()); %>
						<td><%=dto.getPname() %></td>
						<td><%=buyDTO.getBbuyst() %>개</td>
						<td><%=buyDTO.getBprice() %>원</td>
						<% MemberDTO dto2 = memDAO.getMember(buyDTO.getMnum());%>
						<td><%=dto2.getMid() %></td>
						<td><%=dto2.getMtel() %></td>
						<td><%=sdf.format(buyDTO.getBreg()) %></td>
						<td>
							<input type="button" value="배송완료" onclick="window.location.href='delEnd.jsp?bnum=<%=buyDTO.getBnum()%>&pageNum=<%=pageNum %>'"/>
						</td>
					</tr>
					<%}%>
					<%}else{ %>
						<tr>
							<td colspan="8"><h3>배송중인 상품이 없습니다.</h3></td>
						</tr>
					<%} %>
				</table>
			</div>
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
						<a class="pageNums" href="delSellListForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>"> &lt; &nbsp; </a>
					<%}else{%>
						<a class="pageNums" href="delSellListForm.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
					<%}
				}
				
				for(int i = startPage; i <= endPage; i++) { 
					if(search != null) { %>
						<a class="pageNums" href="delSellListForm.jsp?pageNum=<%=i%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
					<%}else{ %>
						<a class="pageNums" href="delSellListForm.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
					<%} 
				}
				
				if(endPage < pageCount) { 
					if(search != null) { %>
						<a class="pageNums" href="delSellListForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>"> &nbsp; &gt; </a>
				<%	}else{ %>
						<a class="pageNums" href="delSellListForm.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
				<%	}
				} 
				
				}//if count > 0 %>
				<br /><br />
				
				<%-- 작성자/내용 검색 --%>
				<form action="delSellListForm.jsp">
					<input type="text" name="search" placeholder="상품명을 입력하세요"/> 
					<input type="submit" value="검색" />
				</form>
				<br />
				<button onclick="window.location='delSellListForm.jsp'"> 전체 상품 </button>
			</div1>
			</td>
		</tr>	
	</table>
	
	
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
	<%} %>
	
</body>
</html>