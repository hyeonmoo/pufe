<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<div class="trainer">
	<div>
		<p>트레이너</p>
		<p>${user.user_name}님</p>
		<p>PT회원</p>
		<p>${clientNum}명</p>
		<p>오늘일정</p>
		<p><fmt:formatDate value="${today}" pattern="MM월 dd일" type="date"/></p>
	</div>
	<div id="sked">
		<c:forEach varStatus="time" begin="9" end="20">
			<p aria-label="${time.index}">
				<span><fmt:formatNumber value="${time.index}" pattern="00"/>:00</span>
				<span>-</span>
			</p>
		</c:forEach>
	</div>
</div>
<div class="info-nav">
	<a href="<c:url value='/myPage'/>">마이페이지</a>
	<a href="<c:url value='/login/logout'/>">로그아웃</a>
</div>

<script>
$(function(){
	var sked = ${todayString};
	$(sked).each(function(index,pt){
		if(pt.user_name==null)
			$("#sked").find("p[aria-label='"+pt.pt_time+"']").find("span:last").text("휴무");
		else $("#sked").find("p[aria-label='"+pt.pt_time+"']").find("span:last").text(pt.user_name+" 님");
	});
});
</script>