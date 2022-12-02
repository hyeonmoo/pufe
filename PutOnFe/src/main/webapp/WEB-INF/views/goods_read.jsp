<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path }/resources/css/goods_read.css">
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
<nav>
		
			<a href="<c:url value='/menu2'/>">시설관리</a>
			<a href="<c:url value='/correction'/>">회원권 관리</a>
			
		
	</nav> 
	<h1>회원권 수정</h1>
		<div class="goodsList">
		
			<c:forEach var="goods" items="${goodsList}" varStatus="i">
				<form  class="form" id="form${ i.index}" >
				
				<label class="goods_li" for="${goods.goods_no}"><input type="hidden"name="goods_no" value="${goods.goods_no}">
				<input style="width:120px;font:25px mbng;float:left;" class="goods_name" name="goods_name" value="${goods.goods_name}">
						<input style="font:10px mbng;" type="button" class="removeBt" id="removeBt${ i.index}" value="삭제">
						<br><br>	<br><br><br>
						
						
						<div class="diva" >
						<input style="font:15px mbng;width:30px;" name="price" value="${goods.price }"><a style="font:15px mbng; ">만원</a>
						<input style="font:15px mbng; " name="period" value="${goods.period}"><a style="font:15px mbng; ">개월</a>
						
						
						<input style="font:15px mbng;"type="checkbox" name="PT" value="1"id="input_check" ${goods.PT ? 'checked' : '' }  class="input_check"><a style="font:15px mbng; ">PT</a>
						
						
						<input style="font:15px mbng;"class="pt2" name="times" value="${goods.times }" type="${goods.PT ? 'text' : 'hidden' }"><input readonly class="pt3" style="font:15px mbng;"type="${goods.PT ? 'text' : 'hidden' }" value="회">
						
						</div>
						
					
						
						<div class="divb" >
						
						</div>
						
						
						
						</label>
						
				</form>
			</c:forEach>
			
			
			
		</div><input  type="button" class="btn" id="btn" value="수정">
				

</div>

<%@ include file="goods_regist.jsp" %>

<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
 let sizes = document.getElementsByClassName('form').length;
  for(let i=0; i<sizes; i++){
 document.getElementById("removeBt"+i).addEventListener('click',e=>{
	if(!confirm("상품을 삭제하겠습니까?")) return;
	let form=document.getElementById('form'+i);
	form.action="<c:url value='/correction/remove'/>";
	form.method="post";
	form.submit();
});}
 
window.onload = function() {
	document.getElementById('btn').onclick = function() {
		alert("수정되었습니다.");
        let size = document.getElementsByClassName('form').length;
        for(let i=0; i<size; i++){
    		$.ajax({
                type:'POST',       // 요청 메서드
                url: "<c:url value='correction/modify'/>",  // 요청 URI
                data : $('#form'+i).serialize(),
                success : function(result){ // 요청이 성공일 때 실행되는 이벤트
                },
                error: function(){ alert("실패") } // 에러가 발생했을 때 실행되는 이벤트
            }); // $.ajax()
        }
        
        return false;

	};
	
};
$('.input_check').on("click", function(){
	if($(this).is(':checked')){
		$(this).val(1);
		$(this).parent().find('.pt2').prop("type", "text");
		  $(this).parent().find(".pt2").show();
		  $(this).parent().find('.pt3').prop("type", "text");
		  $(this).parent().find(".pt3").show();
	}
	else{
		$(this).val(0)
		$(this).parent().find(".pt2").hide();
		$(this).parent().find(".pt3").hide();
	}
	console.log($(this).val())
});


</script>
</body>
</html>