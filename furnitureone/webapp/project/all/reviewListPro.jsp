<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.MemberDTO"%>
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
		
		
		ReviewDTO review  = new ReviewDTO(); // 담을 바구니 생성 
		
		String path = request.getRealPath("oneimg");
		System.out.println("reviewimg:"+path);
		int max = 1024*1024*5;
		String enc ="UTF-8";
		DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
		MultipartRequest mr = new MultipartRequest(request, path,max, enc, dp);
		
		int pnum = Integer.parseInt(mr.getParameter("Pnum"));
		int mnum = Integer.parseInt(mr.getParameter("mnum"));
		
		
		MemberDTO member  = new MemberDTO();
		MemberDAO dao  = new MemberDAO();
		member =dao.getMember(mnum);		
		
		
		
		review.setPnum(pnum);
		review.setMnum(mnum);
		review.setMid(member.getMid());
		if(mr.getFilesystemName("rimg") != null){ // 파일 업로드를 했다면 
				review.setRimg(mr.getFilesystemName("rimg"));  // 저장된 파일명으로 dto의 img 변수 체워주기 
			}else {	// 파일 업로드를 안했다면 
				review.setRimg("default_image.png"); // save폴더에 있는 default 이미지 파일명으로 체우기 
			}
		review.setRcontent(mr.getParameter("rcontent"));
		review.setRgrade(mr.getParameter("rgrade"));// 평점
		
		
		//위에 데이터 받아서 넣어주기
		
		ReviewDAO dao1 = new ReviewDAO();
		dao1.insertReview(review);

		response.sendRedirect("mainForm.jsp");
%>


<body>

</body>
</html>