<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="resources/css/join.css">
</head>
<body>
    <div id="container">
        <img src="resources/img/logo_main.png" alt="logo">
        <form id="form" action="<c:url value="join"/>" method="post">
            <h1>회원가입</h1>
            <input type="email" name="user_email" placeholder="이메일" autocomplete="new-password" required>
            <input type="password" name="user_pw" placeholder="비밀번호" required>
            <input type="password" name="pw_confirm" placeholder="비밀번호 확인" required>
            <div id="user_priv">
                <input type="text" name="user_name" id="name" placeholder="이름" autocomplete="new-password" required>
                <div id="gender">
                    <label for="male"><input type="radio" name="gender" id="male" value="M"><span class="radio_icon"></span>남</label>
                    <label for="female"><input type="radio" name="gender" id="female" value="F"><span class="radio_icon"></span>여</label>
                </div>
            </div>
            <input type="tel" name="user_tel" id="phone" placeholder="휴대폰(-없이 입력)" autocomplete="new-password" required>
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
	if(msg=="PwDiscord") alert("비밀번호 불일치");
	if(msg=="TermsNotAgreed") alert("모든 약관에 동의하셔야 합니다.");
	if(msg=="DuplicateEmail") alert("이미 가입된 이메일입니다.");
	if(msg=="JoinFailed") alert("알 수 없는 이유로 회원가입에 실패했습니다.");
</script>
</body>
</html>