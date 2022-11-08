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
        <div id="logo" class="menu"><a href="#"></a></div>
        <div id="menu_recommend" class="menu"><a href="#">추천정보</a></div>
        <div id="menu_machine_info" class="menu"><a href="#">시설</a></div>
        <div id="menu_rank" class="menu"><a href="#">랭킹</a></div>
        <div id="menu_match" class="menu"><a href="#">헬스메이트</a></div>
        <div id="menu_club_info" class="menu"><a href="#">오시는길</a></div>
        <div id="client_info" class="menu">
            <a href="#"><img src="${path }/resources/img/human.png">${user.user_name }님 | 88.88%</a>
            <div class="submenu">
                <a href="#" id="submenu1">${user.user_type=="U"? '상품구매':user.user_type=="T"?'회원목록':'회원관리'}</a>
                <a href="#" id="submenu2">${user.user_type=="U"? 'PT예약':user.user_type=="T"?'일정관리':'시설관리'}</a>
                <a href="#">마이페이지</a>
                <a href="#">로그아웃</a>
            </div>
        </div>
    </nav>
    <script src="../js/submenu_mouseover.js"></script>
</body>
</html>