<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="big3" value="${userview.big3}"/>
<c:choose>
<c:when test="${big3<200 }">
	<img src="${path}/resources/img/anchovy.png">
</c:when>
<c:when test="${200<=big3 && big3<300 }">
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
<div class="user">
	<p>
		<span>일반회원</span>
		<span>${userview.user_name }님</span>
	</p>
	<p>${userview.prod_name}</p>
	<p>
	<c:if test="${not empty userview.trainer}">${userview.trainer_name} 트레이너</c:if>
	<c:if test="${empty userview.trainer}">--</c:if>
	</p>
	<fmt:parseDate var="buyDate" value="${userview.buy_date }" pattern="yyyy-MM-dd" type="date"/>
	<fmt:parseDate var="endDate" value="${userview.end_date }" pattern="yyyy-MM-dd" type="date"/>
	<p>
		<fmt:formatDate value="${buyDate}" pattern="yy/MM/dd ~" type="date"/>
		<fmt:formatDate value="${endDate}" pattern="yy/MM/dd" type="date"/>
	</p>
	<p>${userview.remain}일 | 남은PT ${userview.days-userview.pt_times}회</p>
	<c:if test="${empty myMatch}">
		<p>약속된 매칭 없음</p>
	</c:if>
	<c:if test="${not empty myMatch}">
	<fmt:parseDate var="mchDate" value="${myMatch.date }" pattern="yyyy-MM-dd" type="date"/>
	<fmt:parseDate var="mchTime" value="${myMatch.time }" pattern="HH:mm" type="time"/>
		<p><fmt:formatDate value="${mchDate}" pattern="MM/dd" type="date"/> 
			| <fmt:formatDate value="${mchTime}" pattern="HH:mm" type="time"/> 
			| <font>${myMatch.part=="chest"?"가슴":myMatch.part=="back"?"등":"하체"}</font> 
			| <font>${myMatch.name}</font>
		</p>
	</c:if>
</div>
<div class="info-nav">
	<a href="<c:url value='/myPage'/>">마이페이지</a>
	<a href="<c:url value='/login/logout'/>">로그아웃</a>
</div>