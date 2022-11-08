<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>철좀들어-Big3 랭킹</title>
	<link rel="stylesheet" href="${path}/resources/css/bigThree.css">
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
	<h1>BIG THREE RANKING</h1>
	<table>
		<tr>
			<th>RANK</th>
			<th>NAME</th>
			<th>BIG THREE</th>
			<th>SQUAT</th>
			<th>BENCHPRESS</th>
			<th>DEADLIFT</th>
		</tr>
	<c:forEach items="${list}" var="rank">
		<tr ${rank.user_email==user.user_email? 'class="currentUser"':''}>
			<td>${rank.ranking}</td>
			<td>${rank.user_name}</td>
			<td>${rank.big3}</td>
			<td>${rank.squat}</td>
			<td>${rank.benchpress}</td>
			<td>${rank.deadlift}</td>
		</tr>
	</c:forEach>
	</table>
</div>
<script>

</script>
</body>
</html>