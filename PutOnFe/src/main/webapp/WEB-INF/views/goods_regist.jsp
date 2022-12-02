<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path }/resources/css/goods_regist.css">
</head>
<body>

<div class="container2">
	<h1>회원권 등록</h1>
		<div class="goodsList2">
			
				<form class="forma"  id="forma"action=""  >
				
				<label class="goods_li2" for="${goods.goods_no}">
				<input type="hidden"name="goods_no" value="${goods.goods_no}">
					<input style="width:120px;font:25px mbng;float:left;" class="goods_name" name="goods_name" value="${goods.goods_name}" >
						
					
						
					
						<br><br><br><br><br>
					<div class="divb">
						<input style="font:15px mbng;width:30px;"class="goods_price" name="price" value="${goods.price }"><a style="font:15px mbng; ">만원</a>
						
						
					
						<input style="font:15px mbng;" class="goods_period" name="period" value="${goods.period}"><a style="font:15px mbng; ">개월</a>	
						<input style="font:15px mbng;"type="checkbox" name="PT" value="1"id="input_check" ${goods.PT ? 'checked' : '' }  class="input_check"><a style="font:15px mbng; ">PT</a>				
						<input style="font:15px mbng;"class="pt2" name="times" value="${goods.times }" type="${goods.PT ? 'text' : 'hidden' }"><input readonly class="pt3" style="font:15px mbng;"type="${goods.PT ? 'text' : 'hidden' }" value="회">
					</div>
					
						</label>
						
						
						<input type="submit" id="writeBt" value="추가">
				</form>
		
			
			
			
		</div>
		

</div>
<script>
document.getElementById("writeBt").addEventListener('click',e=>{
	
	if($('.goods_name').val().length==0||$('.goods_period').val().length==0||$('.goods_price').val().length==0)
	{
		alert("내용을 모두 입력하세요");
		return false;
	}
	
	if(!confirm("게시물을 등록하시겠습니까?")) return;
	

	let form = document.getElementById('forma');
	form.action="<c:url value='/correction/write'/>";
	form.method="post";
	form.submit();
});


</script>
</body>
</html>