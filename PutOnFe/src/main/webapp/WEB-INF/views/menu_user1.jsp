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
	<div class="goodsArea">
		<div class="goodsNav">
			<a href="<c:url value='/goods?option=noPT'/>">기간권</a>
			<a href="<c:url value='/goods?option=yesPT'/>">+PT</a>
		</div>
		<div class="goodsList">
			<c:forEach var="goods" items="${goodsList}">
			<div>
				<input type="checkbox" value="${goods.goods_name}" id="${goods.goods_no}">
				<label class="goods_li" for="${goods.goods_no}">
					<p>
						<span style="font:20px mbng;" class="goods_price">${goods.price}0000</span>
						<span style="font:25px mbng;" class="goods_name">기간권 ${goods.goods_name}</span>
					</p>
					<p style="font:15px mbng;text-align:right;">${goods.period*30}일<c:if test="${goods.PT}"> + PT ${goods.times}회</c:if></p>
					<p style="font:13px mbng;text-align:right;">지금 구매 시 2023-13-32일까지 이용 가능</p>
				</label>
			</div>
			</c:forEach>
		</div>
	</div>
	<form class="purchaseArea" action="<c:url value='/goods/purchase'/>" method="post" onsubmit="return purchase();">
		<h1>상품구매</h1>
		<input type="text" id="buying_goods_name" name="goods_name" readonly required>
		<p id="buying_goods_price"></p>
		<input type="submit" value="구매하기" onsubmit="return purchase();">
	</form>
</div>
<script>
$(".goods_price").each(function(index,item){
	$(item).text(parseInt($(item).text()).toLocaleString()+" 원");
});

$("input[type=checkbox]").click(function(){
	$("input[type=checkbox]").not($(this)).removeAttr("checked");
	$("#buying_goods_name").val($(this).val());
	$("#buying_goods_price").text($(this).parent().find(".goods_price").text());
});

function purchase(){
	if($("#buying_goods_name").val()==null){
		alert("구입할 상품을 선택해주세요.");
		return false;
	}
	return confirm("해당 상품을 구매하시겠습니까?");
}
</script>
</body>
</html>