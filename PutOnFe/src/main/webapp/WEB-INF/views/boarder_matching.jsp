<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>철좀들어-추천정보</title>
    <link rel="stylesheet" href="${path }/resources/css/boarder_matching.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
	<nav id="nav">
		<h4>기간 :</h4>
		<button id="button">전체</button>
		<button id="button2">주말</button>
		<button id="bt3">이번주</button>
		<button>다음주</button>
	</nav>
	<table>
		<thead>
		<tr>
			<th>DATE</th>
			<th>TIME</th>
			<th>PART</th>
			<th>NAME</th>
			<th>STATUS</th>
		</tr>
		</thead>
	</table>
</div>
<script>
let loginuser = "${loginman}";
if(loginuser=="kang0825@naver.com"){
	$("#button").show();
} else{
	$("#button2").toggle();
}
$("#bt3").click(function(){
	$(this).parent().find("#button").toggle();
});
</script>
</body>
</html>