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
    <title>비밀번호 재설정</title>
    <link rel="stylesheet" href="${path }/resources/css/resetPwd_find.css">
</head>
<body>
    <div id="container">
        <img src="${path }/resources/img/logo_main.png" alt="logo">
        <form action="<c:url value='reset'/>" method="post">
            <h1>비밀번호 재설정</h1>
            <input type="text" name="email" id="email" placeholder="이메일" value="${param.email}" required>
            <input type="text" name="name" id="name" placeholder="이름" required>
            <input type="text" name="phone" id="phone" placeholder="휴대폰 번호" required>
            <button type="submit" id="submit">계정 조회</button>
            <div id="result">
                <a href="<c:url value='/login/findEmail'/>">이메일 찾기</a> |
                <a href="<c:url value='/login'/>">로그인</a>
            </div>
        </form>
    </div>
</body>
<script>
let msg = "${msg}";
if(msg=="EmailNotExist") alert("해당 정보로 가입된 계정이 없습니다.");
</script>
</html>