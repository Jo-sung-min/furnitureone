<%@page import="web.team.one.BuyDAO"%>
<%@page import="web.team.one.ProductDAO"%>
<%@page import="web.team.one.ProductDTO"%>
<%@page import="web.team.one.MemberDTO"%>
<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.ReviewDAO"%>
<%@page import="web.team.one.ReviewDTO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
		//이페이지로 넘어올때 가져오는 상품의 고유번호 이미지도 가져오니까mr 써야함
		request.setCharacterEncoding("UTF-8");
		
		//mnum pnum을 받아서 넘어와야함
		String Mid =(String)session.getAttribute("memId");
		MemberDAO dao1 = new MemberDAO(); 
		MemberDTO member = new MemberDTO(); 
		
		int Mnum =dao1.getMnum(Mid);
		member = dao1.getMember(Mnum);
		ReviewDTO review  = new ReviewDTO(); // 담을 바구니 생성 
		ProductDAO dao2  = new ProductDAO(); // 담을 바구니 생성 
		
		
		
		String path = request.getRealPath("oneimg");
		System.out.println("reviewimg:"+path);
		int max = 1024*1024*5;
		String enc ="UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path,max, enc, dp);
		
		String rcontent =mr.getParameter("rcontent");
		if(rcontent!=null && !rcontent.equals("")){
		
		int Pnum =Integer.parseInt(mr.getParameter("Pnum"));
		int Bnum =Integer.parseInt(mr.getParameter("Bnum"));
		
		
		
		review.setPnum(Pnum);
		review.setMnum(Mnum);
		if(mr.getFilesystemName("rimg") != null){ // 파일 업로드를 했다면 
				review.setRimg(mr.getFilesystemName("rimg"));  // 저장된 파일명으로 dto의 img 변수 체워주기 
				System.out.println(mr.getFilesystemName("rimg"));
			}else {	// 파일 업로드를 안했다면 
				review.setRimg("default.png"); // save폴더에 있는 default 이미지 파일명으로 체우기 
			}
		review.setRcontent(mr.getParameter("rcontent"));
		review.setRgrade(mr.getParameter("rgrade"));// 평점
		review.setMid(member.getMid());// 작성자 이름 넣어주기
		String re=mr.getParameter("rgrade");
		
		//위에 데이터 받아서 넣어주기
		
		ReviewDAO dao = new ReviewDAO();
		dao.insertReview(review);
		
		BuyDAO buydao = new BuyDAO();
		buydao.bconUpdate(Bnum);
		
		double ave = 0.0;
		int countReview = dao.reviewCount(Pnum);
		if(countReview>0){
			ave = dao.getAvePgrade(Pnum, countReview);
		}
		
		dao2.updatePgrade(ave, Pnum);	
		
		
		
		
		
		response.sendRedirect("mypageBuyerForm.jsp");
		
		}else{
%>

		<script >
			alert("리뷰 내용을 입력해 주세요");
			history.go(-1);
		</script>

		<%} %>

<body>

</body>
</html>