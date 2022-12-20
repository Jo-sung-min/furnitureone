<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.ReviewDAO"%>
<%@page import="web.team.one.ReviewDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="style.css" rel="stylesheet" type="text/css"/>

<style>

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
       float: right;
       display: flex;
   }
 .container2{
   	   background-color: #E5DCC3;
   	   float: right;
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
	width: 15%;
	height : 700px;
	top : 100px;
	position: sticky;
	float: left;
}
footer {
		    background-color: #E5DCC3;
		    width: 100%;
		    height: 120px;
		    bottom : 0;
		    left: 0;
		    position: absolute; /* 위치를 하단에 고정 */
		    z-index: 1000;
			}

font{
font-weight :  1000;
}

div2 p {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 200px;
}


</style>

	<%-- 로그인확인 & 로그인처리 --%>
<%
		//로그인 확인
		String Mid =(String)session.getAttribute("memId");

		MemberDAO dao0 = new MemberDAO();
		int mnum = dao0.getMnum(Mid);
		MemberDTO member = dao0.getMember(mnum); 

	
	
%>

	<%-- 물품 상세검색 확인 --%>
<%
		request.setCharacterEncoding("UTF-8");
				


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
      if(request.getParameter("fPrice") != null){
         if(request.getParameter("fPrice").trim()==null||request.getParameter("fPrice").trim()==""){
               fPrice =0;
               System.out.println("처음가격"+fPrice);
         }else{
               fPrice =Integer.parseInt(request.getParameter("fPrice").trim());
               System.out.println("처음가격"+fPrice);
         }
      }   
      
      int   ePrice =90010101;
      if(request.getParameter("ePrice") != null){
         if(request.getParameter("ePrice").trim()==null|| request.getParameter("ePrice").trim()==""){
               ePrice =90010101;
               System.out.println("마지막가격"+ePrice);
         }else{
               ePrice =Integer.parseInt(request.getParameter("ePrice").trim());
               System.out.println("마지막가격"+ePrice);
         }
      }   	
		
%>





<%
		//물건 정보 색에 따른 best3 리스트로 가져오기 기본 화이트
		String color = request.getParameter("color");
		System.out.println(color);
		if(color==null){
			color = "white"; // 일단 red 나중에 화이트
		}
		System.out.println("배경색"+color);
		
		ProductDAO dao1 = new ProductDAO();
		ProductDTO PBest1=null;
		ProductDTO PBest2=null;
		ProductDTO PBest3=null;
		
		List<ProductDTO> list1 = dao1.getBestProduct(color);
		

%>


<%
		//물건 넘버 가져오기 디폴트
		int Pnum =1;
		System.out.println("물건 넘버:"+Pnum);	
		//리뷰 가져오는 메서드
		ReviewDAO dao = new ReviewDAO();
		//가져온 리뷰 담을 객체
		List<ReviewDTO> list = dao.getBestReview(Pnum);
		//리뷰 세어주는 메서드
		int countReview = dao.reviewCount(Pnum);
		//추천상품은 리뷰가 3개 이상있는걸로 가져오는 처리
		System.out.println("리뷰갯수:"+countReview);
		
%>




