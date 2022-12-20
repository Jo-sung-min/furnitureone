<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>logout.jsp</title>
</head>
<%
	session.invalidate();
	//쿠키 있으면 쿠키도 삭제
	Cookie[] cs =  request.getCookies();
	if(cs != null) { //쿠키가 있으면 실행
		for(Cookie c : cs) {
			if(c.getName().equals("autoId") || c.getName().equals("autoPw") || c.getName().equals("autoCh")) {
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
	}


	response.sendRedirect("premainForm.jsp");
	
%>
<body>

</body>
</html>