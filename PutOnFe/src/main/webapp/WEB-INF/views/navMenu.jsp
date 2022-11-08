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
    <title>Navigation Bar</title>
    <link rel="stylesheet" href="${path}/resources/css/navMenu.css">
</head>
<body>
    <nav id="nav_menu">
        <div id="logo" class="menu"><a href="<c:url value='/'/>"></a></div>
        <div id="menu_recommend" class="menu"><a href="<c:url value='/recommend'/>">추천정보</a></div>
        <div id="menu_machine_info" class="menu"><a href="<c:url value='/machines'/>">시설</a></div>
        <div id="menu_rank" class="menu"><a href="<c:url value='/bigThree'/>">랭킹</a></div>
        <div id="menu_match" class="menu"><a href="<c:url value='/matching'/>">헬스메이트</a></div>
        <div id="menu_club_info" class="menu"><a href="<c:url value='/road'/>">오시는길</a></div>
        <div id="client_info" class="menu">
            <a href="#"><img src="${path}/resources/img/human.png">${not empty sessionScope.email?user.user_name:'손' }님 | 3대 ${user.squat+user.benchpress+user.deadlift}</a>
            <div class="submenu">
                <a href="<c:url value='/menu1'/>" id="submenu1">${user.user_type=="A"? '회원관리':user.user_type=="T"?'회원목록':'상품구매'}</a>
                <a href="<c:url value='/menu2'/>" id="submenu2">${user.user_type=="A"? '시설관리':user.user_type=="T"?'일정관리':'PT예약'}</a>
                <a href="<c:url value='/myPage'/>">마이페이지</a>
                <a href="<c:url value='/login'/>${not empty sessionScope.email?'/logout':lastPage}">${not empty sessionScope.email?"로그아웃":"로그인"}</a>
            </div>
        </div>
    </nav>
<script>
const submenus = document.querySelectorAll('.submenu a');
for(let submenu of submenus){
    submenu.addEventListener("mouseover",function(){
        submenu.parentNode.parentNode.childNodes[1].style.backgroundColor="black";
    });
    submenu.addEventListener("mouseout",function(){
        submenu.parentNode.parentNode.childNodes[1].style.backgroundColor="";
    });
}
</script>
</body>
</html>
