<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.InquiryDTO"%>
<%@page import="web.team.one.InquiryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>

</head>

<body>
<%
	String id = (String)session.getAttribute("memId");
	InquiryDAO inDAO = new InquiryDAO();
	InquiryDTO inDTO = new InquiryDTO();
	
	ProductDAO proDAO = new ProductDAO();
	
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
	   int count = 0;
	   // DB에서 전체 글 개수 가져오기 
	    int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글 번호 (DB상 글 고유번호 아님)
	   
	   
	   List inList = null;
      count = inDAO.getMyQCount(id);   // 그냥 전체 게시글 개수 가져오기
      // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
      if(count > 0){
   	  	inList = inDAO.getMyQList(startRow, endRow, id); 
      }
      number = count - (currentPage - 1) * pageSize;

%>		

<%if(id == null || id.equals("null") || id.equals("")){%> 
		<script>
			alert('로그인 후 이용하세요.');
			window.location.href="loginForm.jsp";
		</script>
		<%}else{%>
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
			<br /><br />
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br /><br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>
	
	
	
	<br/><br/><br/>
	<div class="container">
	
	<table >
		<tr>
			<td>
			<table width="680" height="500">
				<tr height="60">
					<td colspan="6">
						<h2>상품 문의 내역</h2>
					</td>
				</tr>
				<tr height="30">
					<td>No</td>
					<td>ID</td>
					<td>상품명</td>
					<td>내용</td>
					<td>작성시간</td>
					<td>답변</td>
				</tr>
				<%if(inList == null){ 
					response.sendRedirect("mypageSellerForm.jsp");
				}else{ %>
					<%for(int i = 0; i<inList.size(); i++){
						inDTO = (InquiryDTO)inList.get(i);%>
								<tr>
									<td><%=number--%></td>
									<td><%=inDTO.getMid() %></td>
									<%ProductDTO proDTO = proDAO.getOneProduct(inDTO.getPnum()); %>
									<td><%=proDTO.getPname() %></td>
									<td><%=inDTO.getQuestion() %></td>
									<td><%=inDTO.getQreg() %></td>
									<td><input type="button" value="답변" onclick="window.location.href='writeAForm.jsp?inum=<%=inDTO.getInum()%>'"/></td>
								</tr>
						<%}%>
					<%} %>
					
					<tr height="30">
						<td align="right" colspan="9"><input type="button" value="뒤로" onclick="window.location.href='mypageSellerForm.jsp'"/></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
		   <%-- 게시판 목록 페이지 번호 뷰어 --%>
		   <div class="container" align="center">
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
		
		      if(startPage > pageNumSize) { %>
		            <a class="pageNums" href="myQuestionList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
		      <%}
		      
		      for(int i = startPage; i <= endPage; i++) { %>
		            <a class="pageNums" href="myQuestionList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
		     <% }
		      
		      if(endPage < pageCount) { %>
		            <a class="pageNums" href="myQuestionList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
		      
		      <%} 
		      }%>
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
    <%} %>
</body>
</html>