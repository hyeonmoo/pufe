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
<title>철좀들어-마이페이지</title>
<link rel="stylesheet" href="${path}/resources/css/myPage.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
	<nav>
		<ul>
			<li><a href="<c:url value='/myPage'/>">회원정보</a></li>
			<li><a href="<c:url value='/myPage/changePw'/>">비밀번호 변경</a></li>
			<li><a href="<c:url value='/myPage/unregister'/>">회원탈퇴</a></li>
		</ul>
	</nav>
	<div class="contents">
		<h1>${menu=='info'?'회원정보':menu=='changePw'?'비밀번호 변경':'회원탈퇴'}</h1>
		<form action="" method="post" onsubmit="return onSubmit()">
		<c:choose>
			<c:when test="${menu=='info'}">
				<div class="info">
					<label><span>이메일</span><input type="text" name="email" id="email" value="${user.user_email}" readonly></label>
					<label><span>이름</span><input type="text" name="name" class="modifiable" id="name" value="${user.user_name}" ${page=='show'?'readonly':'' }></label>
					<label><span>연락처</span><input type="text" name="tel" class="modifiable" id="tel" ${page=='show'?'readonly':'' }></label>
					<label><span>성별</span><input type="text" name="gender" id="gender" value="${user.gender eq 'M'?'남자':'여자'}" readonly></label>
					<label><span>회원유형</span><input type="text" name="type" id="type" value="${user.user_type eq 'A'?'관리자':user.user_type eq 'T'?'트레이너':'일반회원'}" readonly></label>
				</div>
				<input id="modify" class="button" type="${page=='show'?'button':'hidden'}" value="회원정보수정">
				<input id="cancel" class="button" type="${page=='modify'?'reset':'hidden'}" value="취소">
				<input id="submit" class="button" type="${page=='modify'?'submit':'hidden'}" value="수정하기">
			</c:when>
			<c:when test="${menu=='changePw'}">
				<div class="info">
					<label><input type="password" name="currentPw" placeholder="현재 비밀번호"></label>
					<label><input type="password" name="newPw" placeholder="새로운 비밀번호"></label>
					<label><input type="password" name="newPwConfirm" placeholder="새로운 비밀번호 확인"></label>
				</div>
				<input type="reset" class="button" value="취소">
				<input type="submit" class="button" value="변경하기">
			</c:when>
			<c:when test="${menu=='unregister'}">
				<div class="info">
					<label><input type="password" name="pw" placeholder="비밀번호 입력"></label>
				</div>
				<input type="reset" class="button" value="취소">
				<input type="submit" class="button" value="탈퇴하기">
			</c:when>
		</c:choose>
		</form>
	</div>
</div>
</body>
<script>
let tel = "${user.user_tel}";
let menu = "${menu}";
let page= "${page}";
let msg = "${msg}";

//상태메시지
if(msg!="") alert(msg);

//연락처 - 넣기(수정할 땐 빼기)
let user_tel= tel.substring(0,3)+"-"+tel.substring(3,7)+"-"+tel.substring(7);
$("#tel").val(page=="show"?user_tel:tel);

// 회원정보 변경 가능한 항목 표시
if(page=="modify"){
	$(".modifiable").css("background-color","#eee");
	$(".modifiable").focus(function(){
		$(this).css("border","2px solid #121212");
	});
	$(".modifiable").blur(function(){
		$(this).css("border","0");
	});
}

// 회원정보 변경 버튼
$("#modify").click(function(){
	window.location="<c:url value='/myPage/modify'/>";
});

// 취소버튼
$("input[type=reset]").click(function(){
	window.location="<c:url value='/myPage'/>";
});

// 전송 버튼
function onSubmit(){
	switch(menu){
	case "info": return confirm("회원정보를 변경하시겠습니까?");
	case "changePw": return confirm("비밀번호를 변경하시겠습니까?");
	case "unregister": return confirm("정말 탈퇴하시겠습니까?");
	}
}

</script>
</html>