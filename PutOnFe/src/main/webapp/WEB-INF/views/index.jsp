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
</head>
<body>
<div id="container">
        <div class="colume" id="logo">
        </div>
        <div class="colume" id="login_menu">
            <div class="article userInfo">
            <c:choose>
	            <c:when test="${sessionScope.email==null }">
	                <a href="<c:url value='/login'/>" id="login-button">로그인</a>
	            </c:when>
	            <c:when test='${user.user_type eq "U"}'>
	                <%@ include file="userInfo.jsp" %>
				</c:when>
				<c:when test='${user.user_type eq "T" }'>
					<p>트레이너 화면</p>
				</c:when>
				<c:when test='${user.user_type eq "A" }'>
					<p>관리자 화면</p>
				</c:when>
			</c:choose>
            </div>
            <div id="menu1" class="article button"><a href="#" id="menu1_a">상품구매</a></div>
            <div id="menu2" class="article button"><a href="#" id="menu2_a">PT예약</a></div>
        </div>
        <div class="colume" id="article_colume1">
            <div id="recommend" class="article">
				<div class="top_bar">
                    <p>추천 운동 정보</p>
					<a href="<c:url value='/nav'/>">더보기</a>
				</div>
                <ul id="rec_area">
                    <li>추천 운동 정보 1</li>
                    <li>추천 운동 정보 2</li>
                    <li>추천 운동 정보 3</li>
                    <li>추천 운동 정보 4</li>
                </ul>
			</div>
            <div id="matching" class="article">
                <div class="top_bar">
                    <p>헬스 메이트</p>
					<a href="#">더보기</a>
				</div>
                <div id="match_info">로그인 후 이용하실 수 있습니다.</div>
            </div>
        </div>
        <div class="colume" id="article_colume2">
            <div id="big_three" class="article">
                <div class="top_bar small">
                    <p>3대 중량</p>
					<a href="#">더보기</a>
				</div>
                <p class="bigthree_p">BIG THREE : <span id="bigthree_total">${user.squat+user.benchpress+user.deadlift }</span></p>
                <p class="bigthree_p">RANK : <span id="bigthree_rank">000</span></p>
                <p class="bigthree_p">SQUAT : <span id="squat">${user.squat }</span></p>
                <p class="bigthree_p">BENCH PRESS : <span id="benchP">${user.benchpress }</span></p>
                <p class="bigthree_p">DEAD LIFT : <span id="deadL">${user.deadlift }</span></p>
            </div>
            <div id="machine_info" class="article">
                <div class="top_bar small">
                    <p>클럽 기구 정보</p>
					<a href="#">더보기</a>
				</div>
            </div>
            <div id="club_info" class="article">
                <a id="address">
                    충북 청주시 서원구 복대로 17번길 57<br> 
                    043-272-0001
                </a>
                <a href="#" id="more">자세히</a>
            </div>
        </div>
    </div>
</body>
</html>