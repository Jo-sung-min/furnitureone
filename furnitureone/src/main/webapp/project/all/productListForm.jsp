<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css"/>
<style >
.navi_bar_area {
  overflow: hidden;
  background-color: #C7BEA2;
}

.navi_bar_area a {
  float: left;
  font-size: 16px;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.dropdown {
  float: left;
  overflow: hidden;
  background-color: #E5DCC3;
}

.dropdown .dropbtn {
  font-size: 16px;
  font-weight: bold;  
  border: none;
  outline: none;
  color: white;
  background-color: inherit;
  font-family: inherit;
  margin: 0;
  width:200px;
  height:40;
}

.dropdown-content {
 	display:none;
  position: absolute;
  background-color: #C7BEA2;/* 버튼 마우스 갖다 댔을때 나오는 상자 배경*/
  width: 450px;
  z-index: 1;
}
.dropdown:hover .dropdown-content {
  display: list-item;
}

.navi_bar_area a:hover, .dropdown:hover .dropbtn {
  background-color: #C7BEA2;
  width: 200px;
  height: 30px;
}

.dropdown-content a:hover {
  background-color: C7BEA2; /*마우스 가져다 댔을때 상자 배경*/
    width: 150px;
  height: 30px;
}

.dropdown-content a {
  float: none;
  color: black;
  text-decoration: none;
  display: inline-block;
  text-align: left;
  width: 130px;
}
.container{
   	   background-color: #E5DCC3;
       width: 100%;
       display: flex;
        justify-content: space-around;
   }


 .container1{
   	   background-color: #E5DCC3;
       width: 100%;
       top : 100px;
       float: left;
       display: flex;
   }
   
    
 .container2{
   	   background-color: #E5DCC3;
       width: 70%;
   }
 

.box1 {
  		 background-color: #E5DCC3;
 	 	width: 100%;
       float: right;
       display: flex;
       flex-direction: row;
}
.box2 {
	background-color: #E5DCC3;
	width: 100%;
	float: right;
	display: flex;
    flex-direction: row;
}
.box3 {
	background-color: #E5DCC3;
	width: 100%;
	float: right;
	display: flex;
    flex-direction: row;
}
.box4 {
	background-color: #E5DCC3;
	width: 100%;
	float: right;
	display: flex;
    flex-direction: row;
}
.box5 {
	background-color: #E5DCC3;
	width: 100%;
	float: right;
	display: flex;
    flex-direction: row;
}
.box6 {
	background-color: #E5DCC3;
	width: 100%;
	height : 200px;
	float: right;
}

div#side_left {
	background-color: #E5DCC3;
	width: 26%;
	height : 700px;
	top : 100px;
	position: sticky;
	float: left;
}





</style>


</head>
 
 	<%-- 로그인확인 & 로그인처리 --%>
<%
		//로그인 확인
		String Mid =(String)session.getAttribute("memId");

		MemberDAO dao0 = new MemberDAO();
		int mnum = dao0.getMnum(Mid);
		MemberDTO member = dao0.getMember(mnum); 

	
	
%>
	<%--페이징 처리 --%>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){ // pageNum 파라미터 안넘어오면, 1페이지 보여지게 
		pageNum = "1";   // 1로 값 체우기 
	}
	System.out.println("pageNum : " + pageNum);
	
	int pageSize = 5;  // 현재 페이지에서 보여줄 글 목록의 수 
	int currentPage = Integer.parseInt(pageNum); // pageNum을 int로 형변환 -> 숫자 연산 
	int startRow = (currentPage - 1) * pageSize + 1; 
	int endRow = currentPage * pageSize; 
	

	
	
	//전체 상품의 개수 구하고
	
	int count = 0; 				//  전체 상품 개수 담을 변수 
  	int searchCount = 0; //검색상품갯수 초기화
  	
	List productList = null; 	//  상품 목록 리턴받을 변수 
	
	ProductDAO dao = new ProductDAO();
  	count = dao.getAllProductCount(); // 모든상품 갯수 세어주기
  	
	
%>

	<%-- 물품 상세검색 확인 --%>
