<%@page import="web.team.one.SellregisDTO"%>
<%@page import="web.team.one.SellregisDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.ProductDTO"%>
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
</head>
<%
   	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("memId");
%>
<jsp:useBean id="dto" class="web.team.one.ProductDTO"/>
<%
	MemberDAO memDAO = new MemberDAO();
	int mnum= memDAO.getMnum(id);
	MemberDTO memDTO = memDAO.getMember(mnum);
	
	SellregisDAO sellDAO = new SellregisDAO();
	SellregisDTO sellDTO = sellDAO.getSeller(mnum); 

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
   ProductDAO dao = new ProductDAO(); 
   int count = 0; 
   List<ProductDTO> list = null;  // 글 가져올 변수 미리 선언 
   int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글 번호 (DB상 글 고유번호 아님)
   
   
   String search = request.getParameter("search"); 
   
   if(search != null) { // 검색일때 
      count = dao.getProductSearchCount(search, id);  // 검색에 맞는 게시글에 개수 가져오기 
      if(count > 0) { 
         // 검색한 글 목록 가져오기 
         list = dao.getProductsSearch(startRow, endRow, search, id);
      }
   }else { // 일반 게시판일때 
      count = dao.getProductCount(id);  // 그냥 전체 게시글 개수 가져오기
      // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
      if(count > 0){
         list = dao.getProductList(startRow, endRow, id);
      }
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
          	  	 		<button onclick="window.location='mypageSellerForm.jsp'"> 마이페이지 </button>
          	  	 </div>  
          	</div>         
      	</div>
   	</header>
   <%if(id == null){ %>
      <script>
          alert('로그인 후 이용하세요.');
 		  window.location.href="loginForm.jsp";
 	  </script>
   <%}else{ %>
   <table >
   		<tr>
   			<td>
		      <table width="760" height="730">
		         <tr>
		            <td  align="center" colspan="9" height="60"><h2>등 록 상 품</h2>
		            <%if(sellDTO == null){ %>
								<input type="button" value="판매자 등록 신청" onclick="window.location.href='sellRegistForm.jsp'"/>
							<%}else{ 
								if(sellDTO.getScon()==0){%>
									관리자 승인 대기 중
								<%}else{%>
									<input type="button" value="상품 등록" onclick="window.location.href='regisForm.jsp'"/>
									<%if(list != null){%>
										<input type="button" value="전체 판매 재개" onclick="window.location.href='allResell.jsp?pageNum=<%=pageNum%>'"/>
									<%}%>
								<%}%>
							<%} %>
					</td>
		         </tr>
		            <tr height="30">
		               <td>　NO　</td>
		               <td>이미지</td>
		               <td>상품명</td>
		               <td>판매량</td>
		               <td>판매이익</td>
		               <td>재고</td>
		               <td>등록 일자</td>
		               <td>상품 수정</td>
		               <td>배송 상태 변경</td>
		            </tr>
		            
		      <%if(list != null){ 
		         for(int i = 0 ;i<list.size();i++){
		            ProductDTO pd = (ProductDTO)list.get(i);%>
		            <tr>
		               <td><%=number-- %></td>
		               <td><a href="detailForm.jsp?Pnum=<%=pd.getPnum()%>"><img width="100px" src="/furnitureone/oneimg/<%=pd.getPimg() %>"/></a></td>
		               <td><%=pd.getPname() %></td>
		               <td><%=pd.getPsellst() %></td>
		               <td><%=pd.getPsellst() * pd.getPprice() %></td>
		               <td><%=pd.getPstock() %></td>
		               <td><%=sdf.format(pd.getPreg()) %></td>
		               <td><input type="button" value="상품 정보 수정" onclick="window.location.href='regisModifyForm.jsp?pnum=<%=pd.getPnum()%>&pageNum=<%=pageNum%>'"/></td>
		               <td>
		                  <%if(pd.getPcon()==1 || pd.getPstock() == 0){ %>
		                  		<%if(pd.getPstock() >= 1){%>
		                    		 <input type="button" value="판매 재개" onclick="window.location.href='reSell.jsp?pnum=<%=pd.getPnum()%>&pageNum=<%=pageNum%>'"/>
		                  		<%}else{%>
		                  			재고가 없습니다 상품정보에서 재고량을 수정해주세요.
		                  		<%}%>
		                  <%}else if(pd.getPcon()==0){ %>
		                     <input type="button" value="판매 중지" onclick="window.location.href='sellStop.jsp?pnum=<%=pd.getPnum()%>&pageNum=<%=pageNum%>'"/>
		                  	<%} %>
		               </td> 
		            </tr> 
		         <%
		            }
		         }else{ %>
		            <tr>
		               <td colspan="9"><h3>등록된 상품이 없슴둥</h3></td>
		            </tr>
		         <%} %>
		         <tr height="30">
		            <td align="right" colspan="9"><input type="button" value="뒤로" onclick="window.location.href='mypageSellerForm.jsp'"/></td>
		         </tr>
		      </table>
   			</td>
   		</tr>
   
   <br />
   <%-- 게시판 목록 페이지 번호 뷰어 --%>
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
		            <a class="pageNums" href="uploadListForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>"> &lt; &nbsp; </a>
		         <%}else{%>
		            <a class="pageNums" href="uploadListForm.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
		         <%}
		      }
		      
		      for(int i = startPage; i <= endPage; i++) { 
		         if(search != null) { %>
		            <a class="pageNums" href="uploadListForm.jsp?pageNum=<%=i%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
		         <%}else{ %>
		            <a class="pageNums" href="uploadListForm.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
		         <%} 
		      }
		      
		      if(endPage < pageCount) { 
		         if(search != null) { %>
		            <a class="pageNums" href="uploadListForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>"> &nbsp; &gt; </a>
		      <%   }else{ %>
		            <a class="pageNums" href="uploadListForm.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
		      <%   }
		      } 
		      
		      }//if count > 0 %>
		      <br /><br />
		      
		      <%-- 작성자/내용 검색 --%>
		      <form action="uploadListForm.jsp">
		         <input type="text" name="search" placeholder="상품명을 입력하세요" /> 
		         <input type="submit" value="검색" />
		      </form>
		      
		      <br />
		      
		      <button onclick="window.location='uploadListForm.jsp'"> 전체 상품 </button>
		   </div>
   			</td>
 		</tr>
   </table>	
   <%} %>
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
</body>
</html>