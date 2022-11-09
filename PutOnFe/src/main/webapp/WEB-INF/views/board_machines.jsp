
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.net.URLDecoder"%>
<c:set var="path" value="${pageContext.request.contextPath}" />



<!DOCTYPE html>
<html lang="en">

<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="${path }/resources/css/navMenu.css">

<style>
.container {
	text-align: center;
	margin-top: 20px;
	display: grid;
	margin-left: 10%;
	margin-right: 10%;
	grid-template-columns: 1fr 1fr 1fr; 
}

box {
	margin: 50px;
}

.product_img {
	position: relative;
	width: 200px;
	height: 200px;
	
}

.product_img>img {
	width: 200px;
	height: 200px;
	z-index: 5;
	border: 3px solid #121212;
}

li {
	list-style: none;
}

.product_con>li {
	font-size: 80%;
}
.btn_toggle0{
width: 200px;
	height: 200px;
	margin:auto;
	margin-bottom:50px;
	margin-top:100px;
}
.caption {
	position: absolute;
	box-sizing: border-box;
	top: 0px;
	width: 100%;
	height: 100%;
	padding: 15%;
	line-height: 150%;
	background: rgba(0, 0, 0, 0.6);
	color: white;
	text-align: center;
	display: none;
	z-index:1;
	
}
.product_tit{

font-size: 120%;
}
.product_con{
margin-top:10px;
}

button {
	background-color: #121212;
	border-radius: 20%;
	width: 70px;
	cursor: pointer;
	margin: 5px;
}

button>p {
	color: white;
}

.title {
	margin-top: 100px;
	font-size: 30px;
	text-align: center;
}
</style>

</head>

<body>
	<%@ include file="navMenu.jsp"%>
	<div class="title">시설</div>
	<div class="container">
		<c:forEach items="${machineList}" var="machine">

			<box class="btn_toggle0">
			<div class="detail">
				<button>
					<p>세부사항</p>
				</button>
			</div>

			
				<li class="product_img"><img src="${path }/resources/img/anchovy.png">
					<div class="caption" id="Toggle">${machine.mch_detail}</div></li>
				<li class="product_tit"><br>${machine.mch_name}</li>
				<ul class="product_con">
					${machine.mch_info}
					<br>

				</ul>

			

			</box>


		</c:forEach>

	</div>

	<script>
		$('.btn_toggle0').click(function() {
			$(this).find('#Toggle').toggle();
		});
	</script>
</body>

</html>