<%
		
				


		// 상품 타입 검색할때 받을 데이터
		String productType =request.getParameter("productType");
		if(productType==null){
			productType ="없음";	// 기본값 설정
		}
			System.out.println("물품타입"+productType);
		
		
		//상품색상 검색할때 받을 데이터
		String color1 =request.getParameter("color1");
		if(color1==null){
			color1 ="없음";
		}
			System.out.println("물품색"+color1);
		
			
		//상품가격 검색할때 받을 데이터
				int fPrice =0;
		if(request.getParameter("fPrice")==null||request.getParameter("fPrice")==""){
				fPrice =0;
				System.out.println("처음가격"+fPrice);
		}else{
				fPrice =Integer.parseInt(request.getParameter("fPrice").trim());
				System.out.println("처음가격"+fPrice);
		}
			
		
				int	ePrice =1010101;
		if(request.getParameter("ePrice")==null||request.getParameter("ePrice")==""){
				ePrice =1010101;
				System.out.println("마지막가격"+ePrice);
		}else{
				ePrice =Integer.parseInt(request.getParameter("ePrice").trim());
				System.out.println("마지막가격"+ePrice);
		}
			
	
%>









<%

		// 맨 밑 물건 보여주는 메서드
		//물건 순위 상관없이 다 보여주는 메서드
		//상세검색 변수들
		ProductDAO dao1 = new ProductDAO();
		int productCount =1;
		String sort= request.getParameter("sort");
		if(sort==null){
			sort="없음";
		}
		List<ProductDTO> list2 =null;
		List<ProductDTO> list3 =null;
		
		
		
		
		//이름으로 , 상품타입으로 , 색상으로 ,가격으로
			String color = request.getParameter("color");
			System.out.println(color);
			if(color==null){
				color = "white"; // 일단 red 나중에 화이트
			}
			System.out.println("배경색"+color);
		
			
			
					
			//상세검색이 없으면 모든 리스트 띄워주기 
		if( productType.equals("없음") && color1.equals("없음") &&fPrice==0 && ePrice==1010101){
		
			if(sort.equals("simple") || sort.equals("없음")){
				sort="없음";
				list2= dao1.getAllProductList(startRow, endRow);
				System.out.println("모든리스트:");
				
			//평점순일떄	
			}else if(sort.equals("review")){
				list2=dao1.getProductRgrade(startRow, endRow);
				System.out.println("평점순:");
				
			//판매량순
			}else if(sort.equals("sell")){
				list2=dao1.getProductSell(startRow, endRow);
				System.out.println("판매량순:");
				
			//낮은 가격순	
			}else if(sort.equals("lPrice")){
				list2=dao1.getProductFprice(startRow, endRow);
				System.out.println("낮은가격순:");
				
			//높은 가격순	
			}else if(sort.equals("hPrice")){
				list2=dao1.getProductEprice(startRow, endRow);
				System.out.println("높은 가격순:");
				
			}else if(sort.equals("zzim")){
				list2=dao1.getProductzzim(startRow, endRow);
				System.out.println("찜순 :");				
			}
				

			
			
			//상세검색에 물품 타입검색이 있으면
		}else if(!productType.equals("없음")&&  color1.equals("없음") &&fPrice==0 && ePrice==1010101){
			list3 = dao1.getSearchTypeProductList(productType);
			list2 = dao1.getSearchTypeProductList(productType, startRow, endRow);
			if(list3!=null){
			count =list3.size();
			}else{
			count =0;
			}
			System.out.println("물품타입 리스트:");
			
			
			//상세검색에 물품 색상만 있으면
		}else if(productType.equals("없음") &&  !color1.equals("없음") &&fPrice==0 && ePrice==1010101){
			list3 = dao1.getSearchColorProductList(color1);// 세어주기 위해서
			list2 = dao1.getSearchColorProductList(color1,startRow, endRow);
			if(list3!=null){
				count =list3.size();
			}else{
				count =0;
				}
			System.out.println("물품색상 리스트:");
			
			
			
			//상세검색에 물품 가격만 있으면
		}else if(productType.equals("없음") &&  color1.equals("없음") && request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list3 = dao1.getSearchPriceProductList(fPrice, ePrice);
			list2 = dao1.getSearchPriceProductList(fPrice, ePrice, startRow, endRow);
			if(list3!=null){
				count =list3.size();
			}else{
				count =0;
				}
			System.out.println("물품가격 리스트:");
			
			
			//상세검색에 물품 타입 가격
		}else if(!productType.equals("없음")  && color1.equals("없음") &&request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list3 = dao1.getSearchProductList(productType, fPrice, ePrice);
			list2 = dao1.getSearchProductList(productType, fPrice, ePrice, startRow, endRow);
			if(list3!=null){
				count =list3.size();
			}else{
				count =0;
				}
			System.out.println("물품타입&가격 리스트:");
			
			
			//상세검색에 물품 타입 색상
		}else if(!productType.equals("없음") && !color1.equals("없음") &&fPrice==0 && ePrice==1010101){
			list3 = dao1.getSearchProductList(productType, color1);
			list2 = dao1.getSearchProductList(productType, color1,startRow, endRow);
			if(list3!=null){
				count =list2.size();
			}else{
				count =0;
				}
			System.out.println("물품타입&색상 리스트:");
			System.out.println(color1);
		
		
		
			//상세검색에 물품 색상 가격
		}else if(productType.equals("없음") && !color1.equals("없음") &&request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list3 = dao1.getSearchProductList(fPrice, ePrice, color1);
			list2 = dao1.getSearchProductList(fPrice, ePrice, color1,startRow, endRow);
			if(list3!=null){
				count =list3.size();
			}else{
				count =0;
				}
			System.out.println("물품색상&가격 리스트:");
			
			
		} else if(!productType.equals("없음") && !color1.equals("없음") &&request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list3 = dao1.getSearchProductList(productType,fPrice, ePrice, color1);
			list2 = dao1.getSearchProductList(productType,fPrice, ePrice, color1,startRow, endRow);
			if(list3!=null){
				count =list3.size();
			}else{
				count =0;
				}
			System.out.println("물품타입 &물품색상&가격 리스트:");
			
			
		}  
		
			
		if(list2==null){
			productCount=0;
		}else{
			productCount=list2.size();
		}
		
		System.out.println();	
			
			
			
		
		String search = request.getParameter("search"); 
	 	if(search != null) { // 검색일때 
	 		count = dao.getProductSearchCount(search);  // 검색에 맞는 게시글에 개수 가져오기 
	 		if(count > 0) {
	 			// 상세검색한 물건 목록 가져오기 
	 			list2 = dao.getProductSearch(startRow, endRow, search); 
	 		 	System.out.println("검색했을떄");
	 		 	
	 		 	
	 		}else if(count==0){
	 			list2=null;
	 			System.out.println("검색 이상하게 했을떄");
	 		}
	 		
	 		
	 		
	 	}
	 	
	 	
	 	
	 	System.out.println("productList count : " + count);
	 	System.out.println(list2);
		
		
		
		
		
		
			
			
			
