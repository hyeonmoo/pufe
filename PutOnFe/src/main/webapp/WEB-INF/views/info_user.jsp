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
	<p><fmt:formatDate value="${userview.buy_date}" pattern="yy/MM/dd" type="date"/>~
		<fmt:formatDate value="${userview.end_date}" pattern="yy/MM/dd" type="date"/></p>
	<p>${userview.remain}일 | PT ${userview.days-userview.pt_times}회 남음</p>
</div>
<div class="info-nav">
	<a href="<c:url value='/myPage'/>">마이페이지</a>
	<a href="<c:url value='/login/logout'/>">로그아웃</a>
</div>