<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="trainer">
	<p>
		<span>트레이너</span>
		<span>${user.user_name }님</span>
	</p>
	<p><span>PT회원</span><span>${stats.trainer } 명</span></p>
	<p><span>오늘일정</span><span><fmt:formatDate value="${today}" pattern="MM월 dd일" type="date"/></span></p>
	<!--<c:forEach var="ptlist" begin="9" end="21" items="${ptlist}" varStatus="time">
		<p><span>${time.index}:00</span><span>${stats.product } 님</span></p>
	</c:forEach>-->
	<p><span>09:00</span><span>강일반 님</span></p>
	<p><span>10:00</span><span>강일반 님</span></p>
	<p><span>11:00</span><span>강일반 님</span></p>
	<p><span>12:00</span><span>강일반 님</span></p>
	<p><span>13:00</span><span>강일반 님</span></p>
	<p><span>14:00</span><span>강일반 님</span></p>
	<p><span>15:00</span><span>강일반 님</span></p>
	<p><span>16:00</span><span>강일반 님</span></p>
	<p><span>17:00</span><span>강일반 님</span></p>
	<p><span>18:00</span><span>강일반 님</span></p>
	<p><span>19:00</span><span>강일반 님</span></p>
	<p><span>20:00</span><span>강일반 님</span></p>
	<p><span>21:00</span><span>강일반 님</span></p>
</div>
<div class="info-nav">
	<a href="<c:url value='/myPage'/>">마이페이지</a>
	<a href="<c:url value='/login/logout'/>">로그아웃</a>
</div>