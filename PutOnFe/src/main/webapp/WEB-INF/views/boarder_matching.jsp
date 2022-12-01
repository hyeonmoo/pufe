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
    <title>철좀들어-추천정보</title>
    <!-- jquery -->
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<!-- flatpickr -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
	<!-- timepicker -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
    <!-- css file -->
    <link rel="stylesheet" href="${path }/resources/css/boarder_matching.css">
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
	<div>
		<h4>매칭 결과</h4>
		<c:if test="${not empty mc}">
			<p>| ${mc.part=="chest"?"가슴":mc.part=="back"?"등":"하체"} | ${mc.dateOption} | ${mc.timeOption} |</p>
		</c:if>
		<table>
			<thead>
				<tr>
					<th>성별</th>
					<th>BIG3</th>
					<th>요청수</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
			<c:when test="${recommend==null}">
				<tr><td colspan=4>매칭된 항목이 없습니다.</td></tr>
			</c:when>
			<c:otherwise>
				<tr id="${recommend.post_no }">
					<td>${recommend.poster_gender=='M'?'남':'여'}</td>
					<td>${recommend.poster_big3}</td>
					<td>${recommend.requests}</td>
					<td><b class="requestToPost textBt">요청하기</b></td>
				</tr>
			</c:otherwise>
			</c:choose>
			</tbody>
		</table>
	</div>
	<div>
		<h4>매칭 등록</h4>
		<form id="postingForm" autocomplete="off">
			<select class="post_part" name="part" required>
				<option style="display:none;" value="" selected>파트</option>
				<option value="chest">가슴</option>
				<option value="back">등</option>
				<option value="lower">하체</option>
			</select>
			<input type="text" class="post_ picker" name="date" required placeholder="날짜">
			<input type="text" class="post_ picker" name="time" required placeholder="시간">
			<input type="button" class="postBt" value="등록하기">
		</form>
	</div>
	<div>
		<h4>매칭 현황</h4>
		<table>
			<thead>
				<tr>
					<th>파트</th>
					<th>날짜</th>
					<th>시간</th>
					<th>요청/파트너</th>
				</tr>
			</thead>
			<tbody class="contents">
				<c:forEach var="myPost" items="${myPosts}">
					<tr id="${myPost.post_no}">
						<td>${myPost.part=="chest"?'가슴':myPost.part=="back"?'등':'하체'}</td>
						<td>${myPost.date}</td>
						<td>${myPost.time}</td>
						<c:if test="${empty myPost.partner}">
							<td><span class="requests">${myPost.requests}</span><span class="x-mark" aria-label="post">&times;</span></td>
						</c:if>
						<c:if test="${not empty myPost.partner }">
							<td class="matched">${myPost.partner_name} 님</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<h4>내 요청</h4>
		<table>
			<thead>
				<tr>
					<th>파트</th>
					<th>날짜</th>
					<th>시간</th>
					<th>현황</th>
				</tr>
			</thead>
			<tbody class="contents">
				<c:forEach var="myRequest" items="${myRequests}">
					<tr id="${myRequest.join_no}">
						<td>${myRequest.part=="chest"?'가슴':myRequest.part=="back"?'등':'하체'}</td>
						<td>${myRequest.date}</td>
						<td>${myRequest.time}</td>
						<c:choose>
							<c:when test="${myRequest.status=='matched'}">
								<td class="matched">수락됨</td>
							</c:when>
							<c:otherwise>
								<td>요청됨<span class='x-mark' aria-label='join'>&times;</span></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="allPosts">
		<h4>리스트</h4>
		<table>
			<thead>
				<tr>
					<th>파트</th>
					<td class="part checked" aria-label="all">전체</td>
					<td class="part" aria-label="chest">가슴</td>
					<td class="part" aria-label="back">등</td>
					<td class="part" aria-label="lower">하체</td>
					<td></td>
				</tr>
				<tr>
					<th>날짜</th>
					<td class="date checked" aria-label="all">전체</td>
					<td class="date" aria-label="tomorrow">오늘+내일</td>
					<td class="date" aria-label="weekend">이번 주말</td>
					<td class="date" aria-label="recent7">최근 7일</td>
					<td><input class="date picker" type="text" placeholder="날짜 선택"></td>
				</tr>
				<tr>
					<th>시간</th>
					<td class="time checked" aria-label="all">전체</td>
					<td class="time" aria-label="morning">아침(06:00~11:30)</td>
					<td class="time" aria-label="afternoon">낮(12:00~17:30)</td>
					<td class="time" aria-label="evening">저녁(18:00~22:00)</td>
					<td>
						<input class="time picker" type="text" placeholder="시간대 선택">
						<input class="time picker" type="text" placeholder="시간대 선택">
					</td>
				</tr>
			</thead>
		</table>
		<table>
			<thead>
				<tr>
					<th>파트</th>
					<th>날짜</th>
					<th>시간</th>
					<th>성별</th>
					<th>BIG3</th>
					<th>요청</th>
				</tr>
			</thead>
			<tbody id="postList">
				<c:forEach var="post" items="${postList}">
					<tr class="${post.poster}" id="${post.post_no}">
						<td>${post.part=="chest"?'가슴':post.part=="back"?'등':'하체'}</td>
						<td>${post.date}</td>
						<td>${post.time}</td>
						<td>${post.poster_gender=="M"?'남':'여'}</td>
						<td>${post.poster_big3}</td>
						<td>${post.requests}
							<c:if test="${post.poster!=sessionScope.email}">
								<span class="j-mark requestToPost"></span>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script>
