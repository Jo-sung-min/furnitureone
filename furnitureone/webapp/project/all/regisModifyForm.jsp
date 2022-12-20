<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="web.team.one.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css"/>

	
	
</head>



<%
	request.setCharacterEncoding("utf-8");
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	String id = (String)session.getAttribute("memId");
	String pageNum = request.getParameter("pageNum");
%>
<jsp:useBean id="dto" class="web.team.one.ProductDTO"/>


	<script>
		//유효성 검사
		function checkField() {
			let inputs = document.regisForm;
			if(!inputs.pname.value) {
				alert("상품명을 입력해주세요.")
				return false;
			}
			if(!inputs.pprice.value) {
				alert("가격를 입력해주세요.")
				return false;
			}
			if(!inputs.pstock.value) {
				alert("개수를 입력해주세요.")
				return false;
			}
			if(!inputs.pcontent.value) {
				alert("설명란을 입력해주세요.")
				return false;
			}
		}
	</script>
<%
	

	ProductDAO dao = new ProductDAO();
	dto = dao.getOneProduct(pnum);
%>
<body>
	<%if(id == null){ %>
		<script>
			alert('로그인 후 이용하세요.');
			history.window.location.href = "loginForm.jsp";
		</script>
	<%}else{ %>
		<header>
	       <div class="inner">
	          	<div class="header-container">
           	 	 	<div class="header-logo" onclick="window.location='mainForm.jsp'">≡ 메인</div>
          	  	 	<h1 align="center" onclick="window.location='premainForm.jsp'">Furniture One</h1>            
          	  	 	<div class="header-text">
          	  	 		<button onclick="window.location='logout.jsp'"> 로그아웃 </button>
          	  	 	</div>  
          		</div>   
      		</div>
   		</header>
	
	
	<br/><br/><br/><br/><br/> 
	<div class="box3">
	<form action="regisModifyPro.jsp?pnum=<%=pnum %>&pageNum=<%=pageNum %>" align="center" method="post"  name="regisForm" onsubmit="return checkField()" enctype="multipart/form-data">
		<table>
			<tr height="60">
				<td colspan="2" align="center"><h1>상품 정보 변경 양식<h1/></td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="pname" value="<%= dto.getPname()%>"/></td>
			</tr>
			<tr>
				<td>상품 사진</td>
				<td>
					<%if(dto.getPimg() != null){ %>
						<img width="100px" src="/furnitureone/oneimg/<%= dto.getPimg()%>"/> <br/>
					<%}else{ %>
						<img width="100px" src="/furnitureone/oneimg/di.jpg"/>  <br/>
					<%} %>
					<input type="file" name="pimg" />
				</td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="number" name="pprice" value="<%= dto.getPprice()%>"/></td>
			</tr>
			<tr>
				<td>개수</td>
				<td><input type="number" name="pstock" value="<%= dto.getPstock()%>"/></td>
			</tr>
			<tr>
				<td>상품 종류</td>
				<td><%= dto.getPtype()%></td>
			</tr>
			<tr>
				<td>색상</td>
				<td><%= dto.getPcolor()%></td>
			</tr>
			<tr>
				<td>상세 설명</td>
				<td><textarea rows="15" cols="50" name="pcontent"><%= dto.getPcontent()%></textarea></td>
			</tr>
			<tr>
				<td>비밀번호 입력</td>
				<td><input type="password" name="mpw"/></td>
			</tr>
			<tr height="30">
				<td colspan="2" align="right">
					<input type="submit" value="변경"/>
					<input type="button" value="취소" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
	</form>	
	</div>
	<br/><br/><br/><br/><br/>
	<div class="box4">
	<footer>
       <div class="inner">
          <div class="footer-container">
            <h2 align="left">Furniture One</h2>
			<a>개인정보 처리 방침． 서비스이용약관． 위치서비스 약관． 회사소개． 채용정보．</a> 
			<a>상호명：㈜F.O ｜ 대표이사 : 김대헌 ｜ 주소 : 서울특별시 마포구 신촌로 94, 7층(노고산동, 그랜드플라자)</a> 
			<a>사업자등록번호：187-85-01021｜개인정보보호책임자 : 더조은｜사업자정보확인</a>  
          </div>
       </div>
    </footer>
	</div>
	<%} %>
</body>
</html>