%>
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
		<br/><br/><br/>




	
	
 <div class="container"> 
	<div id="side_left">
	<form action="productListForm.jsp" method="post">
		<table width="200" height="700" >
			<tr height="70">
				<td>   <font size="5"  color="9A9483">검 색 메 뉴</font> </td>
			</tr>
			<tr>
				<td>
					<div class="navi_bar_area">
					<div1 class="dropdown">
				    <button class="dropbtn" ><font size="4"  color="9A9483">거실</font>
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				    	<a href="productListForm.jsp?productType=sofa"><input type="radio" name="productType" value="sofa"/> 소파</a>
				    	<a href="productListForm.jsp?productType=storageCloset"><input type="radio" name="productType" value="storageCloset"> 수납장</a>
				    	<a href="productListForm.jsp?productType=livingRoomDresser"><input type="radio" name="productType" value="livingRoomDresser"> 거실장</a>
				    </div>			
					</div1>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="navi_bar_area">
					<div class="dropdown">
				    <button class="dropbtn"><font size="4"  color="9A9483">침실</font> 
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				    	<a href="productListForm.jsp?productType=mattress"><input type="radio" name="productType" value="mattress"> 매트리스</a>
				    	<a href="productListForm.jsp?productType=dressingTable"><input type="radio" name="productType" value="dressingTable" >화장대</a>
				    	<a href="productListForm.jsp?productType=closet"><input type="radio" name="productType" value="closet">옷장</a>
				    </div>			
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="navi_bar_area">
					<div class="dropdown">
				    <button class="dropbtn"> <font size="4"  color="9A9483">주방</font>
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				    	<a href="productListForm.jsp?productType=diningTable"><input type="radio" name="productType" value="diningTable"> 식탁</a>
				    	<a href="productListForm.jsp?productType=diningChair"><input type="radio" name="productType" value="diningChair">의자</a>
				    	<a href="productListForm.jsp?productType=shelf"><input type="radio" name="productType" value="shelf">선반</a>
				    </div>			
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="navi_bar_area">
					<div class="dropdown">
				    <button class="dropbtn"> <font size="4"  color="9A9483">서재</font>
				      <i class="fa fa-caret-down"></i>
				    </button>
				    <div class="dropdown-content">
				    	<a href="productListForm.jsp?productType=desk"><input type="radio" name="productType" value="desk"> 책상</a>
				    	<a href="productListForm.jsp?productType=chair"><input type="radio" name="productType" value="chair">의자</a>
				    	<a href="productListForm.jsp?productType=bookcase"><input type="radio" name="productType" value="bookcase">책장</a>
				    </div>			
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<font size="4"  color="9A9483">상품색상</font> <br/>
					<select name="color1" >
						<option value="없음" checked>선택</option>
						<option value="white">백색</option>
						<option value="gray">회색</option>
						<option value="black">흑색</option>
						<option value="brown">갈색</option>
						<option value="navy">청색</option>
						<option value="red">적색</option>
						<option value="green">녹색</option>
					</select> 
				</td>
			</tr>
			<tr>
				<td><font size="4"  color="9A9483">가격</font></td>
			</tr>
			<tr>
				<td>
				<input type="text" name="fPrice"  size=10 maxlength=8/>원<br/>~<br/>
				<input type="text" name="ePrice"  size=10/>원
				</td>
			</tr>
			<tr>
				<td> <a href="supportForm.jsp"><font size="4"  color="9A9483">고객지원</font></a></td>
			</tr>
			<tr>
				<td> <input type="submit" value="검색"> </td>
			</tr>
		</table>
	</div>


	<div class="container1">
	
	<table>
		<tr>
			<td>
			<table width="1200" height="800" >
				<tr height="60">
					<td colspan="6"> <h2>상 품 목 록</h2>  </td>		
					<td >
					<div1> 
						<form action="productListForm.jsp" method="post">
							<table>
								<tr>
									<td>
										상품 정렬 <br/>
										<select name="sort" >
											<option value="simple" checked>기본순</option>
											<option value="review">평점순</option>
											<option value="sell">판매량순</option>
											<option value="lPrice">낮은 가격순</option>
											<option value="hPrice">높은 가격순</option>
										</select> 
									</td>
								</tr>
								<tr>
									<td> <input type="submit" value="검색"> </td>
								</tr>
							</table>
						</form>
						</div1>				
					</td>		
				</tr>
				<%
				if(list2!=null){
				int Count=1;
				
				if(list2.size()>=0 && list2.size()<8){
					Count=list2.size();
				}else if(list2.size()>=8){
					Count =8;
				}%>
				
				<tr height="30">
					<td width="200">상품명</td>		
					<td width="200">이미지</td>		
					<td>제품설명</td>		
					<td width="50">평점</td>		
					<td width="50">찜</td>		
					<td width="60">판매량</td>		
					<td width="100">가격</td>		
				</tr>
				<%
					// 컬러선택했을때 추천해주는 리스트
					for(int i = 0 ;i<Count ; i++){
						ProductDTO product =list2.get(i);
				%>
				<tr>
					<%if(product.getPstock()==0){%>
						<td> <%=product.getPname()%>
						<br/>상품 완판!(재입고 준비중)</td>		
					<%}else{%>
						<td><%=product.getPname()%></td>		
					<%} %>
					<td ><a href="detailForm.jsp?Pnum=<%=product.getPnum()%>">
					<img src="/furnitureone/oneimg/<%=product.getPimg()%>" width="100" /></a>
					</td> 	
					<td><%=product.getPcontent()%></td>		
					<td><%=product.getPgrade()%></td>		
					<td><%=product.getPpick()%></td>		
					<td><%=product.getPsellst()%></td>		
					<td><%=product.getPprice()%>원</td>		
				</tr>
		
				<%	}%>
				
				
			<%}else{%>
				<tr height="60" >
					<td colspan="7">카테고리 선택에 따른 메뉴들</td>		
				</tr>
				<tr height="30">
					<td width="200">상품명</td>		
					<td width="200">이미지</td>		
					<td>제품설명</td>		
					<td width="50">평점</td>		
					<td width="50">찜</td>		
					<td width="60">판매량</td>		
					<td width="100">가격</td>		
				</tr>
				<tr>
					<td colspan="7">
						상품을 준비중입니다.
					</td>
				</tr>
			
			<%	}%>
			
				</table>	
				</div>
			</td>
		</tr>
	<%-- 상품 목록 페이지 번호 뷰어 --%>
		<tr>
			<td>
			<div1 align="center">
			<% if(count > 0) { 
				// 한페이지에 보여줄 번호의 개수 
				int pageNumSize = 5; 
				// 총 몇페이지 나오는지 계산 
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				// 현재 페이지에 띄울 첫번째 페이지 번호 
				int startPage = ((currentPage - 1) / pageSize) * pageNumSize+1 ; 
				// 현재 페이지에 띄울 마지막 페이지번호  (startPage ~ endPage까지 번호 반복해서 뿌릴)
				int endPage = startPage + pageNumSize - 1; 
				if(endPage > pageCount) { endPage = pageCount; } // 마지막 페이지번호 조정 
		
				if(startPage > pageNumSize) { 
					if( search != null) { %>
						<a class="pageNums" href="productListForm.jsp?pageNum=<%=startPage-1%>&search=<%=search%>&color1=<%=color1%>&fPrice=<%=fPrice%>&ePrice=<%=ePrice%>&productType=<%=productType%>&sort=<%=sort%>"> &lt; &nbsp; </a>
					<%}else{%>
						<a class="pageNums" href="productListForm.jsp?pageNum=<%=startPage-1%>&color1=<%=color1%>&fPrice=<%=fPrice%>&ePrice=<%=ePrice%>&productType=<%=productType%>&sort=<%=sort%>"> &lt; &nbsp; </a>
					<%}
				}
				
				for(int i = startPage; i <= endPage; i++) { 
					if(search != null) { %>
						<a class="pageNums" href="productListForm.jsp?pageNum=<%=i%>&search=<%=search%>&color1=<%=color1%>&fPrice=<%=fPrice%>&ePrice=<%=ePrice%>&productType=<%=productType%>&sort=<%=sort%>"> &nbsp; <%= i %> &nbsp; </a>
					<%}else{ %>
						<a class="pageNums" href="productListForm.jsp?pageNum=<%=i%>&color1=<%=color1%>&fPrice=<%=fPrice%>&ePrice=<%=ePrice%>&productType=<%=productType%>&sort=<%=sort%>"> &nbsp; <%= i %> &nbsp; </a> 
					<%} 
				}
				
				if(endPage < pageCount) { 
					if( search != null) { %>
						<a class="pageNums" href="productListForm.jsp?pageNum=<%=startPage+pageNumSize%>&search=<%=search%>&color1=<%=color1%>&fPrice=<%=fPrice%>&ePrice=<%=ePrice%>&productType=<%=productType%>&sort=<%=sort%>"> &nbsp; &gt; </a>
				<%	}else{ %>
						<a class="pageNums" href="productListForm.jsp?pageNum=<%=startPage+pageNumSize%>&color1=<%=color1%>&fPrice=<%=fPrice%>&ePrice=<%=ePrice%>&productType=<%=productType%>&sort=<%=sort%>"> &nbsp; &gt; </a>
				<%	}
				} 
				
				}//if count > 0 %>
		
				<%-- 작성자/내용 검색 --%>
				<form action="productListForm.jsp?pageNum=1">
					<input type="text" name="search" /> 
					<input type="submit" value="상품명검색" />
				</form>
				<button onclick="window.location='productListForm.jsp?pageNum=1'"> 전체 게시글 </button>
			</div1>
			</td>
		</tr>
	</table>
	</div>
	</div>
			
			
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