//매칭 완료된 tr 이벤트
$(".matched").parent().find("td").css("background","aliceblue");

//삭제버튼 클릭 시
$(document).on("click",".x-mark",function(){
	if($(this).attr("aria-label")=="post")
		data = "post_no="+$(this).parent().parent().attr("id");
	else data = "join_no="+$(this).parent().parent().attr("id");
	$.ajax({
		type:"delete",
		url:"healthmate/delete?"+data,
		beforeSend: function(){return confirm("정말 삭제하시겠습니까?");},
		success: function(result){
			alert(result);
			location.replace("healthmate");
		},
		error: function(e){alert(e.responseText);}
	});
});

//포스트 등록 시
$(document).on("click",".postBt",function(){
	part = $("#postingForm select[name=part]").val();
	date = $("#postingForm input[name=date]").val();
	time = $("#postingForm input[name=time]").val();
	
	data = {part:part,date:date,time:time};
	$.ajax({
		type: "post",
		url: "healthmate/post",
		headers:{"content-type":"application/json"},
		data:JSON.stringify(data),
		beforeSend: function(){return confirm("등록하시겠습니까?");},
		success: function(result){
			alert(result);
			location.replace("healthmate");
		},
		error: function(e){alert(e.responseText);}
	});
});

//데이트피커, 타임피커
// 포스트 등록
flatpickr(".post_.picker[name=date]",{
	minDate:"today",
	maxDate:new Date().fp_incr(14),
	monthSelectorType:"static",
	locale:"ko",
	ariaDateFormat:"Y-m-d",
	dateFormat:"Y-m-d"
});
$(".post_.picker[name=time]").timepicker({
	timeFormat: "HH:mm",
	interval:30,
	minTime:'06:00',
	maxTime:'22:00',
	dynamic:false,
	dropdown:true,
	scrollbar:true
});

// 필터 선택항목
flatpickr(".date.picker",{
	minDate:"today",
	maxDate:new Date().fp_incr(14),
	monthSelectorType:"static",
	locale:"ko",
	ariaDateFormat:"Y-m-d",
	dateFormat:"Y-m-d",
	onChange:function(selectedDates, dateStr, instance){
		$(".date.checked").val(dateStr);
		getList();
	}
});
$(".time.picker:first").timepicker({
	timeFormat: 'HH:mm',
	interval:30,
	minTime:'06:00',
	maxTime:'22:00',
	dynamic:false,
	dropdown:true,
	scrollbar:true,
	change:function(time){
		last=$(".time.picker:last");
		$(this).add("input.time.picker").addClass("checked");
		if(last.val()=="")
			last.val($(this).timepicker().format(time));
		if($(this).val()>last.val()){
			tmp = $(this).val();
			$(this).val(last.val());
			last.val(tmp);
		}
		getList();
	}
});
$(".time.picker:last").timepicker({
	timeFormat: 'HH:mm',
	interval:30,
	minTime:'06:00',
	maxTime:'22:00',
	dynamic:false,
	dropdown:true,
	scrollbar:true,
	change:function(time){
		first=$(".time.picker:first");
		$(this).add("input.time.picker").addClass("checked");
		if(first.val()=="")
			first.val($(this).timepicker().format(time));
		if($(this).val()<first.val()){
			tmp = $(this).val();
			$(this).val(first.val());
			first.val(tmp);
		}
		getList();
	}
});
//옵션 선택 시 라디오버튼 기능
$(document).on("click",".part",function(){
	$(".part").removeClass("checked");
	$(this).addClass("checked");
	getList();
	return;
});
$(document).on("click",".date",function(){
	$(".date").removeClass("checked");
	$(this).addClass("checked");
	if($(this).attr("type")=="text") return;
	getList();
	return;
});
$(document).on("click",".time",function(){
	$(".time").removeClass("checked");
	$(this).addClass("checked");
	if($(this).attr("type")=="text") return;
	getList();
	return;
});

