<%@page import="web.team.one.MemberDAO"%>
<%@page import="web.team.one.ZzimDAO"%>
<%@page import="web.team.one.ProductDAO"%>
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

	String Mid = (String)session.getAttribute("memId");
	//찜 기능을 구현할 페이지
	int Pnum=Integer.parseInt(request.getParameter("Pnum"));
	String zzimCon="0";
	if(Mid!=null){
	//물건의 고유번호 가져와서 찜을 1로 바꾸기
	
	//찜을 눌렀을때 0이면 1로 1이면 0으로 바꿔주기
	MemberDAO dao = new MemberDAO();
	int Mnum= dao.getMnum(Mid);
	
	ZzimDAO dao1 = new ZzimDAO();
	//찜 안되어있을때
	//찜 되어 있는거 세어주는 메서드
	int Fcount = dao1.fzzimCount(Pnum, Mnum);
	int count = dao1.zzimCount(Pnum, Mnum);
	
	
 	//찜한 이력이 없으면	
 	
	if(Fcount==0){
		
		zzimCon="1";
		dao1.addPpick(Pnum);
		dao1.FstZzim(Pnum, Mnum);//찜!!%> 
			
			<script >
				alert("찜 하셨습니다.");
				window.location.href="detailForm.jsp?Pnum="+<%=Pnum%>+"&zzimCon="+<%=zzimCon%>;
			</script>
			
	<%}else if(Fcount==1){ 
		
			if (count==0) {
				//찜해제 일때 찜 으로 바꿔주기
				zzimCon="1";
				dao1.addPpick(Pnum);
				dao1.ScdZzim(Pnum, Mnum);//찜!!%>	
				
					<script >
						alert("찜 하셨습니다.");
						window.location.href="detailForm.jsp?Pnum="+<%=Pnum%>+"&zzimCon="+<%=zzimCon%>; 
					</script>
			<%}else if(count==1){
				//찜 일때 찜 해제 해주기
				zzimCon="0";
				dao1.downPpick(Pnum);
				dao1.NoZzim(Pnum, Mnum);//찜해제!!%>	
				
					<script >
						alert("찜 해제 하셨습니다.");
						window.location.href="detailForm.jsp?Pnum="+<%=Pnum%>+"&zzimCon="+<%=zzimCon%>;
					</script>
				
			<%}
		}
	}else{%>
			<script >
				alert("로그인 후 이용해 주세요.");
				window.location.href="detailForm.jsp?Pnum="+<%=Pnum%>+"&zzimCon="+<%=zzimCon%>;
			</script>
		
<%	}
	%>   
	
	
	
	
	

	

<body>

</body>
</html>