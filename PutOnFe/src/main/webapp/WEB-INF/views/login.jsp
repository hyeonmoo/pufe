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
    <title>로그인</title>
    <link rel="stylesheet" href="${path }/resources/css/login.css">
</head>
<body>
    <div id="container">
        <a href="<c:url value='/'/>"><img src="${path }/resources/img/logo_main.png" alt="logo" ></a>
        <form action="<c:url value='/login'/>" method="post">
            <h1>로그인</h1>
            <input type="email" name="email" id="email" placeholder="이메일" value="${empty param.email?cookie.email.value:param.email }" required>
            <input type="password" name="pwd" id="pw" placeholder="비밀번호" required>
            <label for="remEmail" id="label_check">
                <input type="checkbox" name="remEmail" id="remEmail" ${empty cookie.email.value?"":"checked" }>
                <span id="checkbox_icon"></span>
                이메일 저장
            </label>
            <button type="submit" id="loginSubmit">로그인</button>
            <div id="find">
                <a href="<c:url value='/login/findEmail'/>">이메일 찾기</a> |
                <a href="<c:url value='/login/resetPw/find'/>">비밀번호 찾기</a> |
                <a href="<c:url value='/join'/>">회원가입</a>
            </div>
            <input type="hidden" name="toURL" value="${param.toURL }">
        </form>
    </div>
<script>
	let msg="${msg}";
	if(msg!="") alert(msg);
</script>
</body>
</html>