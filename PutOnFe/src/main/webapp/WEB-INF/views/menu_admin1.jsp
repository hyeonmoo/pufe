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
    <title>철좀들어-회원관리</title>
    <link rel="stylesheet" href="${path }/resources/css/menu_admin1.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
	<nav>
		<h1>회원 관리</h1>
		<a href="<c:url value='menu1?viewType=admin'/>">관리자</a>
		<a href="<c:url value='menu1?viewType=trainer'/>">트레이너</a>
		<a href="<c:url value='menu1?viewType=user'/>">일반회원</a>
	</nav>
	<table>
		<colgroup>
			<col width="200px" span=6>
		</colgroup>
		<tr>
			<th>총회원수</th>
			<th>관리자</th>
			<th>트레이너</th>
			<th>일반회원</th>
			<th>상품구매</th>
			<th>PT구매</th>
		</tr>
		<tr>
			<td>${stats.total }</td>
			<td>${stats.admin }</td>
			<td>${stats.trainer }</td>
			<td>${stats.user }</td>
			<td>${stats.product }</td>
			<td>${stats.pt }</td>
		</tr>
	</table>
	<c:choose>
	<c:when test='${viewType eq "user" }'>
	<table>
		<colgroup>
			<col width="120px">
			<col width="60px">
			<col width="180px">
			<col width="120px">
			<col width="150px" span=2>
			<col width="90px">
			<col width="120px">
			<col width="90px">
			<col width="120px">
		</colgroup>
		<tr>
			<th>이름</th>
			<th>성별</th>
			<th>연락처</th>
			<th>가입상품</th>
			<th>구매날짜</th>
			<th>만료날짜</th>
			<th>남은일수</th>
			<th>담당PT</th>
			<th>남은PT</th>
			<th>BIG3</th>
		</tr>
		<c:forEach var="user" items="${userlist}">
		<tr>
			<td>${user.user_name}
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor usertype" action="<c:url value='manage/editType'/>" method="post">
					<input type="hidden" name="user_email" value="${user.user_email}">
					<select name="userType">
						<option value="A">관리자</option>
						<option value="T">트레이너</option>
					</select>
					<input type="submit" value="변경">
				</form>
			</td>
			<td>${user.gender=="M"?"남":"여"}</td>
			<td class="tel">${user.user_tel}</td>
			<td>${user.prod_name }</td>
			<td><fmt:formatDate value="${user.buy_date}" pattern="yyyy-MM-dd" type="date"/></td>
			<td><fmt:formatDate value="${user.end_date}" pattern="yyyy-MM-dd" type="date"/></td>
			<td>${user.remain }</td>
			<td>${user.trainer_name }
				<c:if test="${user.trainer!=null }">
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor trainer" action="<c:url value='manage/editTrainer'/>" method="post">
					<input type="hidden" name="user_email" value="${user.user_email}">
					<select name="changeTrainer">
					<c:forEach var="selectTrainer" items="${trainerlist }">
						<option value="${selectTrainer.user_email }">${selectTrainer.user_name }</option>
					</c:forEach>
					</select>
					<input type="submit" value="변경">
				</form>
				</c:if>
			</td>
			<td>${user.days }</td>
			<td>${user.big3 }
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor big3" action="<c:url value='manage/editBig3'/>" method="post">
					<input type="hidden" name="user_email" value="${user.user_email}">
					<input type="text" name="squat" placeholder="스쿼트">
					<input type="text" name="benchpress" placeholder="벤치프레스">
					<input type="text" name="deadlift" placeholder="데드리프트">
					<input type="submit" value="변경">
				</form>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:when>
	<c:when test='${viewType eq "trainer" }'>
	<table>
		<colgroup>
			<col width="200px" span=6>
		</colgroup>
		<tr>
			<th>이메일</th>
			<th>이름</th>
			<th>성별</th>
			<th>연락처</th>
			<th>등록회원수</th>
			<th>BIG3</th>
		</tr>
		<c:forEach var="trainer" items="${trainerlist}">
		<tr>
			<td>${trainer.user_email }</td>
			<td>${trainer.user_name }
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor usertype" action="<c:url value='manage/editType'/>" method="post">
					<input type="hidden" name="user_email" value="${trainer.user_email}">
					<input type="hidden" name="viewType" value="trainer">
					<select name="userType">
						<option value="A">관리자</option>
						<option value="U">일반회원</option>
					</select>
					<input type="submit" value="변경">
				</form>
			</td>
			<td>${trainer.gender=="M"?"남":"여"}</td>
			<td class="tel">${trainer.user_tel}</td>
			<td>${trainer.members}</td>
			<td>${trainer.big3 }
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor big3" action="<c:url value='manage/editBig3'/>" method="post">
					<input type="hidden" name="user_email" value="${trainer.user_email}">
					<input type="hidden" name="viewType" value="trainer">
					<input type="text" name="squat" placeholder="스쿼트">
					<input type="text" name="benchpress" placeholder="벤치프레스">
					<input type="text" name="deadlift" placeholder="데드리프트">
					<input type="submit" value="변경">
				</form>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:when>
	<c:when test='${viewType eq "admin" }'>
	<table>
		<colgroup>
			<col width="240px" span=5>
		</colgroup>
		<tr>
			<th>이메일</th>
			<th>이름</th>
			<th>성별</th>
			<th>연락처</th>
			<th>BIG3</th>
		</tr>
		<c:forEach var="admin" items="${adminlist}">
		<tr>
			<td>${admin.user_email }</td>
			<td>${admin.user_name }
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor usertype" action="<c:url value='manage/editType'/>" method="post">
					<input type="hidden" name="user_email" value="${admin.user_email}">
					<input type="hidden" name="viewType" value="admin">
					<select name="userType">
						<option value="T">트레이너</option>
						<option value="U">일반회원</option>
					</select>
					<input type="submit" value="변경">
				</form>
			</td>
			<td>${admin.gender=="M"?"남":"여"}</td>
			<td class="tel">${admin.user_tel}</td>
			<td>${admin.big3 }
				<button class="bt_edit"><img src="${path}/resources/img/icon_edit.png"></button>
				<form class="editor big3" action="<c:url value='manage/editBig3'/>" method="post">
					<input type="hidden" name="user_email" value="${admin.user_email}">
					<input type="hidden" name="viewType" value="admin">
					<input type="text" name="squat" placeholder="스쿼트">
					<input type="text" name="benchpress" placeholder="벤치프레스">
					<input type="text" name="deadlift" placeholder="데드리프트">
					<input type="submit" value="변경">
				</form>
			</td>
		</tr>
		</c:forEach>
	</table>
	</c:when>
	</c:choose>
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