<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<img src="${path}/resources/img/anchovy.png">
<p>
	<span id="user-name">${user.user_name }님</span>
	<span id="user-type">트레이너</span>
</p>
<p>헬창</p>
<p>등록된 회원수: 00명</p>
<p>오늘 일정표</p>
<p>14:00 강현무</p>
<div class="info-nav">
	<a href="<c:url value='/myPage'/>">마이페이지</a>
	<a href="<c:url value='/login/logout'/>">로그아웃</a>
</div>