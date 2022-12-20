<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.AddressDTO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.AddressDAO"%>
<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.BuyDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");
	//페이지 넘어오는 회원, 상품 번호 받아주기
	int Pnum =Integer.parseInt(request.getParameter("Pnum"));
	int Mnum =Integer.parseInt(request.getParameter("Mnum"));
	int Snum =Integer.parseInt(request.getParameter("Snum"));
	String baddr = null;
	String addr1 = null;
	if(request.getParameter("baddr") != null){
		baddr = request.getParameter("baddr").trim();
	}
	if(request.getParameter("addr1") != null){
		addr1 = request.getParameter("addr1").trim();
	}
	
	if(baddr.equals("newAddr") && addr1.equals("")){
	
	%>
	
	<script >
		alert("주소를 입력해주세요");
		history.go(-1);
	</script>
		
	<%}else{%>
	
	
	<%
	//여기서 구매할 때 등록한 값 addr 에 넣어주기
	//주소 등록으로 왔을때 처리해주고 다시 buyForm 으로 보내주기
	//구매 완료 페이지 구매등록하고 주소 등록 해주고
	BuyDTO buy =new BuyDTO();
	BuyDAO dao =new BuyDAO();
	ProductDAO dao3 =new ProductDAO();
	ProductDTO product =dao3.getOneProduct(Pnum);
	
	
	int buyst= Integer.parseInt(request.getParameter("bbuyst"));
	//새로운 주소 입력했을때 받아오기위한처리
	
	AddressDAO dao2 = new AddressDAO(); 
	AddressDTO address = new AddressDTO(); 
	int addrCount = dao2.addressCount(Mnum); //주소가 3개 이상이면 등록 못하게
	System.out.println(addrCount);
	
	if(addrCount<3){
		
		if(request.getParameter("addr1")!=null&&request.getParameter("addr1")!=""){
			address.setMnum(Mnum);
			address.setMaddr(request.getParameter("addr1"));
			
			
			MemberDAO dao1 = new MemberDAO();
			MemberDTO member=dao1.getMember(Mnum);
			member.setMnum(Mnum);
			if(product.getPstock() > 0){
				dao2.insertAddress(member, address);
			}
		}
	}	
	
	//재고 구매수 만큼 내려주기
	int remainStock= dao3.downStock(Pnum, buyst);
	int sellStock =  product.getPsellst();

	sellStock= product.getPsellst()+Integer.parseInt(request.getParameter("bbuyst"));
	
	System.out.println(remainStock);
	
	if(remainStock>=0){	%> 
	
		
	<%
	//구매 테이블에 등록해주기 배송상태를 배송중(1)으로 바꿔주기
	//넘어오는 회원, 상품 번호 받아주기
	buy.setMnum(Mnum);
	buy.setPnum(Pnum);
	buy.setSnum(Snum);
	buy.setBcon(0);
	buy.setBdelcon(0);
	buy.setBaddr(request.getParameter("baddr"));
	buy.setBbuyst(Integer.parseInt(request.getParameter("bbuyst")));
	buy.setBpaytype(request.getParameter("bpaytype"));
	buy.setBprice(Integer.parseInt(request.getParameter("pprice")));
	buy.setPname(product.getPname());
	
	if(remainStock>=0){
		dao3.updateStock(Pnum, remainStock);
		dao3.updateSellStock(Pnum, sellStock); 
	}else{	
		buy.setBbuyst(0);
		System.out.println("구매량");
		%>
	<%}
	
	//구매 상태 바꿔주기
	dao.insertBuy(buy);	%>
	
	<script>
	alert("구매가 완료 되었습니다.");
	window.location="detailForm.jsp?Pnum="+<%=Pnum%>+"&Mnum?"+<%=Mnum%>;
	</script>

		<%}else{%>
		<script>
			alert("남아있는 수량이 없습니다.");
			history.go(-1);
		</script>
		<%} %>
	<%} %>



<body>

</body>
</html>