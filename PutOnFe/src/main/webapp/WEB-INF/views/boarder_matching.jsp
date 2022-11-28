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
	<div class="myPosts">
		
	</div>
	<div class="myRequests">
	
	</div>
	<div>
		<nav class="part">
			<a>전체</a>
			<a>가슴</a>
			<a>등</a>
			<a>하체</a>
		</nav>
		<nav class="date">
			<a>전체</a>
			<a>오늘+내일</a>
			<a>이번 주</a>
			<a>이번 주 말</a>
			<a>다음 주</a>
			<a>다음 주 말</a>
			<a>날짜 선택</a>
		</nav>
		<nav class="time">
			<a>전체</a>
			<a>09:00~12:00</a>
			<a>12:00~18:00</a>
			<a>18:00~22:30</a>
			<a>시간대 선택</a>
		</nav>
	</div>
</div>
</body>
</html>