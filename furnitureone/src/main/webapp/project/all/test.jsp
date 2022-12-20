<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<style>
		.divFrame {
			margin: 0 auto;
			width: 350px; 
			height: 350px;
			background-color: white;
		}
	</style>
	
</head>
<body>
	<div class="divFrame">
		<div class="imgDiv">
			<img src="/furnitureone/oneimg/수납장2.png" width="200" /> <br />
			<button id="btnWhite">White</button>
			<button id="btnRed">Red</button>
			<button id="btnGreen">Green</button>
			<button id="btnBlue">Blue</button>
		</div>
	</div>

	<script>
	$(document).ready(function(){
		
		// white버튼에 이벤트 달기 
		$("#btnWhite").click(function(){
			$(".divFrame").css("background-color","white"); 
		}); 
		
		// red버튼에 이벤트 등록
		$("#btnRed").click(function(){
			$(".divFrame").css("background-color","IndianRed"); 
		}); 
		// green버튼에 이벤트 등록
		$("#btnGreen").click(function(){
			$(".divFrame").css("background-color","Tan"); 
		}); 
		// blue버튼에 이벤트 등록
		$("#btnBlue").click(function(){
			$(".divFrame").css("background-color","LightBlue"); 
		}); 
		
		
		
	});
		
	
	
	
	</script>
</body>
</html>