<%

		// 맨 밑 물건 보여주는 메서드
		//물건 순위 상관없이 다 보여주는 메서드
		//상세검색 변수들
		String ProductSearch= request.getParameter("ProductSearch");
		String sort= request.getParameter("sort");
		if(sort==null){
			sort="없음";
		}
		int productCount =1;
		List<ProductDTO> list2 =null;
		
		
		
		
		
		
		//이름으로 , 상품타입으로 , 색상으로 ,가격으로
			list2 = dao1.getBestProduct(color);
			if(list2==null){
				productCount=0;
			}else{
				productCount=list2.size();
			}
			
			System.out.println();
			
					
			//상세검색이 없으면 모든 리스트 띄워주기 
		if( productType.equals("없음") && color1.equals("없음") &&fPrice==0 && ePrice==90010101){
			
			//기본 정렬일때
			if(sort.equals("simple") || sort.equals("없음")){
				sort="없음";
				list2=dao1.getBestProduct(color);
				System.out.println("모든리스트:");
				
			//평점순일떄	
			}else if(sort.equals("review")){
				list2=dao1.getProductRgrade();
				System.out.println("평점순:");
				
			//판매량순
			}else if(sort.equals("sell")){
				list2=dao1.getProductSell();
				System.out.println("판매량순:");
				
			//낮은 가격순	
			}else if(sort.equals("lPrice")){
				list2=dao1.getProductFprice();
				System.out.println("낮은가격순:");
				
			//높은 가격순	
			}else if(sort.equals("hPrice")){
				list2=dao1.getProductEprice();
				System.out.println("높은 가격순:");
				
			}else if(sort.equals("zzim")){
				list2=dao1.getProductzzim();
				System.out.println("찜순:");
				
				
			}
				
			
			
			
			//상세검색에 물품 타입검색이 있으면
		}else if(!productType.equals("없음") && color1.equals("없음") &&fPrice==0 && ePrice==90010101){
			list2 = dao1.getSearchTypeProductList(productType);
			System.out.println("물품타입 리스트:");
			
			
			//상세검색에 물품 색상만 있으면
		}else if(productType.equals("없음") && !color1.equals("없음") &&fPrice==0 && ePrice==90010101){
			list2 = dao1.getSearchColorProductList(color1);
			System.out.println("물품색상 리스트:");
			
			
			
			//상세검색에 물품 가격만 있으면
		}else if(productType.equals("없음") && color1.equals("없음") && request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list2 = dao1.getSearchPriceProductList(fPrice , ePrice);
			System.out.println("물품가격 리스트:");
			
			
			//상세검색에 물품 타입 가격
		}else if(!productType.equals("없음") && color1.equals("없음") &&request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list2 = dao1.getSearchProductList(productType, fPrice, ePrice);
			
			System.out.println("물품타입&가격 리스트:");
			
			
			//상세검색에 물품 타입 색상
		}else if(!productType.equals("없음")  && !color1.equals("없음") &&fPrice==0 && ePrice==90010101){
			list2 = dao1.getSearchProductList(productType, color1);
			System.out.println("물품타입&색상 리스트:");
			System.out.println(color1);
		
		
		
			//상세검색에 물품 색상 가격
		}else if(productType.equals("없음")  && !color1.equals("없음") &&request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list2 = dao1.getSearchProductList(fPrice, ePrice, color1);
			
			System.out.println("물품색상&가격 리스트:");
			 
			
		}else if(!productType.equals("없음")  && !color1.equals("없음") &&request.getParameter("fPrice")!=null && request.getParameter("ePrice")!=null){
			list2 = dao1.getSearchProductList(productType,fPrice, ePrice, color1);
			System.out.println("모들 물품 리스트 리스트:");
			
		}  
		
		
			
			
			
%>





