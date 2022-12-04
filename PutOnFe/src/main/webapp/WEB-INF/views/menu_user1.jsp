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
    <title>철좀들어-상품구매</title>
    <link rel="stylesheet" href="${path }/resources/css/menu_user1.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
	<div>
		<nav>
			<a href="<c:url value='/goods?option=noPT'/>">기간권</a>
			<a href="<c:url value='/goods?option=yesPT'/>">+PT</a>
		</nav>
		<ul>
			<c:forEach var="goods" items="${goodsList}">
				<li class="li_goods">
					<input type="checkbox" value="${goods.goods_name}" id="${goods.goods_no}">
					<label for="${goods.goods_no}">
						<span>기간권 ${goods.goods_name}</span>
						<span class="price">${goods.price}</span>
						<span>${goods.period*30}일<c:if test="${goods.PT}"> + PT ${goods.times}회</c:if></span>
						<span>지금 구매 시 ${goods.end_date }일까지 이용 가능</span>
					</label>
				</li>
			</c:forEach>
		</ul>
	</div>
	<form action="<c:url value='/goods/purchase'/>" method="post" onsubmit="return purchase();">
		<h1>상품구매</h1>
		<input type="text" name="goods_name" readonly required>
		<p></p>
		<input type="submit" value="구매하기" onsubmit="return purchase();">
	</form>
</div>
<script>
// 금액 원화로 치환
$(".price").each(function(index,item){
	price = $(item).text()*10000;
	formatter = new Intl.NumberFormat('ko-KR',{
		currencyDisplay:'name'
	});
	$(item).text(formatter.format(price)+"원");
});
// 상품 클릭 시 이벤트
$("input[type=checkbox]").click(function(){
	$("input[type=checkbox]").not($(this)).removeAttr("checked");
	$(".container>form>input[type=text]").val($(this).val());
	$(".container>form>p").text($(this).next().find("span.price").text());
});
// 구매 확인창
function purchase(){
	if($("input[name=goods_name]").val()==null){
		alert("구입할 상품을 선택해주세요.");
		return false;
	}
	return confirm("해당 상품을 구매하시겠습니까?");
}
</script>
</body>
</html>