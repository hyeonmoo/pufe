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
    <title>철좀들어-PT예약</title>
    <link rel="stylesheet" href="${path }/resources/css/menu_user2.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
<h1>PT예약</h1>
<table id="calendar">
	<thead>
		<tr>
			<th id="prevM" align="center" colspan=2>&lang;</th>
			<th id="nowM" align="center" colspan=3></th>
			<th id="nextM" align="center" colspan=2>&rang;</th>
		</tr>
		<tr>
			<th style="color:rgb(255,70,70);">일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th style="color:rgb(70,150,255);">토</th>
		</tr>
	</thead>
	<tbody></tbody>
</table>
<table id="timeTable">
	<thead>
		<tr><th id="tableHead" colspan=4></th></tr>
	</thead>
	<tbody></tbody>
	<tfoot>
		<tr><td colspan=4>
			<input type="hidden" id="reservDate" value="-">
			<input type="button" id="reserveBt" value="예약하기">
		</td></tr>
	</tfoot>
</table>
</div>

<script>
// 달력, 시간표 출력
var now= new Date();
var today= new Date();
// 리스트맵을 변수에 저장
var listMap=null;
//함수 실행부
listup();

//버튼
// 예약 버튼
$(document).on("click","#reserveBt",function(){
	dateTime=$("#reservDate").val();
	if(dateTime=="-"){
		alert("예약할 날짜를 선택해주세요.");
		return;
	}
	pt_date = dateTime.split("_")[0];
	pt_time = dateTime.split("_")[1];
	$.ajax({
		type: 'POST',
		url:'/pufe/pt/reservation',
		contentType: 'application/json',
		data: JSON.stringify({pt_date:pt_date, pt_time:pt_time}),
		beforeSend: function(){return confirm("신청하시겠습니까?");},
		success: function(msg){
			alert(msg);
			listup();
		},
		error: function(e){alert(e.responseText);}
	});
});

// 저번달, 다음달 버튼
$(document).on("click","#prevM",function(){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	now = new Date(now.getFullYear(),now.getMonth()-1,now.getDate());
	listup();
});
$(document).on("click","#nextM",function(){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	now= new Date(now.getFullYear(),now.getMonth()+1,now.getDate());
	listup();
});

//날짜 선택 시 이벤트
$(document).on("click",".date:not('.disabled')",function(){
	$(".date").removeClass('selected');
	$("#reservDate").val("-");
	$(this).addClass('selected');
	now = new Date(nowY,nowM,$(this).text());
	buildTimeTable(listMap);
});
// 시간 선택 시 이벤트
$(document).on("click",".time:not('.disabled')",function(){
	$(".time").removeClass("selected");
	$(this).addClass('selected');
	$("#reservDate").val($(this).attr("date")+"_"+$(this).attr("time"));
});
//함수 선언부
//날짜형식 데이터 포맷
function formatDate(date){
	year= date.getFullYear();
	month= date.getMonth()+1;
	day= date.getDate();
	return [year,twoDigits(month),twoDigits(day)].join("-");
}
//숫자 포맷(한자리 숫자 앞에 0붙이기)
function twoDigits(num){
	if(num<10) num="0"+num;
	return num;
}
// 달력 새로고침
function listup(){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	
	$.ajax({
		type:'get',
		url:'pt',
		success: function(result){
			listMap = result;
			buildCal(listMap);
			buildTimeTable(listMap);
		},
		error: function(){alert("페이지 로드에 실패했습니다.");}
	});
}
// 달력 만들기
function buildCal(listMap){
	bookedList=listMap.bookedList;
	userList=listMap.userList;
	
	nowY= now.getFullYear();
	nowM= now.getMonth();
	
	firstDay= new Date(nowY,nowM,1).getDay();
	lastDate= new Date(nowY,nowM+1,0).getDate();
	
	if((nowY%4===0 && nowY%100!==0)|| nowY%400===0) lastDate[1]=29;
	
	// 현재 년,월 표시
	$("#nowM").text(nowY+"년 "+(nowM+1)+"월");
	$("#calendar>tbody").append("<tr>");
	for(i=0;i<firstDay;i++) $("#calendar>tbody>tr:last").append("<td class='disabled'></td>");
	for(i=1;i<=lastDate;i++){
		plusDate= new Date(nowY,nowM,i).getDay();
		if(plusDate==0) $("#calendar>tbody:last").append("</tr><tr>");
		$("#calendar>tbody>tr:last").append("<td class='date' align='center'>"+i+"</td>");
	}
	if($("#calendar>tbody>tr>td").length%7!=0)
		for(i=1;i<=$("#calendar>tbody>tr>td").length%7;i++)
			$("#calendar>tbody>tr:last").append("<td class='disabled'></td>");
	$("#calendar>tbody:last").append("</tr>");
	
	$(".date").each(function(index,date){
		//오늘 날짜 표시, 자동 선택
		if(formatDate(today)==formatDate(new Date(nowY,nowM,$(date).text()))){
			$(date).attr('id','today');
			$(date).addClass("selected");
		}
		//이전 날짜 비활성화
		if(new Date(formatDate(today))>new Date(formatDate(new Date(nowY,nowM,$(date).text()))))
			$(date).addClass("disabled");
		//유저가 예약/신청한 날짜 표시
		$(userList).each(function(i,d){
			if(formatDate(new Date(d.pt_date))==formatDate(new Date(nowY,nowM,$(date).text())))
				$(date).addClass(d.request);
		});
	});
}

// 시간표 만들기
function buildTimeTable(listMap){
	bookedList=listMap.bookedList;
	userList=listMap.userList;
	
	nowY = now.getFullYear();
	nowM = now.getMonth();
	nowD = now.getDate();
	
	$("#timeTable>tbody td").remove();
	$("#timeTable>tbody>tr").remove();
	
	// 시간표 상단부에 선택한 날짜 년월일 출력
	$("#tableHead").text(nowY+"년 "+(nowM+1)+"월 "+nowD+"일");
	
	// 시간표에 선택한 날짜와 해당 시간을 속성으로 부여하면서 생성
	$("#timeTable>tbody").append("<tr>");
	for(i=9;i<21;i++){
		if(i==13 || i==17) $("#timeTable tbody:last").append("</tr><tr>");
		$("#timeTable>tbody>tr:last").append('<td class="time" date="'+formatDate(now)+'" time="'+i+'">'+twoDigits(i)+':00</td>');
	}
	$("#timeTable>tbody:last").append("</tr>");

	// 각 시간 속성 추가
	$(".time").each(function(index,datetime){
		// 현재시각 기준 1시간 이후까지 예약 비활성화
		if($(datetime).attr("date")==formatDate(today))
			if($(datetime).attr("time")<=(today.getHours+1))
				$(datetime).addClass("disabled");
		// 다른 사람이 예약한 시간 비활성화
		$(bookedList).each(function(i,dt) {
			if($(datetime).attr("date")==formatDate(new Date(dt.pt_date)) && $(datetime).attr("time")==dt.pt_time)
				$(datetime).addClass("disabled");
		});
		// 자신이 예약하거나 요청한 시간 표시
		$(userList).each(function(i,dt){
			if($(datetime).attr("date")==formatDate(new Date(dt.pt_date)) && $(datetime).attr("time")==dt.pt_time){
				$(".time").addClass("disabled");
				$(datetime).addClass(dt.request);
			}
		});
	});
}
</script>
</body>
</html>