<body>
	
	<%if(Mid==null){ %>
	<header>
	  	<div class="inner">
	         <div class="header-container">
          	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 카테고리</div>
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
          	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 카테고리</div>
          	 	 	<h1 align="center"  onclick="window.location='premainForm.jsp'">Furniture One</h1>            
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
	
	 
	 
	 
	 
	 
	 
 <div class="container">
	<div id="side_left">
		<form action="mainForm.jsp" method="post">
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
				    	<a href="mainForm.jsp?productType=sofa"><input type="radio" name="productType" value="sofa"/> 소파</a>
				    	<a href="mainForm.jsp?productType=storageCloset"><input type="radio" name="productType" value="storageCloset"> 수납장</a>
				    	<a href="mainForm.jsp?productType=livingRoomDresser"><input type="radio" name="productType" value="livingRoomDresser"> 거실장</a>
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
				    	<a href="mainForm.jsp?productType=mattress"><input type="radio" name="productType" value="mattress"> 매트리스</a>
				    	<a href="mainForm.jsp?productType=dressingTable"><input type="radio" name="productType" value="dressingTable" >화장대</a>
				    	<a href="mainForm.jsp?productType=closet"><input type="radio" name="productType" value="closet">옷장</a>
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
				    	<a href="mainForm.jsp?productType=diningTable"><input type="radio" name="productType" value="diningTable"> 식탁</a>
				    	<a href="mainForm.jsp?productType=diningChair"><input type="radio" name="productType" value="diningChair">의자</a>
				    	<a href="mainForm.jsp?productType=shelf"><input type="radio" name="productType" value="shelf">선반</a>
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
				    	<a href="mainForm.jsp?productType=desk"><input type="radio" name="productType" value="desk"> 책상</a>
				    	<a href="mainForm.jsp?productType=chair"><input type="radio" name="productType" value="chair">의자</a>
				    	<a href="mainForm.jsp?productType=bookcase"><input type="radio" name="productType" value="bookcase">책장</a>
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
		</form>
	</div>
   



	




		<br/><br/><br/>
		<%--벽지 색 선택--%>
		<div class="container2">
		
		<div class="container1">
		<table width="100%">
			<tr>
				<td>
				<form action="mainForm.jsp" >
					<table width="100%" height="100">
						<tr align="center" >
							<td colspan="7"> <h2> 벽지 색 선택에 따른 추천</h2></td>		
						</tr>
						<tr>
							<td><img src="/furnitureone/oneimg/white.png" width="50" /></td>
							<td><img src="/furnitureone/oneimg/DarkGrey.png" width="50" /></td>
							<td><img src="/furnitureone/oneimg/Black.png" width="50" /></td>
							<td><img src="/furnitureone/oneimg/Brown.png" width="50" /></td>
							<td><img src="/furnitureone/oneimg/LightBlue.png" width="50" /></td>
							<td><img src="/furnitureone/oneimg/IndianRed.png" width="50" /></td>
							<td><img src="/furnitureone/oneimg/SeaGreen.png" width="50" /></td>
						</tr>
						<tr>
							<td><input type="radio" name="color" value="white"/>흰색</td>
							<td><input type="radio" name="color" value="gray"/>회색</td>
							<td><input type="radio" name="color" value="black" />흑색</td>
							<td><input type="radio" name="color" value="brown"/>갈색</td>
							<td><input type="radio" name="color" value="navy" />청색</td>
							<td><input type="radio" name="color" value="red"/>적색</td>
							<td><input type="radio" name="color" value="green"/>녹색</td>
						</tr>
						<tr >
							<td colspan="7"><input type="submit" value="선택" /></td> 
						</tr>
					</table>
					</form>
					</td>
					</tr>
				</table>
			</div>
		
		
		
		
		<%--추천상품 1--%>
		
	<div class="container1">
		<%if(productCount>3){ %> 
		<%
		PBest1 = list1.get(0);
		
		Pnum =PBest1.getPnum(); //best1의 물품네임
		list = dao.getBestReview(Pnum);
		countReview = dao.reviewCount(Pnum);
		double ave = 0.0;
		if(countReview>0){
			ave = dao.getAvePgrade(Pnum, countReview);
		}
		
		%>
		
		<table width="90%" height="487" >
			<tr height="35" >
				<%if(PBest1.getPstock()==0){%>
					<td colspan="4">완판!!(재입고 대기중)</td>		
				<%}else{%>
					<td colspan="4"> <font color="MediumVioletRed" size="4" >BEST</font></td>		
				<%} %>
			</tr>
			<tr height="35"  >
				<%if(ave==0.0){ %>
					<td colspan="4"><%= PBest1.getPname()+"   "%>평점★(없음) </td>		
				<%}else{ %>
					<td colspan="4"><%= PBest1.getPname()+"   "%>평점★(<%=(double)Math.round(ave*100)/100%>) </td>		
				<%} %>			
			</tr>
			<tr height="140" >
				<td colspan="4"><a href="detailForm.jsp?Pnum=<%=PBest1.getPnum()%>">
				<img src="/furnitureone/oneimg/<%=PBest1.getPimg()%>" width="120" /></a>
				</td> 	
			</tr  >
				<tr height="35">
				<th colspan="2">찜(<%=PBest1.getPpick()%>)</th>		
				<th></th>		
				<th>판매량(<%=PBest1.getPsellst()%>)</th>		
			</tr>
			<tr height="35" >
				<td width="75">ID</td>		
				<td width="75">평점</td>		
				<td colspan="2" width="250">리뷰</td>		
			</tr>
	
			<%
				if(countReview>=3){
					
					for(int i = 0 ;i<3 ;i++){
					ReviewDTO review = list.get(i);%> 
					
						<tr>
							<td ><%=review.getMid() %></td>		
							<td ><%=review.getRgrade() %></td>		
								<td colspan="2" "> <div2> <p> <%=review.getRcontent() %> </p></div2></td>		
						</tr>
					<%}
					
				}else if(countReview>0&&countReview<=2){ 

					for(int i = 0 ;i<list.size() ;i++){
					ReviewDTO review = list.get(i);%> 
						<tr>
							<td ><%=review.getMid() %></td>		
							<td ><%=review.getRgrade() %></td>		
							<td colspan="2" "> <div2> <p> <%=review.getRcontent() %> </p></div2></td>		
						</tr>
					<%}%>
				<%}else{ %>	
				<tr>
					<td colspan="4">등록된 리뷰가 없습니다.</td>
				</tr>	
			
				<%} %>			
				<tr height="35">
					<td colspan="4"></td>
				</tr>
			
		</table>
		<%}else{ %>
		<table>
			<tr>
				<td>상품 준비중입니다.</td>
			</tr>		
		</table>
		<%} %>
		<br/>
		
		
		
		<%--추천상품 2--%>
		<%if(productCount>3){ %> 
		<%
		
		PBest2 = list1.get(1);
		Pnum =PBest2.getPnum(); //best2의 물품네임
		list = dao.getBestReview(Pnum);
		countReview = dao.reviewCount(Pnum);
		double ave = 0.0;
		if(countReview>0){
			ave = dao.getAvePgrade(Pnum, countReview);
		}
		
		%>
		<table width="90%" height="487" >
			<tr height="35">
				<%if(PBest2.getPstock()==0){%>
					<td colspan="4">완판!!(재입고 대기중)</td>		
				<%}else{%>
					<td colspan="4"><font color="LightCoral" size="4" >BEST</font></td>		
				<%} %>		
			</tr>
			<tr height="35">
				<%if(ave==0.0){ %>
					<td colspan="4"><%= PBest2.getPname()+"   "%>평점★(없음) </td>		
				<%}else{ %>
					<td colspan="4"><%= PBest2.getPname()+"   "%>평점★(<%=(double)Math.round(ave*100)/100%>) </td>		
				<%} %>			
			</tr>
			<tr height="140">
				<td colspan="4"><a href="detailForm.jsp?Pnum=<%=PBest2.getPnum()%>">
				<img src="/furnitureone/oneimg/<%=PBest2.getPimg()%>" width="120" /></a>
				</td> 	 	
			</tr>
			<tr height="35">
				<th colspan="2">찜(<%=PBest2.getPpick()%>)</th>		
				<th></th>		
				<th>판매량(<%=PBest2.getPsellst()%>)</th>		
			</tr>
			<tr height="35">
				<td width="75">ID</td>		
				<td width="75">평점</td>		
				<td colspan="2" width="250">리뷰</td>		
			</tr>
			<%
				if(countReview>=3){
					
					for(int i = 0 ;i<3 ;i++){
					ReviewDTO review = list.get(i);%> 
						<tr >
							<td ><%=review.getMid() %></td>		
							<td > <%=review.getRgrade() %></td>		
							<td colspan="2"> <div2> <p><%=review.getRcontent() %> </p></div2> </td>		
						</tr>
					<%}
					
				}else if(countReview>0&&countReview<=2){ 

					for(int i = 0 ;i<list.size() ;i++){
					ReviewDTO review = list.get(i);%> 
						<tr >
							<td><%=review.getMid() %></td>		
							<td ><%=review.getRgrade() %></td>		
							<td colspan="2" "> <div2> <p> <%=review.getRcontent() %> </p></div2></td>		
						</tr>
					<%}%>
				<%}else{ %>	
				
				<tr>
					<td colspan="4">등록된 리뷰가 없습니다.</td>
				</tr>	
			
				<%} %>
				<tr height="35">
					<td colspan="4"></td>
				</tr>
			
		</table>
			<%}else{ %>
		<table>
			<tr>
				<td>상품 준비중입니다.</td>
			</tr>		
		</table>
			<%} %>
		<br/>




		<%--추천상품 3--%>
		<%if(productCount>3){ %> 
		<%
		PBest3 = list1.get(2);
		Pnum =PBest3.getPnum(); //best3의 물품네임
		list = dao.getBestReview(Pnum);
		countReview = dao.reviewCount(Pnum);
		double ave = 0.0;
		if(countReview>0){
			ave = dao.getAvePgrade(Pnum, countReview);
		}
		%>			
		<table width="90%" height="487">
			<tr height="35">
				<%if(PBest3.getPstock()==0){%>
					<td colspan="4">완판!!(재입고 대기중)</td>		
				<%}else{%>
					<td colspan="4"> <font color="Coral" size="4" >BEST</font></td>		
				<%} %>		
			</tr>
			<tr height="35" >
				<%if(ave==0.0){ %>
					<td colspan="4"><%= PBest3.getPname()+"   "%>평점★(없음) </td>		
				<%}else{ %>
					<td colspan="4"><%= PBest3.getPname()+"   "%>평점★(<%=(double)Math.round(ave*100)/100%>) </td>		
				<%} %>			
			</tr>
			<tr height="140">
				<td colspan="4"><a href="detailForm.jsp?Pnum=<%=PBest3.getPnum()%>">
				<img src="/furnitureone/oneimg/<%=PBest3.getPimg()%>" width="120" /></a>
				</td> 		
			</tr>
			<tr height="35">
				<th colspan="2">찜(<%=PBest3.getPpick()%>)</th>		
				<th></th>		
				<th>판매량(<%=PBest3.getPsellst()%>)</th>		
			</tr>
			<tr height="35">
				<td width="75">ID</td>		
				<td width="75">평점</td>		
				<td colspan="2" width="250">리뷰</td>		
			</tr>
			
			
			
			<%
				if(countReview>=3){
					
					for(int i = 0 ;i<3 ;i++){
					ReviewDTO review = list.get(i);%> 
						<tr >
							<td ><%=review.getMid() %></td>		
							<td ><%=review.getRgrade() %></td>		
							<td colspan="2" "> <div2> <p> <%=review.getRcontent() %> </p></div2></td>		
						</tr>
					<%}
					
				}else if(countReview>0&&countReview<=2){ 

					for(int i = 0 ;i<list.size() ;i++){
					ReviewDTO review = list.get(i);%> 
						<tr >
							<td><%=review.getMid() %></td>		
							<td ><%=review.getRgrade() %></td>		
							<td colspan="2" "> <div2> <p> <%=review.getRcontent() %> </p></div2></td>		
						</tr>
							<%--<td> <input type="button" onclick="window.location='pickPro.jsp?Pnum=<%=review.getPnum()%>'" value="찜"> </td> --%>		
					<%}%>
				<%}else{ %>	
				
				<tr>
					<td colspan="4">등록된 리뷰가 없습니다.</td>
				</tr>	
			
				<%} %>
				<tr height="35">
					<td colspan="4"></td>
				</tr>
			
			
		</table>
		
			<%}else{ %>
		<table>
			<tr>
				<td>
					상품 준비중입니다.
				</td>
			</tr>		
		</table>
			<%} %>
	</div>
		<br/><br/><br/><br/>	

		





		
		
			<%
			//여기서 물품 8개만 띄우고 더보기 만들기
			
			
			
			
			if(list2!=null){
			int Count=1;
			
			if(list2.size()>=0 && list2.size()<8){
				Count=list2.size();
			}else if(list2.size()>=8){
				Count =8;
			}%>
				<div class="box5">	
					<table width=100%>
						<tr>
							<td colspan="6"> <h2 >상 품 목 록</h2> </td>		
							<td >
							<div1>
								<form action="mainForm.jsp" method="post">
									<table>
										<tr>
											<td>
												상품 정렬 <br/>
												<select name="sort" >
													<option value="simple" checked>기본순</option>
													<option value="review">평점순</option>
													<option value="sell">판매량순</option>
													<option value="zzim">찜순</option>
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
						<tr height="30">
							<td width="200">상품명</td>		
							<td width="200">이미지</td>		
							<td>제품설명</td>		
							<td width="50">평점</td>		
							<td width="50">찜</td>		
							<td width="50">판매량</td>		
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
							<td><%=product.getPsellst()%>개</td>		
							<td><%=product.getPprice()%>원</td>		
						</tr>
				
						<%	}%>
						<tr>
							<td colspan="7" align="right">
								<a href="productListForm.jsp?color=<%=color%>">더보기</a>
							</td>
						</tr>
						</table>	
					</div>
					<%}else{%>
								<div class="box5">	
					<table width="100%" height="500">
						<tr height="60">
							<td colspan="7"> <h2>상품목록</h2> </td>		
						</tr>
						<tr height="30">
							<td width="200">상품명</td>		
							<td width="200">이미지</td>		
							<td>제품설명</td>		
							<td width="50">평점</td>		
							<td width="50">찜</td>		
							<td width="50">판매량</td>		
							<td width="100">가격</td>		
						</tr>
						<tr>
							<td colspan="7">
								상품을 준비중입니다.
							</td>
						</tr>
						</table>	
					</div>
					</div>
					</div>
					
					<%	}%>
			
					
	<footer1>
	<div class="box6">
       <div class="inner">
          <div class="footer-container">
            <h2 align="left">Furniture One</h2>
			<a>개인정보 처리 방침． 서비스이용약관． 위치서비스 약관． 회사소개． 채용정보．</a> 
			<a>상호명：㈜F.O ｜ 대표이사 : 김대헌 ｜ 주소 : 서울특별시 마포구 신촌로 94, 7층(노고산동, 그랜드플라자)</a> 
			<a>사업자등록번호：187-85-01021｜개인정보보호책임자 : 더조은｜사업자정보확인</a>  
          </div>
       </div>
      </div>
    </footer1>




</body>
</html>