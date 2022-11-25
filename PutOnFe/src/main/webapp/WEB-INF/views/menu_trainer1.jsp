<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>철좀들어-등록회원목록</title>
    <link rel="stylesheet" href="${path }/resources/css/menu_trainer1.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
	<h1>등록회원</h1>
	<table>
		<colgroup>
			<col width="90px">
			<col width="60px">
			<col width="210px">
			<col width="150px">
			<col width="120px">
			<col width="150px" span=2>
			<col width="90px" span=3>
		</colgroup>
		<tr>
			<th>이름</th>
			<th>성별</th>
			<th>이메일</th>
			<th>연락처</th>
			<th>가입상품</th>
			<th>구매날짜</th>
			<th>만료날짜</th>
			<th>PT진행수</th>
			<th>남은PT수</th>
			<th>BIG3</th>
		</tr>
		<c:forEach items="${tulist }" var="user">
		<tr>
			<td>${user.user_name }</td>
			<td>${user.gender=="M"?"남":"여"}</td>
			<td>${user.user_email }</td>
			<td class="tel">${user.user_tel}</td>
			<td>${user.prod_name }</td>
			<td><fmt:formatDate value="${user.buy_date}" pattern="yyyy-MM-dd" type="date"/></td>
			<td><fmt:formatDate value="${user.end_date}" pattern="yyyy-MM-dd" type="date"/></td>
			<td>${user.pt_times }</td>
			<td>${user.pt_remain }</td>
			<td>${user.big3 }
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor" action="<c:url value='menu1/editBig3'/>" method="post">
					<input type="hidden" name="user_email" value="${user.user_email}">
					<input type="text" name="squat" placeholder="스쾃:${user.squat }">
					<input type="text" name="benchpress" placeholder="벤치:${user.benchpress }">
					<input type="text" name="deadlift" placeholder="데드:${user.deadlift }">
					<input type="submit" value="변경">
				</form>
			</td>
		</tr>
		</c:forEach>
	</table>
</div>
<script>
// 휴대폰 번호 - 삽입
$(".tel").each(function(i,e){
	$(e).html($(e).html().substring(0,3)+"-"+$(e).html().substring(3,7)+"-"+$(e).html().substring(7));
});
// 수정 버튼 클릭 시 폼 비운 채로 나타나게
$(".bt_edit").click(function(){
	let editor = $(this).parent().find('.editor');
	$('.editor').not(editor).hide();
	editor.toggle();
	$('.editor').find('input[type=text]').val("");
});
</script>
</body>
</html>