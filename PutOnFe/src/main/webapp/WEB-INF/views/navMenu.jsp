<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${path}/resources/css/navMenu.css">
<nav class="nav_menu">
	<div class="logo"><a href="<c:url value='/'/>"></a></div>
	<div><a href="<c:url value='/recommend'/>">헬스추천정보</a></div>
	<div><a href="<c:url value='/machines'/>">헬스클럽시설</a></div>
	<div><a href="<c:url value='/bigThree'/>">BIG3랭킹</a></div>
	<div><a href="<c:url value='/healthmate'/>">헬스메이트</a></div>
	<div><a href="<c:url value='/road'/>">오시는길</a></div>
	<div class="user-info"><a href="#"><img src="${path}/resources/img/human.png">${not empty sessionScope.email?user.user_name:'손' }님 | 3대 ${user.squat+user.benchpress+user.deadlift}</a>
		<div class="submenu">
			<a href="<c:url value='/menu1'/>">${user.user_type=="A"? '회원관리':user.user_type=="T"?'회원목록':'상품구매'}</a>
			<a href="<c:url value='/menu2'/>">${user.user_type=="A"? '시설관리':user.user_type=="T"?'일정관리':'PT예약'}</a>
			<a href="<c:url value='/myPage'/>">마이페이지</a>
			<a href="<c:url value='/login'/>${not empty sessionScope.email?'/logout':'?from='+=from}">${not empty sessionScope.email?"로그아웃":"로그인"}</a>
		</div>
	</div>
</nav>
<script>
$(".submenu>a").hover(function(){
	$(this).parent().prev().css("background","black");
},function(){
	$(this).parent().prev().css("background","");
});
</script>