// 이벤트 발생시 리스트 최신화
function getList(){
	part=$(".part.checked").attr("aria-label");
	if($(".date.checked").attr("type")=="text")
		date=$(".date.checked").val();
	else date=$(".date.checked").attr("aria-label");
	if($(".time.checked").attr("type")=="text")
		time=$(".time.picker:first").val()+"~"+$(".time.picker:last").val();
	else time=$(".time.checked").attr("aria-label");
	data={part:part,dateOption:date,timeOption:time};
	
	$.ajax({
		type:'get',
		url:'healthmate/list',
		data:data,
		success:function(result){
			$("#postList").html(listUp(result));
		},
		error:function(){
			alert("error");
		}
	});
}
function listUp(posts){
	let tmp = "";
	posts.forEach(function(post){
		if(post.part=="chest") part="가슴";
		else if(post.part=="back") part="등";
		else part="하체";
		gender= post.poster_gender=="M"?"남":"여";
		tmp+= '<tr class="'+post.poster+'" id="'+post.post_no+'">';
		tmp+= '<td>'+part+'</td>';
		tmp+= '<td>'+post.date+'</td>';
		tmp+= '<td>'+post.time+'</td>';
		tmp+= '<td>'+gender+'</td>';
		tmp+= '<td>'+post.poster_big3+'</td>';
		tmp+= '<td>'+post.requests; 
		if(post.poster!="${sessionScope.email}") tmp+= '<span class="j-mark requestToPost"></span>';
		tmp+= '</td></tr>';
	});
	return tmp;
}

// 자신의 요청 수 클릭 시 등록된 요청 리스트 출력
$(document).on("click",".requests",function(){
	post_no=$(this).parent().parent().attr("id");
	button = $(this);
	if($(this).parent().parent().next().prop("tagName")=="DIV"){
		$(this).parent().parent().next().remove();
	} else{
		$(".myPostRequests").remove();
		$.ajax({
			type:'get',
			url:'healthmate/requestlist?post_no='+post_no,
			success: function(result){
				button.parent().parent().after(requestListUp(result));
			},
			error:function(){
				alert("error");
			}
		});
	}
});
function requestListUp(requests){
	let tmp= '<div class="myPostRequests"><table>';
	if(requests[0]==null){
		tmp+= '<tbody><tr><td span=4>등록된 요청이 없습니다.</td></tr></tbody></table>';
	} else{
		tmp+= '<thead><tr><th>이름</th><th>성별</th><th>BIG3</th><th>매칭</th></tr></thead>';
		tmp+= '<tbody>';
		requests.forEach(function(request){
			gender= request.req_gender=="M"?"남":"여";
			tmp+= '<tr>';
			tmp+= '<td class="req_name">'+request.req_name+'</td>';
			tmp+= '<td>'+gender+'</td>';
			tmp+= '<td>'+request.req_big3+'</td>';
			tmp+= '<td><b class="matchConfirm textBt" aria-label="'+request.post_no+'-'+request.join_no+'-'+request.requester+'">매칭하기</b></td>';
			tmp+= '</tr>';
		});
		tmp+= '</tbody></table></div>';
	}
	return tmp;
}
//매칭 요청
$(document).on("click",".requestToPost",function(){
	post_no = $(this).parent().parent().attr("id");
	$.ajax({
		type:'post',
		url:'healthmate/request',
		contentType:'application/json',
		data:JSON.stringify({post_no:post_no}),
		beforeSend:function(){return confirm("요청하시겠습니까?");},
		success:function(result){
			alert(result);
			location.replace("healthmate");
		},
		error:function(e){
			alert(e.responseText);
		}
	});
});
// 매칭 확정
$(document).on("click",".matchConfirm",function(){
	let data = $(this).attr("aria-label").split("-");
	let name = $(this).parent().parent().find(".req_name").text();
	sendData = {post_no:data[0],join_no:data[1],requester:data[2]};
	$.ajax({
		type: 'patch',
		url: 'healthmate/confirm',
		contentType: 'application/json',
		data: JSON.stringify(sendData),
		beforeSend:function(){return confirm(name+"님과 매칭하시겠습니까?");},
		success:function(result){
			alert(result);
			location.replace("healthmate");
		},
		error:function(e){alert(e.responseText);}
	});
});
</script>
</body>
</html>