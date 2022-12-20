<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세검색 처리페이지</title>
</head>
<%
	request.setCharacterEncoding("UTF-8");

	// 상품 타입 검색할때 받을 데이터
	String productType = request.getParameter("productType");

	//상품명 검색할때 받을 데이터
	String productSearch = request.getParameter("productSearch");
	
	//상품색상 검색할때 받을 데이터
	String color1 = request.getParameter("color1");

	//상품가격 검색할때 받을 데이터
	int fPrice = Integer.parseInt(request.getParameter("fPrice"));
	int ePrice = Integer.parseInt(request.getParameter("ePrice"));
	
	
	
%>




<body>




</body>
</html>