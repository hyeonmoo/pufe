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
    <title>철좀들어</title>
    <link rel="stylesheet" href="${path}/resources/css/index.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
</head>
<body>
<div id="container">
	<div class="column"></div>
	<div class="column">
		<div class="article userInfo">
		<c:choose>
			<c:when test="${sessionScope.email==null }">
                <a href="<c:url value='/login'/>" id="login-button">로그인</a>
            </c:when>
            <c:when test='${user.user_type eq "U"}'>
                <%@ include file="info_user.jsp" %>
			</c:when>
			<c:when test='${user.user_type eq "T" }'>
				<%@ include file="info_trainer.jsp" %>
			</c:when>
			<c:when test='${user.user_type eq "A" }'>
				<%@ include file="info_admin.jsp" %>
			</c:when>
		</c:choose>
		</div>
		<div class="article button">
           	<a href="<c:url value='/menu1'/>">
           		${user.user_type=="A"? '회원관리':user.user_type=="T"?'회원목록':'상품구매'}
			</a>
		</div>
		<div class="article button">
			<a href="<c:url value='/menu2'/>">
				${user.user_type=="A"? '시설관리':user.user_type=="T"?'일정관리':'PT예약'}
			</a>
		</div>
	</div>
	<div class="column">
		<div class="article hasbar">
			<div class="top_bar">
                <p>추천 운동 정보</p>
				<a href="<c:url value='/recommend'/>">더보기</a>
			</div>
			<ul class="contents list">
			<c:forEach items="${list }" var="rec">
				<li><a href="<c:url value='/recommend/read?rec_num=${rec.rec_num }'/>">${rec.rec_title}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="article hasbar">
			<div class="top_bar">
				<p>클럽 기구 정보</p>
				<a href="<c:url value='/machines'/>">더보기</a>
			</div>
			<div class="contents slide">
				<c:forEach items="${machineList}" var="machine">
					<img src="${path}/resources/img/${machine.mch_img}">
			   	</c:forEach>
			    <button id="prev">&lang;</button>
			    <button id="next">&rang;</button>
			</div>
		</div>
	</div>
	<div class="column">
		<div class="article hasbar">
			<div class="top_bar">
               	<p>3대 중량</p>
				<a href="<c:url value='bigThree'/>">더보기</a>
			</div>
			<ul class="contents list">
	            <li><span>BIG THREE</span><span>${not empty user? user.squat+user.benchpress+user.deadlift:'000' }</span></li>
	            <li><span>RANK</span><span>${not empty user? rank:'000'}</span></li>
	            <li><span>SQUAT</span><span>${not empty user? user.squat:'000' }</span></li>
	            <li><span>BENCH PRESS</span><span>${not empty user?user.benchpress:'000' }</span></li>
	            <li><span>DEAD LIFT</span><span>${not empty user?user.deadlift:'000' }</span></li>
        	</ul>
       	</div>
        <div class="article hasbar">
            <div class="top_bar">
                <p>헬스 메이트</p>
                <a href="<c:url value='/matching'/>">더보기</a>
			</div>
			<div class="contents form">
				<c:choose>
					<c:when test="${empty user}">
						로그인 후 이용 가능합니다.
					</c:when>
					<c:otherwise>
					<form action="" method="get" id="matching_join">
						<input type="date" name="m_date" required>
						<input type="text" class="timepicker" placeholder="시간선택" required>
						<select name="part" required>
							<option style="display:none;" value="" selected>부위</option>
							<option value="chest">가슴</option>
							<option value="back">등</option>
							<option value="lower">하체</option>
						</select>
						<input type="submit" value="매칭">
					</form>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
        <div class="article address">
			<a>충북 청주시 서원구 복대로 17번길 57<br>043-272-0001</a>
			<a href="<c:url value='/road'/>">자세히</a>
		</div>
	</div>
</div>
<script>
let msg= "${msg}";
if(msg!="") alert(msg);
//이미지 슬라이드 버튼
let img_cnt=0;
let imgs=$('.slide').find('img');
showing(img_cnt);
function showing(n){
	imgs.hide();
	$.each(imgs,function(index,img){
		if(index==n) $(img).show();
	});
}
$('#prev').click(function(){
	if(img_cnt==0) img_cnt=imgs.length;
	showing(--img_cnt);
});
$('#next').click(function(){
	if(++img_cnt==imgs.length) img_cnt=0;
	showing(img_cnt);
});
//타임피커
$("input.timepicker").timepicker({
	timeFormat: 'HH:mm',
	interval:30,
	minTime:'06:00',
	maxTime:'22:00',
	dynamic:false,
	dropdown:true,
	scrollbar:true
});
// 헬스메이트 매칭 날짜 기본값 설정
var now = new Date();
nowDate = now.getFullYear()+"-"+(now.getMonth()+1)+"-"+now.getDate();
$("input[name=m_date]").val(nowDate);
</script>
</body>
</html>