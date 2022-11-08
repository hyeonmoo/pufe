<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Info</title>
</head>
<body>
<img src="${path }/resources/img/anchovy.png">
<p><span id="user-name">${user.user_name }님</span> <span id="user-type">일반회원</span></p>
<p>기간권 3개월 + PT 20회</p>
<p>트레이너1 강사님</p>
<p>2022/06/23~2022/09/22</p>
<p>22일 | 5회 남음</p>
<div class="info-nav">
	<a href="#">마이페이지</a>
	<a href="<c:url value='login/logout'/>">로그아웃</a>
</div>
</body>
</html>