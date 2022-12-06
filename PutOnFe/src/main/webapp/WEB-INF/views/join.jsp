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
    <title>회원가입</title>
    <link rel="stylesheet" href="${path }/resources/css/join.css">
</head>
<body>
    <div id="container">
        <img src="${path }/resources/img/logo_main.png" alt="logo">
        <form id="form" action="<c:url value="join"/>" method="post">
            <h1>회원가입</h1>
            <input type="email" name="user_email" placeholder="이메일" autocomplete="new-password" required value="${join.user_email}">
            <input type="password" name="user_pw" placeholder="비밀번호(영문,숫자 포함 8자 이상)" required>
            <input type="password" name="pw_confirm" placeholder="비밀번호 확인" required>
            <div id="user_priv">
                <input type="text" name="user_name" id="name" placeholder="이름" autocomplete="new-password" required value="${join.user_name}">
                <div id="gender">
                    <label for="male"><input type="radio" name="gender" id="male" value="M"><span class="radio_icon"></span>남</label>
                    <label for="female"><input type="radio" name="gender" id="female" value="F"><span class="radio_icon"></span>여</label>
                </div>
            </div>
            <input type="tel" name="user_tel" id="phone" placeholder="휴대폰(-없이 입력)" autocomplete="new-password" required value="${join.user_tel }">
            <div id="termsarea">
                <label for="terms_user">
                    <input type="checkbox" name="terms_user" id="terms_user">
                    <span class="check_icon"></span>
                    [필수]<a href="#">개인정보 수집 및 이용 약관</a>에 동의합니다.
                </label>
                <label for="terms_club">
                    <input type="checkbox" name="terms_club" id="terms_club">
                    <span class="check_icon"></span>
                    [필수]<a href="#">철좀들어 이용 약관</a>에 동의합니다.
                </label>
            </div>
            
            <button type="submit" id="submit">회원가입</button>
        </form>
    </div>
<script>
	let msg="${msg}";
	if(msg!="") alert(msg);
</script>
</body>
</html>