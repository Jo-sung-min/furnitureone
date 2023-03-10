<%@page import="web.team.one.InquiryDTO"%>
<%@page import="web.team.one.InquiryDAO"%>
<%@page import="web.team.one.HwanDTO"%>
<%@page import="web.team.one.HwanDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="java.util.List"%>
<%@page import="web.team.one.BuyDTO"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.SellregisDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.SellregisDAO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>
		<style>
		 .container{
	   	  	 background-color: #E5DCC3;
	       	width: 100%;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
	       	padding : 30px;
   		}
        .box1 {
            background-color: #E5DCC3;
       	  	 width: 300;
       	  	 height:500;
			justify-content: center;
	   		
        }
        .box2 {
        	background-color: #E5DCC3;
			width: 300;
			height:500;
			justify-content: center;
	   		
        }
        .box3 {
            background-color: E5DCC3;
	       	width: 300;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: center;
            
        }
    
        .box4 {
            background-color: E5DCC3;
	       	width: 300;
	       	height:500;
	       	display: flex;
	       	flex-direction: row;
	       	justify-content: left;
            
        }
    
	</style> 
</head>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("memId");
	
	MemberDAO memDAO = new MemberDAO();
	int mnum= memDAO.getMnum(id);
	MemberDTO memDTO = memDAO.getMember(mnum); 
	
	
	SellregisDAO sellDAO = new SellregisDAO();
	SellregisDTO sellDTO = sellDAO.getSeller(mnum);
	
	ProductDAO proDAO = new ProductDAO();
	List proList = proDAO.getMyProduct(id);
	
	BuyDAO buyDAO = new BuyDAO();
	List delList = buyDAO.getDelProduct(mnum);
	
	HwanDAO hwanDAO = new HwanDAO();
	List hwanList = hwanDAO.getMyHwan(mnum);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int ok = 0;
	int no = 1;
	
