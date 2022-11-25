<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="big3" value="${user.squat+user.benchpress+user.deadlift}"/>
<c:choose>
<c:when test="${big3<200 }">
	<img src="${path}/resources/img/anchovy.png">
</c:when>
<c:when test="${big3<=200 && big3<300 }">
	<img src="${path}/resources/img/anchovy2.png">
</c:when>
<c:when test="${300<=big3 && big3<400 }">
	<img src="${path}/resources/img/anchovy3.png">
</c:when>
<c:when test="${400<=big3 && big3<500 }">
	<img src="${path}/resources/img/anchovy4.png">
</c:when>
<c:when test="${500<=big3}">
	<img src="${path}/resources/img/anchovy5.png">
</c:when>
</c:choose>
<div class="admin">
	<p>
		<span>관리자</span>
		<span>${user.user_name }님</span>
	</p>
	<p><span>트레이너</span><span>${stats.trainer } 명</span></p>
	<p><span>일반회원</span><span>${stats.user } 명</span></p>
	<p><span>상품구매</span><span>${stats.product } 명</span></p>
	<p><span>PT구매</span><span>${stats.pt } 명</span></p>
</div>
<div class="info-nav">
	<a href="<c:url value='/myPage'/>">마이페이지</a>
	<a href="<c:url value='/login/logout'/>">로그아웃</a>
</div>