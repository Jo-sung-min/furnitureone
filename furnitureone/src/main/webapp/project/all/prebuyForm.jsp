<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.CartDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.CartDAO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>prebuyForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	<style>
       
        .box2 {
            background-color: silver;
            width: 410px;
            height : 330px;
            margin: 10px;
            padding: 20px;
            float: left;
        }
        .box3 {
            background-color: silver;
            width:  600px;
            height : 170px;
            margin: 10px;
            padding: 30px;
            clear: both;
        }
        .class {
        background-color: white;
        }
        footer {
		    background-color: #fff;
		    width: 100%;
		    height: 120px;
		    bottom : 0;
		    left: 0;
		    position: absolute; /* 위치를 하단에 고정 */
		    z-index: 1000;
			}
	</style> 
</head>
<%
   	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("memId");
%>
<jsp:useBean id="dto" class="web.team.one.CartDTO"/>
<%
	if(id==null){%>
		
		<script >
			alert("로그인 후 이용해 주세요");
			history.window.location.href = "loginForm.jsp";
		</script>
	<%}else{

	MemberDAO memDAO = new MemberDAO();
	int mnum= memDAO.getMnum(id);
	MemberDTO memDTO = memDAO.getMember(mnum);
	
	ProductDAO proDAO = new ProductDAO();
	//List orderList = null;
	
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
	
	// DB에서 전체 글 개수 가져오기 
	CartDAO dao = new CartDAO();  
	int count = 0;    
	List<CartDTO> list = null; //dao.getCart(mnum, startRow, endRow);  // 글 가져올 변수 미리 선언  
	
	String search = request.getParameter("search"); 
	   
	if(search != null) { // 검색일때 
		count = dao.getCartSearchCount(search, mnum);  // 검색에 맞는 게시글에 개수 가져오기    
		if(count > 0) {      
		    // 검색한 글 목록 가져오기 
		    list = dao.getCartSearch(startRow, endRow, search, mnum); 
		}
	}else { // 일반 게시판일때 
		count = dao.getCartCount(mnum);// 그냥 전체 게시글 개수 가져오기
	    // 글이 하나라도 있으면, 현재 페이지에 띄워줄 만큼만 가져오기 (페이지 번호 고려) 
	    if(count > 0){
	    	list = dao.getCartList(startRow, endRow, mnum); 
	    } 
	}  
	
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글 번호 (DB상 글 고유번호 아님)
	
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
          	  	 	</div>  
          		</div>   
      		</div>
   		</header>
	<br />
	<div class="side1">
		<form action="modifyForm.jsp" method="post">
			<br /><br />
			<h2 align="center" onclick="window.location='supportForm.jsp'"> 고객지원 </h2>
			<br /><br />
			<h4 align="center"> 
				문의 전화번호 <br />
				1577-5670
			</h4>
		</form>
	</div>
	
	<table >
		<tr>
			<td>
			<table width="680"height="730">
				<tr align="center" height="60">
					<th colspan="9">
						<h2>내가 담은 상품 </h2>
					</th>
				</tr>
				<tr height="30">
					<th>　No　</th>
					<th>이미지</th>
					<th>상품명</th>
					<th>재고</th>
					<th>가격</th>
					<th>구매</th>
					<th>삭제</th>
				</tr>
				
		        <%int total = 0; %>
				<%if(list != null) {
		
					for(int i = 0 ; i<list.size(); i++) {
		            		CartDTO cart = (CartDTO)list.get(i); 
		            				%>
					<tr>
						<%ProductDTO pro = proDAO.getOneProduct(cart.getPnum()); %>  
						<% total += pro.getPprice(); %>
					<td><%=number-- %></td>
					<td class="img">
						<a href="detailForm.jsp?Pnum=<%=cart.getPnum()%>"> 
						<img src="/furnitureone/oneimg/<%=pro.getPimg()%>" width="100" />
						</a>
					</td>
					<td>
						<%= pro.getPname() %>
					</td>
					<td >
						<%= cart.getCcount() %>개
					</td>
					<td>
						<%= pro.getPprice() %>원
					</td>
					<td>
						<input type="button" value="구매" onclick="window.location='buyForm.jsp?Pnum=<%=cart.getPnum()%>'" /> 
					</td>
					<td>
						<input type="button" value="삭제" onclick="window.location='prebuyDelete.jsp?Cnum=<%=cart.getCnum()%>&Pnum=<%=request.getParameter("Pnum")%>'" /> 
					</td>
				</tr>
				<%
		       				}
						}else { %>
					<tr>
		            	<td colspan="9">
		            		<h3>장바구니에 담은 상품이 없습니다.</h3>
		            	</td>
		            </tr>
		         	<%} %>
					<tr>
		            	<td colspan="9" align="right"><input type="button" value="메인으로" onclick="window.location='mainForm.jsp'" />         	</td>
		            </tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<div1 align="center" >
		   <% if(count > 0) { 
			   System.out.println("갯수"+count);
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
			            <a class="pageNums" href="prebuyForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>&Pnum=<%=request.getParameter("Pnum")%>"> &lt; &nbsp; </a>
			         <%}else{%>
			            <a class="pageNums" href="prebuyForm.jsp?pageNum=<%=startPage-1%>&Pnum=<%=request.getParameter("Pnum")%>"> &lt; &nbsp; </a>
			         <%}
			      }
			      
			      for(int i = startPage; i <= endPage; i++) { 
			         if(search != null) { %>
			            <a class="pageNums" href="prebuyForm.jsp?pageNum=<%=i%>&search=<%=search%>&Pnum=<%=request.getParameter("Pnum")%>"> &nbsp; <%= i %> &nbsp; </a>
			         <%}else{ %>
			            <a class="pageNums" href="prebuyForm.jsp?pageNum=<%=i%>&Pnum=<%=request.getParameter("Pnum")%>"> &nbsp; <%= i %> &nbsp; </a> 
			         <%} 
			      }
			      
			      if(endPage < pageCount) { 
			         if(search != null) { %>
			            <a class="pageNums" href="prebuyForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>&Pnum=<%=request.getParameter("Pnum")%>"> &nbsp; &gt; </a>
			      <%   }else{ %>
			            <a class="pageNums" href="prebuyForm.jsp?pageNum=<%=startPage+pageNumSize%>">&Pnum=<%=request.getParameter("Pnum")%> &nbsp; &gt; </a>
			      <%   }
			      } 
		      
		      }//if count > 0 %>
			     
		      <%-- 작성자/내용 검색 --%>
		      <br />
				<form action="prebuyForm.jsp">
					<input type="text" name="search" placeholder="상품명을 입력하세요" /> 
					<input type="submit" value="검색" />
				</form>
		      <br />
					<button onclick="window.location='prebuyForm.jsp'"> 전체 상품 </button>
		      </div1>
			</td>
		</tr>
	</table>
		
	<br /><br /><br /><br />	
		
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
		<% } %>
</body>
</html>