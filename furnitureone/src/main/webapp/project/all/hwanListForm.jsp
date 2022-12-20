<%@page import="web.team.one.ProductDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.HwanDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.HwanDAO"%>
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

</head>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("memId");
	
	MemberDAO memDAO = new MemberDAO();
	int mnum= memDAO.getMnum(id);
	MemberDTO memDTO = memDAO.getMember(mnum);
	
	ProductDAO proDAO = new ProductDAO();
	
	HwanDAO hwanDAO = new HwanDAO();
	List hwanList = hwanDAO.getMyHwan(mnum);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
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
	
	
	// DB에서 전체 글 개수 가져오기 
	int count = 0; 
	
	
	String search = request.getParameter("search"); 
	if(search != null) { // 검색일때  
	   count = hwanDAO.getHwanSearchCount(search, mnum);// 검색에 맞는 게시글에 개수 가져오기 
	   System.out.println(count);
	   if(count > 0) { 
	      // 검색한 글 목록 가져오기 
	      hwanList = hwanDAO.getHwanSearch(startRow, endRow, search, mnum);
	   }
	}else { // 일반 게시판일때 
	   count = hwanDAO.getHwanCount(mnum);  // 그냥 전체 게시글 개수 가져오기
	   // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
	   if(count > 0){
		   hwanList = hwanDAO.getHwanList(startRow, endRow, mnum);
	   }
	}
	  int number = count - (currentPage - 1) * pageSize;
	
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
   	<br /><br /><br />
   	
   	<table >
		<tr>
			<td>
				<table width="680"height="500" >
					<tr height="60">
						<td  align="center" colspan="5"><h2>환불 요청 상품</h2>
						</td>
					</tr>
					<tr height="30">
						<td>NO</td>
						<td>상품명</td>
						<td>사유</td>
						<td>환불 신청 일자</td>
						<td>승인/거절</td>
					</tr>
					<%if(count==0){%>
						<tr>
							<td colspan="5"><h3>요청된 환불이 없습니다</h3></td>
						</tr>
					<%}else if(count>0){%>
						<%for(int i =0;i<hwanList.size();i++){
							 HwanDTO hwanDTO = (HwanDTO)hwanList.get(i);%>
						<tr>
							<td><%=number-- %></td>
							<%int pnum = proDAO.getPnum(hwanDTO.getBnum()); 
							ProductDTO proDTO = proDAO.getOneProduct(pnum);				
							%>
							<td><%=proDTO.getPname() %></td>
							<td><%=hwanDTO.getHreason() %></td>
							<td><%=sdf.format(hwanDTO.getHreg()) %></td>
							<td >
								<input type="button" value="승인" onclick="window.location.href='hwanPro.jsp?number=<%=ok%>&hnum=<%=hwanDTO.getHnum()%>&pageNum=<%=pageNum%>'"/>
								<input type="button" value="거절" onclick="window.location.href='hwanPro.jsp?number=<%=no%>&hnum=<%=hwanDTO.getHnum()%>&pageNum=<%=pageNum%>'"/>
							</td>
						</tr>
						<%}
						} %>
				</table>
			</td>
		</tr>
		<tr>
			<td>
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
		            <a class="pageNums" href="hwanListForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>"> &lt; &nbsp; </a>
		         <%}else{%>
		            <a class="pageNums" href="hwanListForm.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
		         <%}
		      }
		      
		      for(int i = startPage; i <= endPage; i++) { 
		         if(search != null) { %>
		            <a class="pageNums" href="hwanListForm.jsp?pageNum=<%=i%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
		         <%}else{ %>
		            <a class="pageNums" href="hwanListForm.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
		         <%} 
		      }
		      
		      if(endPage < pageCount) { 
		         if(search != null) { %>
		            <a class="pageNums" href="hwanListForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>"> &nbsp; &gt; </a>
		      <%   }else{ %>
		            <a class="pageNums" href="hwanListForm.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
		      <%   }
		      } 
		      
		      }//if count > 0 %>
		      <br /><br />
		      </div1>
		      <%-- 작성자/내용 검색 --%>
		      <form action="hwanListForm.jsp">
		         <input type="text" name="search" placeholder="상품명을 입력하세요" /> 
		         <input type="submit" value="검색" />
		      </form>
		      <br />
		      <button onclick="window.location='hwanListForm.jsp'"> 전체 목록 </button>
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
</html>
</body>
</html>
