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
    <title>철좀들어-기구현황</title>
    <link rel="stylesheet" href="${path }/resources/css/boarder_machines.css">
</head>
<body>
<%@ include file="navMenu.jsp" %>
<h1 class="title">헬스클럽 시설정보</h1>

<div class="container">
	<c:forEach items="${machineList}" var="machine">
		<ul class="btn_toggle">
			<li class="product_img">
				<img src="${path}/resources/img/${machine.mch_img }">
				<br><br>
				<button class="detail" >세부사항</button>
				<textarea  rows="7" cols="35" class="caption" readonly>${machine.mch_detail}</textarea>
			</li>
			<li class="product_tit"><br>${machine.mch_name}</li>
			<li><textarea rows="7" cols="35" class="product_con" readonly>${machine.mch_info}</textarea></li>
		</ul>
	</c:forEach>
</div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$('.detail').hover(function(){
	$(this).parent().find('.caption').toggle()

});
</script>
</body>
</html>