%>
<body>
	<br />
	<header>
	  	<div class="inner">
	         <div class="header-container">
          	 	 <div class="header-logo" onclick="window.location='mainForm.jsp'">??? ??????</div>
          	 	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
         	  	 		<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> ???????????? </button>
          	  	 </div>  
          	</div>         
      	</div>
   	</header>
	<%if(id == null){ %>
		<script>
			alert('????????? ??? ???????????????.');
			window.location.href = "loginForm.jsp";
		</script>
	<%}else{ %>
	<br/><br />
	
	<div class="container">
	<div class="box1">
		<form action="modifyForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530" height="407.38">
				<tr height="60">
					<td colspan="2"><h2>?????? ??????</h2></td>
				</tr>
				<tr>
					<td>????????? ??????</td>
					<td>
						<%if(memDTO.getMimg() != null){ %>
							<img width="140" height="140" src="/furnitureone/oneimg/<%=memDTO.getMimg()%>"/>
						<%}else{ %>
							<img width="140" height="140" src="/furnitureone/oneimg/default.png"/>
						<%} %>
					</td>
				</tr>
				<tr>
					<td>?????????</td>
					<td><%=memDTO.getMid() %></td>
				</tr>
				<tr>
					<td>??????</td>
					<td><%=memDTO.getMname() %></td>
				</tr>
				<tr>
					<td>?????????</td>
					<td><%=memDTO.getMemail() %></td>
				</tr>
				<tr>
					<td>????????????</td>
					<td><%=memDTO.getMtel() %></td>
				</tr>
				<tr height="55">
					<td colspan="2" align="right">
						<input type="submit" value="?????? ??????"/><br/>
						<input type="button" value="?????? ?????? ??????" onclick="window.location.href='stop.jsp'" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="box2">
		<form>
			<table width="530" height="407.38">
				<tr height="60">
					<td colspan="2"><h2>?????? ??????</h2></td>
				</tr>
				<%if(sellDTO != null){ %>
					<tr>
						<td>?????? ??????</td>
						<td><%=sellDTO.getScompany() %></td>
					</tr>
					<tr>
						<td>?????? ??????</td>
						<td><%=sellDTO.getSrepresent() %></td>
					</tr>
					<tr>
						<td>?????? ??????</td>
						<td><%=sellDTO.getScall() %></td>
					</tr>
					<tr>
						<td>?????? ??????</td>
						<td><%=sellDTO.getSaddr() %></td>
					</tr>
					<tr height="54.88">
						<td colspan="2" align="right">
						?????? ?????? ??? ??????????????? ??????????????????.<br />
						?????? ???????????? 1577-5670
						</td>
					</tr>
				<%}else{ %>
					<tr>
						<td colspan="2" >
							<h3>????????? ????????????. ????????? ?????? ??? ???????????????</h3> 
						</td>
					</tr>
					<tr height="55">
						
					</tr>
				<%} %>
			</table>
		</form>
	</div>
	</div>
	
	
	<div class="container">
	<div class="box3">
		<form action="delSellListForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530" height="551">
				<tr height="83.75">
					<td colspan="8"><h2>?????? ??????</h2></td>
				</tr>
				<tr height="30">
					<td>?????????</td>
					<td>??????</td>
					<td>??????</td>
					<td>????????? ID</td>
					<td>????????? ????????????</td>
					<td>?????? ??????</td>
				</tr>
				<%if(delList == null){ %>
					<tr>
						<td colspan="8"><h3>???????????? ????????? ????????????.</h3></td>
					</tr>
					<tr height="35">
						<td colspan="8"></td>
					</tr>
				<%} 
				else if(delList.size() <= 3){
					for(int i=0; i<delList.size(); i++){ 
						BuyDTO buyDTO = (BuyDTO)delList.get(i);
					%>
				<tr>
					<%ProductDTO dto = proDAO.getOneProduct(buyDTO.getPnum()); %>
					<td><%=dto.getPname() %></td>
					<td><%=buyDTO.getBbuyst() %>???</td>
					<td><%=buyDTO.getBprice() %>???</td>
					<% MemberDTO dto2 = memDAO.getMember(buyDTO.getMnum());%>
					<td><%=dto2.getMid() %></td>
					<td><%=dto2.getMtel() %></td>
					<td><%=sdf.format(buyDTO.getBreg()) %></td>
				</tr>
				<%}%>
				<tr height="30">
					<td align="right" colspan="8"><input type="submit" value="?????????"/></td>
				</tr>
				<%}else if(delList.size() > 3){
					for(int i=0; i<3; i++){ 
						BuyDTO buyDTO = (BuyDTO)delList.get(i);
					%>
				<tr>
					<%ProductDTO dto = proDAO.getOneProduct(buyDTO.getPnum()); %>
					<td><%=dto.getPname() %></td>
					<td><%=buyDTO.getBbuyst() %>???</td>
					<td><%=buyDTO.getBprice() %>???</td>
					<% MemberDTO dto2 = memDAO.getMember(buyDTO.getMnum());%>
					<td><%=dto2.getMid() %></td>
					<td><%=dto2.getMtel() %></td>
					<td><%=sdf.format(buyDTO.getBreg()) %></td>
				</tr>
				<%}%>
				<tr height="30">
					<td align="right" colspan="8"><input type="submit" value="?????????"/></td>
				</tr>
				<%} %>
			</table>
		</form>
	</div>
	<br/>
	<div class="box3">
		<form action="uploadListForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530" height="551">
				<tr height="60">
					<td  align="center" colspan="9" ><h2>?????? ??????</h2>
						<%if(sellDTO == null){ %>
							<input type="button" value="????????? ?????? ??????" onclick="window.location.href='sellRegistForm.jsp'"/>
						<%}else{ 
							if(sellDTO.getScon()==0){%>
								????????? ?????? ?????? ???
							<%}else{%>
								<input type="button" value="?????? ??????" onclick="window.location.href='regisForm.jsp'"/>
							<%}%>
						<%} %>
					</td>
				</tr>
				<tr height="30">
					<td>?????????</td>
					<td>?????????</td>
					<td>?????????</td>
					<td>????????????</td>
					<td>??????</td>
					<td>?????? ??????</td>
				</tr>
				<%if(proList == null){ %>
					<tr>
						<td colspan="9"><h3>????????? ????????? ????????????.</h3></td>
					</tr>
					<tr height="35">
						<td colspan="8"></td>
					</tr>
				<%}else if(proList.size() < 3){ 
					for(int i =0;i<proList.size();i++){
						ProductDTO proDTO = (ProductDTO)proList.get(i);%>
					<tr>
						<td><img width="50px" src="/furnitureone/oneimg/<%=proDTO.getPimg()%>"/></td>
						<td><%=proDTO.getPname() %></td>
						<td><%=proDTO.getPsellst() %>???</td>
						<td><%=proDTO.getPprice() * proDTO.getPsellst() %>???</td>
						<td><%=proDTO.getPstock() %>???</td>
						<td><%=sdf.format(proDTO.getPreg()) %></td>
					</tr>
					<%} %>
					<tr height="30">
						<td align="right" colspan="9"><input type="submit" value="?????????"/></td>
					</tr>
				<%}else if(proList.size() >= 3){ 
					for(int i =0;i<3;i++){
						ProductDTO proDTO = (ProductDTO)proList.get(i);%>
					<tr>
						<td><img width="100px" src="/furnitureone/oneimg/<%=proDTO.getPimg()%>"/></td>
						<td><%=proDTO.getPname() %></td>
						<td><%=proDTO.getPsellst() %>???</td>
						<td><%=proDTO.getPprice() * proDTO.getPsellst() %>???</td>
						<td><%=proDTO.getPstock() %>???</td>
						<td><%=sdf.format(proDTO.getPreg()) %></td>
					</tr>
					<%} %>
					<tr height="30">
						<td align="right" colspan="9"><input type="submit" value="?????????"/></td>
					</tr>
				<%} %>
			</table>
		</form>
		</div>
		</div>
		
		
		<div class="container">
		<div class="box3">
		<form action="hwanListForm.jsp" method="post" enctype="multipart/form-data">
			<table width="530"height="450">
				<tr height="60">
					<td  align="center" colspan="5"><h2>?????? ?????? ??????</h2>
					</td>
				</tr>
				<tr height="30">
					<td>?????????</td>
					<td>??????</td>
					<td>?????? ?????? ??????</td>
				</tr>
				<%if(hwanList == null){ %>
					<tr>
						<td colspan="5"><h3>?????? ????????? ????????? ????????????.</h3></td>
					</tr>
					<tr height="35">
						<td colspan="3"></td>
					</tr>
				<%}else if(hwanList.size() <= 3){
					for(int i =0;i<hwanList.size();i++){
						HwanDTO hwanDTO = (HwanDTO)hwanList.get(i);%>
					<tr>
						<%int pnum = proDAO.getPnum(hwanDTO.getBnum()); 
						System.out.println(pnum);
						ProductDTO proDTO = proDAO.getOneProduct(pnum);				
						%>
						<td><%=proDTO.getPname() %></td>
						<td><%=hwanDTO.getHreason() %></td>
						<td><%=sdf.format(hwanDTO.getHreg()) %></td>
					</tr>
					<%} %>
					<tr height="35">
						<td align="right" colspan="5"><input type="submit" value="?????????"/></td>
					</tr>
				<%}else if(hwanList.size() > 3){ 
					for(int i =0;i<3;i++){
						HwanDTO hwanDTO = (HwanDTO)hwanList.get(i);%>
					<tr>
						<%int pnum = proDAO.getPnum(hwanDTO.getBnum()); 
						ProductDTO proDTO = proDAO.getOneProduct(pnum);				
						%>
						<td><%=proDTO.getPname() %></td>
						<td><%=hwanDTO.getHreason() %></td>
						<td><%=sdf.format(hwanDTO.getHreg()) %></td>
					</tr>
					<%} %>
					<tr height="35">
						<td align="right" colspan="5"><input type="submit" value="?????????"/></td>
					</tr>
				<%} %>
			</table>
		</form>
		</div>
<%
	InquiryDAO inDAO = new InquiryDAO();
	InquiryDTO inDTO = new InquiryDTO();
	List inList = inDAO.getsellerInquiry(id);
	

%>		

		<div class="box3">
		<form action="myQuestionList.jsp" method="post">
			<table width="530"height="450">
				<tr height="60">
					<td colspan="3" >
						<h2>?????? ?????? ??????</h2>
					</td>
				</tr>
				<tr height="30">
					<td>ID</td>
					<td>??????</td>
					<td>????????????</td>
				</tr>
				<%if(inList.size() == 0){ %>
					<tr >
						<td colspan="3">
							<h3>??????????????? ????????????</h3>
						</td>
					</tr>
					<tr height="35">
						<td colspan="3"></td>
					</tr>
				<%}else if(inList.size() <= 3){ 
					for(int i = 0; i<inList.size(); i++){
						inDTO = (InquiryDTO)inList.get(i);
					%>
						<tr>
							<td><%=inDTO.getMid() %></td>
							<td><%=inDTO.getQuestion() %></td>
							<td><%=sdf.format(inDTO.getQreg()) %></td>
						</tr>
					<%}
				%>
					<tr height="35">
						<td colspan="3" align="right">
							<input type="submit" value="?????????"/>
						</td>
					</tr>
				<%}else if(inList.size() >= 3){ 
					for(int i = 0; i<3; i++){
						inDTO = (InquiryDTO)inList.get(i);
					%>
						<tr>
							<td><%=inDTO.getMid() %></td>
							<td><%=inDTO.getQuestion() %></td>
							<td><%=inDTO.getQreg() %></td>
						</tr>
					<%}
				%>
					<tr height="35">
						<td colspan="3" align="right">
							<input type="submit" value="?????????"/>
						</td>
					</tr>
				<%} %>
			</table>
		</form>
		</div>
		</div>
		
		
	<div class="box4">
	<footer1>
       <div class="inner">
          <div class="footer-container">
            <h2 align="left">Furniture One</h2>
			<a>???????????? ?????? ????????? ???????????????????????? ??????????????? ????????? ??????????????? ???????????????</a> 
			<a>???????????????F.O ??? ???????????? : ????????? ??? ?????? : ??????????????? ????????? ????????? 94, 7???(????????????, ??????????????????)</a> 
			<a>????????????????????????187-85-01021?????????????????????????????? : ?????????????????????????????????</a>  
          </div>
       </div>
    </footer>
    </div>
	<%} %>
</body>
</html>