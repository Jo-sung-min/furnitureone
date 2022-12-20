<%@page import="web.team.one.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cofirmId.jsp</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	if(session.getAttribute("memId") != null) { //로그인시 -> 재로그인 불가능 %>
		<script>
			alert("이미 로그인된 상태입니다.");
			window.location.href = "premainlogin.jsp";
		</script>
		
<%	}else { //비로그인시 -> 로그인가능 %>
<%	
	//open(url...) : url = confirmId.jsp?mid=값
	String mid = request.getParameter("mid");
	//DB 연결해서 사용자가 작성한 id값이 DB테이블에 존재하는지 검사
	MemberDAO dao = new MemberDAO();
	boolean result =  dao.confirmId(mid); //true 이미 존재함, false 존재x -> 사용가능
%>
<body>
<%
	if(result) { //true -> 이미 존재 -> 사용 불가 %>
	<table>
		<tr>
			<td><%= mid %>은/는 이미 사용중인 아이디입니다.</td>
		</tr>
	</table>
	<form action="confirmId.jsp" method="post">
		<table>
			<tr>
				<td> 다른 아이디를 입력하세요. <br />
					<input type="text" name="mid" />
					<input type="submit" value="ID 중복확인" />
				</td>
			</tr>
		</table>
	</form>
<%	}else { //false -> 존재 x -> 사용 가능 %>
	<br />
	<table>
		<tr>
			<td>입력하신 <%=mid %>은/는 사용할 수 있습니다.<br />
				<input type="button" value="닫기" onclick="setId()" />
			</td>
				
		</tr>
	</table>
<%	} %>
	
	<script>
		function setId() {
			//팝업을 열어준 원래 페이지의 mid input태그의 value를
			//최종 사용할 id로 변경
			opener.document.inputForm.mid.value = "<%= mid %>";
			//현재 팝업 닫기
			self.close();
		}
	</script>
</body>
<%	} %>
</html>