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
    <title>이메일 찾기</title>
    <link rel="stylesheet" href="${path }/resources/css/findEmail.css">
</head>
<body>
    <div id="container">
        <img src="${path }/resources/img/logo_main.png" alt="logo">
        <form action="<c:url value='/login/findEmail'/>" method="post">
            <h1>이메일 찾기</h1>
            <input type="text" name="name" id="name" placeholder="이름" required>
            <input type="text" name="phone" id="phone" placeholder="휴대폰 번호" required>
            <button type="submit" id="submit">이메일 찾기</button>
            <div id="foundEmail">
                <a href="<c:url value='/login/resetPw/find'/>?email=${email=='해당 정보로 가입된 계정이 없습니다.'?'':email}">비밀번호 재설정</a> |
                <a href="<c:url value='/login'/>?email=${email=='해당 정보로 가입된 계정이 없습니다.'?'':email}">로그인</a>
                <p id="emailRes">${email}</p>
            </div>
        </form>
    </div>
</body>
<script>
</script>
</html>