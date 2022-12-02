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
    <link rel="stylesheet" href="${path }/resources/css/resetPwd_reset.css">
</head>
<body>
    <div id="container">
        <img src="${path }/resources/img/logo_main.png" alt="logo">
        <form action="<c:url value='resetComplete'/>" method="post">
            <h1>비밀번호 재설정</h1>
            <input type="hidden" name="email" value="${email }">
            <input type="password" name="pwd" id="pwd" placeholder="새로운 비밀번호" required>
            <input type="password" name="pwd_confirm" id="pwd_confirm" placeholder="비밀번호 확인" required>
            <button type="submit" id="submit">재설정</button>
            <hr>
        </form>
    </div>
</body>
<script>
let msg="${msg}";
if(msg=="PwDiscord") alert("비밀번호가 일치하지 않습니다.");
if(msg=="ResetError") alert("알 수 없는 이유로 비밀번호가 변경되지 않았습니다.");
</script>
</html>