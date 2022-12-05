<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>철좀들어-추천정보</title>
    <link rel="stylesheet" href="${path }/resources/css/machineList.css">
</head>
<body>
<%@ include file="navMenu.jsp" %> 

<div class="container">
	<nav>
		<a href="<c:url value='/menu2'/>">시설관리</a>
		<a href="<c:url value='/correction'/>">회원권 관리</a>
	</nav>
	<h1>시설 관리</h1>
	<table>
		<tr>
			<th style="width: 10%;">번호</th>
			<th style="width: 40%;">기구 이름</th> 
			<th style="width: 20%;">입고날짜</th>
		</tr>
		<c:forEach var="board" items="${machinelist }">
			<tr>
				<td>${board.mch_num }</td>
				<td><a href="<c:url value='/facility/read${ph.sc.queryString }&mch_num=${board.mch_num }'/>" style="color: black">${board.mch_name }</a></td>
				<td>${board.mch_date }</td>
			</tr>
		</c:forEach>
	</table>
	<div class="tools">
		<button onclick="location.href='<c:url value="/facility/write?mode=write"/>'">기구 등록</button>
		<div class="searchBox">
			<form action="<c:url value="/menu2"/>" method="get">
				<select name="option">
					<option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected":""}>번호+이름</option>
					<option value="T" ${ph.sc.option=='T'? "selected":""}>번호</option>
					<option value="C" ${ph.sc.option=='C'? "selected":""}>이름</option>
				</select>
				<input type="text" name="keyword" value="${ph.sc.keyword }" placeholder="검색어 입력">
				<input type="submit" value="검색">
			</form>
		</div>
		<ul class="pagination">
			<li><c:if test="${ph.showPrev }">
				<a href="<c:url value='/menu2${ph.sc.getQueryString(ph.beginPage-1) }' />">&laquo;</a>
			</c:if></li>
			<li><c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
				<a href="<c:url value='/menu2${ph.sc.getQueryString(i) }'/>">${i }</a>
			</c:forEach></li>
			<li><c:if test="${ph.showNext }">
				<a href="<c:url value='/menu2${ph.sc.getQueryString(ph.endPage+1) }'/>">&raquo;</a>
			</c:if></li>
		</ul>
	</div>	
</div>
<script>
	if("${msg}"!="") alert("${msg}");
</script>
</body>
</html>