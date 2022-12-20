<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	String mid = request.getParameter("mid").trim();
	String mpw = request.getParameter("mpw").trim();
	String auto = request.getParameter("auto");
	
	//쿠키가 있을때
	Cookie[] coos = request.getCookies();
	if(coos != null) {
		for(Cookie c : coos) {
			if(c.getName().equals("autoId")) mid = c.getValue(); 
			if(c.getName().equals("autoPw")) mpw = c.getValue(); 
			if(c.getName().equals("autoCh")) auto = c.getValue(); 
		}
	}
	 
	//DB에 id, pw 전달해서 DB상 데이터와 일치하는지 결과를 받아와야함
	MemberDAO dao = new MemberDAO();
	int result = dao.idPwCheck(mid, mpw);		//result : 1(ok), 0(비번틀림), -1(아이디없다)
	System.out.println("loginPro result : "+result);
	int mcon = dao.getMcon(mid);
	if(mcon == 2){%>
		<script>
			alert('장기 휴면계정입니다. 고객센터로 문의하세요');
			history.go(-1);
		</script>
	<%}else if(mcon == 1) {%>	
		<script>
			alert('휴면계정입니다. 이용하시려면 휴면상태를 해제해주세요');
			window.location="hew.jsp?mid=<%=mid%>";
		</script>
	<%}else{
		if(result == -1) { %>
			<script>
				alert("회원정보가 없습니다.")
				history.go(-1);
			</script>
	<%	}else if(result == 0) { %>
			<script>
				alert("비밀번호가 틀렸습니다. 다시입력해주세요.")
				history.go(-1);
			</script>
	<%	}else { 
			//자동로그인이면 쿠키도 생성
				if(auto != null) {
					Cookie c1 = new Cookie("autoId",mid);
					Cookie c2 = new Cookie("autoPw",mpw);
					Cookie c3 = new Cookie("autoCh",auto);
					System.out.println("됏냐");
					
					c1.setMaxAge(60*60*24); //24시간
					c2.setMaxAge(60*60*24);
					c3.setMaxAge(60*60*24);
					
					response.addCookie(c1);
					response.addCookie(c2);
					response.addCookie(c3);
				}
			//로그인 처리
			session.setAttribute("memId", mid);
	%>
			<script>
				alert("로그인 성공.")
				window.location="premainForm.jsp";
			</script>
	<%	} 
	}%>
	

<body>

</body>
</html>