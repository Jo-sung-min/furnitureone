<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.QnaDTO"%>
<%@page import="web.team.one.QnaDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>supportForm</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
	
</head>
	<%-- 로그인확인 & 로그인처리 --%>
<%
		//로그인 확인
		String Mid =(String)session.getAttribute("memId");

		MemberDAO dao0 = new MemberDAO();
		int mnum = dao0.getMnum(Mid);
		MemberDTO member = dao0.getMember(mnum); 

	
%>
<body>
	<br />
	<%if(Mid==null){ %>
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
	<%}else{ %>
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
	<%} %>
	<br /><br />
	<div class="side1">
			<form>
			<br/><br/>
				<h2 align="center" onclick="window.location='mainForm.jsp'"> 메인으로 </h2>
				<br/><br/>
				<h4 align="center"> 
					문의 전화번호 <br/>
					1577-5670
				</h4>
			</form>
		</div>	
	
	
	
	
<%
   	request.setCharacterEncoding("UTF-8");

%>
<%
	
	
	//현재 요청된 리뷰 페이지 번호 
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
	QnaDAO dao = new QnaDAO();  
	QnaDTO qna = new QnaDTO();  
	int count = 0;    
	List<QnaDTO> list = null;//(mnum, startRow, endRow);  // 글 가져올 변수 미리 선언 
	count = dao.qnaCount(); 
	
	
	int number = count - (currentPage - 1) * pageSize; // 화면에 뿌려줄 글 번호 (DB상 글 고유번호 아님)
	list = dao.getQna(startRow, endRow);
	
	
	String search = request.getParameter("search"); 
	System.out.println(search);
	if(search != null) { // 검색일때 
	   count = dao.qnaSearchCount(search);   // 검색에 맞는 게시글에 개수 가져오기 
	   if(count > 0) { 
	      // 검색한 글 목록 가져오기 
	      list = dao.getQnaSearch(startRow, endRow, search); 
	   }
	}
	
	
	
	
	
	
	
	
%>


	<br/><br/><br/>
	<div class="container">
	<div class="box2">
		<table>
			<tr>
				<td>
				<form action="buyListForm.jsp" method="post" enctype="multipart/form-data">
					<table width="680" height="500">
						<tr  height="60">
							<th colspan="4"> <h2> Q & A </h2> </th>
							<th> 
								<input type="button"  value="글쓰기" onclick="window.location='qnaForm.jsp'"/>
							</th>
						<tr height="30">	
							<td width="60">　No　</td> 
							<td >제목</td>
							<td width="70">작성자</td>
							<td >등록일</td>
							<td width="60">조회수</td>
						</tr>
						<%
						if(count>0){
							
							for(int i = 0 ; i <list.size() ; i++){
								QnaDTO qnalist = list.get(i);
								member=dao0.getMember(qnalist.getMnum());
							%>
							<tr>
								<td><%=number-- %></td>
								<td> <a href="qnaViewForm.jsp?qnum=<%=qnalist.getQnum()%>"><%=qnalist.getQtitle() %> </a> </td>
								<td><%=member.getMid()%></td>
								<td><%=sdf.format(qnalist.getQreg())%></td>
								<td><%=qnalist.getQreadcount()%></td>
							</tr>
						<%	}
						
						}else{ %>
							<tr  >
								<td colspan="5">등록된 문의가 없습니다.</td>
							</tr>
						<%} %>
							<tr height="40">
								<td colspan="5" align="right"> <input type="button" value="뒤로" onclick="window.location='supportForm.jsp'" /></td>
							</tr>
					
					</table>
				</form>
				</td>			
			</tr>
			<tr>
				<td>
				<div1 align="center">
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
				            <a class="pageNums" href="qnaListForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>"> &lt; &nbsp; </a>
				         <%}else{%>
				            <a class="pageNums" href="qnaListForm.jsp?pageNum=<%=startPage-1%>"> &lt; &nbsp; </a>
				         <%}
				      }
				      
				      for(int i = startPage; i <= endPage; i++) { 
				         if(search != null) { %>
				            <a class="pageNums" href="qnaListForm.jsp?pageNum=<%=i%>&search=<%=search%>"> &nbsp; <%= i %> &nbsp; </a>
				         <%}else{ %>
				            <a class="pageNums" href="qnaListForm.jsp?pageNum=<%=i%>"> &nbsp; <%= i %> &nbsp; </a> 
				         <%} 
				      }
				      
				      if(endPage < pageCount) { 
				         if(search != null) { %>
				            <a class="pageNums" href="qnaListForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>"> &nbsp; &gt; </a>
				      <%   }else{ %>
				            <a class="pageNums" href="qnaListForm.jsp?pageNum=<%=startPage+pageNumSize%>"> &nbsp; &gt; </a>
				      <%   }
				      } 
			      
			      
			      }//if count > 0 %>
			      <%-- 작성자/내용 검색 --%>
			      <form action="qnaListForm.jsp">
			         <input type="text" name="search" placeholder="문의사항을 입력하세요" /> 
			         <input type="submit" value="검색" />
			      </form>
			      <button onclick="window.location='qnaListForm.jsp'"> 전체 목록 </button>
				</td>			
			</tr>
		</table>
				
	</div>
	</div>
	
	
	
	<br /><br /><br /><br />
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