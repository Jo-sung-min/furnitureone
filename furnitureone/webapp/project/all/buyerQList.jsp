<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.InquiryDAO"%>
<%@page import="web.team.one.InquiryDTO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%		
		request.setCharacterEncoding("UTF-8");
		String mid = (String)session.getAttribute("memId");
		
		InquiryDAO inDAO = new InquiryDAO();
		InquiryDTO inDTO = new InquiryDTO();
		
		MemberDAO dao = new MemberDAO();
		int mnum = dao.getMnum(mid);
		MemberDTO member = dao.getMember(mnum); 
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
	      count = inDAO.getBuyerQCount(mid);   // 그냥 전체 게시글 개수 가져오기 
	      // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
	      if(count > 0){
	   	  	inList = inDAO.getBuyerQList(startRow, endRow, mid); 
	      }
	      number = count - (currentPage - 1) * pageSize;
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
          	  	 		<button onclick="window.location='prebuyForm.jsp'"> 장바구니 </button>
          	  	 		<button onclick="window.location='mypageBuyerForm.jsp'"> 마이페이지 </button>
          	  	 	</div>  
          		</div>   
      		</div>
   		</header>
   		<br/><br/>
   		<div class="side1">
		<form action="modifyForm.jsp" method="post">
			<br />
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br /><br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>




	<table>
		<tr>
			<td>
			<table width="620" height="450">
			<br/><br/><br/>
				<tr height="60">
					<td colspan="5">
						<h2>내가 문의한 내역</h2>
					</td>
				</tr>
				<tr height="30">
					<td>이미지</td>
					<td>상품명</td>
					<td>내용</td>
					<td>답변</td>
					<td>작성시간</td>
				</tr>
				<%if(inList == null){ %>
					<tr>
						<td colspan="5"><h3>문의하신 내역이 없습니다</h3></td>
					</tr>
					<tr height="40">
						<td colspan="5"></td>
					</tr>
				<%}else{ 
					for(int i=0; i < inList.size(); i++ ){
						inDTO = (InquiryDTO)inList.get(i);%>
							<tr >
								<%ProductDTO proDTO = proDAO.getOneProduct(inDTO.getPnum()); %>
								<td>
									<a href="detailForm.jsp?Pnum=<%=inDTO.getPnum()%>">  
									<img width="80" src="/furnitureone/oneimg/<%=proDTO.getPimg()%>"/>
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
				<%}%>
			</table>
			</td>
		</tr>
		<tr>
			<td>	
			
			
		<div class="container" align="center">
		   <% if(count > 0) { 
		      int pageNumSize = 5; 
		      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		      int startPage = ((currentPage - 1) / pageSize) * pageNumSize + 1; 
		      int endPage = startPage + pageNumSize - 1; 
		      if(endPage > pageCount) { endPage = pageCount; } 
		
		      if(startPage > pageNumSize) { %>
		            <a class="pageNums" href="buyerQList.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
		      <%}
		      
		      for(int i = startPage; i <= endPage; i++) { %>
		            <a class="pageNums" href="buyerQList.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
		     <% }
		      
		      if(endPage < pageCount) { %>
		            <a class="pageNums" href="buyerQList.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
		      
		      <%} 
		      }%>
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
			<br /> 
          </div>
       </div>
    </footer>
</body>
</html>