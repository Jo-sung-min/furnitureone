<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>




</head>
	<div class="side1">
		<form action="modifyForm.jsp" method="post">
			<br /><br /><br /><br />
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>

			<%--페이징 처리 --%>
<%
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null){ // pageNum 파라미터 안넘어오면, 1페이지 보여지게 
				pageNum = "1";   // 1로 값 체우기 
			}
			System.out.println("pageNum : " + pageNum);
			
			int pageSize = 5;  // 현재 페이지에서 보여줄 글 목록의 수 
			int currentPage = Integer.parseInt(pageNum);  
			int startRow = (currentPage - 1) * pageSize + 1; 
			int endRow = currentPage * pageSize; 

			//로그인 확인
			String Mid =(String)session.getAttribute("memId");
			
			
		    //물건 정보 누르고 들어오는 상세페이지
			int Pnum =Integer.parseInt(request.getParameter("Pnum"));
		    
			//리뷰 가져오는 메서드 준비
			ReviewDAO dao = new ReviewDAO();
			//가져온 리뷰 담을 객체
			List<ReviewDTO>list = dao.getReview(Pnum, startRow, endRow);
			//리뷰 세어주는 메서드
			int count = dao.reviewCount(Pnum);
			
			//아이디 가져오기 위해서
			MemberDAO dao1 = new MemberDAO(); 
			int Mnum =dao1.getMnum(Mid);
			MemberDTO member =dao1.getMember(Mnum);
			
			
%>

<%
			// 검색 여부 판단 
			String search = null;
			
			if(request.getParameter("search") != null) {
				search = request.getParameter("search").trim(); 
			}
			String sel = null;
			
			if(request.getParameter("sel") != null) {
				sel = request.getParameter("sel").trim(); 
			}
			
			if(sel != null && search != null) { // 검색일때 
				
				count = dao.reviewSearchCount(sel, search);  // 검색에 맞는 게시글에 개수 가져오기 
				if(count > 0) {
					// 검색한 글 목록 가져오기 
					list = dao.getReviewSearch(Pnum, startRow, endRow, sel, search);  
				}
				
				
			}else { // 검색 안했을 때 상품의 등록된 리뷰 세어오기 
				count = dao.reviewCount(Pnum);  // 그냥 전체 게시글 개수 가져오기
				// 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
				if(count > 0){
					list = dao.getReview(Pnum, startRow, endRow); 
				}
			}
			System.out.println("article count : " + count);

			int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글번호(bno아님)
			SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm"); 	
%>


<body>
	<br/>


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
	<br />
	<%}else{ %>
	<br />
		<header>
	       <div class="inner">
	          	<div class="header-container">
           	 	 	<div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	  	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
          	  	 	<div class="header-text">
          	  	 		<button onclick="window.location='loginForm.jsp'"> 로그아웃 </button>
          	  	 		<button onclick="window.location='mypageBuyerForm.jsp'"> 마이페이지 </button>
          	  	 	</div>  
          		</div>         
      		</div>
   		</header>
	<%} %>
	
	
	
	<%--리뷰 정보 --%>
	
	
	<div class="container">
	<table>
		<tr>
			<td>
				<div class="box1">
				<table width="680" height="500">
				<tr height="60">
					<td colspan="6"> <h2>리 뷰 게 시 판 </h2> </td>
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
				
					if(count>0){
					for(int i = 0 ;i<list.size() ;i++){
					ReviewDTO review = list.get(i);   
					member =dao1.getMember(review.getMnum());
					
					
					%>
				<tr>
					<td><%=number--%></td>
					<td><%=member.getMid()%></td>
					<td align="center">
						<img src="/furnitureone/oneimg/<%=review.getRimg()%>" width="80" />
					</td>				
					<td><%=review.getRcontent() %></td>
					<td><%=review.getRgrade() %></td>
					<td><%=sdf.format(review.getRreg())%></td>
				</tr>
					<%}
					}else{%>
					<tr>
						<td colspan="6">등록된 리뷰가 없습니다.</td>
					</tr>	
					<%}
					%>
				<tr height="30">
					<td align="right" colspan="6">
					 <input type="button" value="뒤로" onclick="history.go(-1)"></td>
				</tr>
			</table>
			</div>
		</td>
	</tr>
	
	<tr>
		<td>
			<%-- 리뷰 목록 페이지 번호 뷰어 --%>
			<div class="box2" >
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
					if(sel != null && search != null) { %>
						<a class="pageNums" href="reviewListForm.jsp?pageNum=<%=startPage-1%>&Pnum=<%=Pnum%>&sel=<%=sel%>&search=<%=search%>"> &lt; &nbsp; </a>
					<%}else{%>
						<a class="pageNums" href="reviewListForm.jsp?pageNum=<%=startPage-1%>&Pnum=<%=Pnum%>"> &lt; &nbsp; </a>
					<%}
				}
				
				for(int i = startPage; i <= endPage; i++) { 
					if(sel != null && search != null) { %>
						<a class="pageNums" href="reviewListForm.jsp?pageNum=<%=i%>&Pnum=<%=Pnum%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
					<%}else{ %>
						<a class="pageNums" href="reviewListForm.jsp?pageNum=<%=i%>&Pnum=<%=Pnum%>"> &nbsp; <%= i %> &nbsp; </a> 
					<%} 
				}
				
				if(endPage < pageCount) { 
					if(sel != null && search != null) { %>
						<a class="pageNums" href="reviewListForm.jsp?pageNum=<%=startPage+pageNumSize%>&Pnum=<%=Pnum%>&sel=<%=sel%>&search=<%=search%>"> &nbsp; &gt; </a>
				<%	}else{ %>
						<a class="pageNums" href="reviewListForm.jsp?pageNum=<%=startPage+pageNumSize%>&Pnum=<%=Pnum%>"> &nbsp; &gt; </a>
				<%	}
				} 
				
				}//if count > 0 %>
				</div>
					<%-- 작성자/내용 검색 --%>
					<div class="box3">
					<form action="reviewListForm.jsp?Pnum=<%=Pnum%>">
					<input type="hidden" name="Pnum" value="<%=Pnum%>" />
						<select name="sel">
							<option value="Mid" selected>작성자</option>
							<option value="rcontent">내용</option>
						</select>
						<input type="text" name="search" /> 
						<input type="submit" value="검색" />
					</form>
					<br />
				</div>
				
				<div class="box3">
					<button onclick="window.location='reviewListForm.jsp?Pnum=<%=Pnum%>'">전체 게시글</button>
				</div>
				</td>
			</tr>
		</table>
		</div>
	
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