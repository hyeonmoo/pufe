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
// 모델로 받은 이미 예약된 시간 목록 저장
var bookedList= ${bookedList};
// 유저의 예약정보 리스트
var userList= ${userList};
// 달력, 시간표 출력
var now= new Date();
var today= new Date();

//함수 실행부
refresh(bookedList,userList);

//버튼
// 예약 버튼
$("#reserveBt").click(function(){
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
		headers: {"content-type":"application/json"},
		data: JSON.stringify({pt_date, pt_time}),
		beforeSend: function(xhr,opts){if(!confirm("신청하시겠습니까?")) xhr.abort();},
		success: function(result){
			alert("PT예약신청이 완료됐습니다.");
			bookedList = result[0];
			userList = result[1];
			refresh(bookedList,userList);
		},
		error: function(){alert("error");}
	});
});

// 저번달, 다음달 버튼
$("#prevM").click(function(){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	now = new Date(now.getFullYear(),now.getMonth()-1,now.getDate());
	buildCal(bookedList, userList);
});
$("#nextM").click(function(){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	now= new Date(now.getFullYear(),now.getMonth()+1,now.getDate());
	buildCal(bookedList, userList);
});

//함수 선언부
//날짜형식 데이터 포맷
function dateFm(date){
	year= date.getFullYear();
	month= date.getMonth()+1;
	day= date.getDate();
	
	if(month<10) month="0"+month;
	if(day<10) day="0"+day;
	return [year,month,day].join("-");
}
// 달력 새로고침
function refresh(bookedList,userList){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	buildCal(bookedList, userList);
	buildTimeTable(bookedList,userList);
}
// 달력 만들기
function buildCal(bookedList, userList){
	nowY= now.getFullYear();
	nowM= now.getMonth();
	
	firstDay= new Date(nowY,nowM,1).getDay();
	lastDate= new Date(nowY,nowM+1,0).getDate();
	
	if((nowY%4===0 && nowY%100!==0)|| nowY%400===0) lastDate[1]=29;
	
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
	
	// 각 날짜에 맞는 속성 부여하기(선택불가, 선택된 날짜)
	$(".date").each(function(index){
		if(nowY==today.getFullYear() && nowM==today.getMonth() && $(".date").eq(index).text()==today.getDate())
			$(".date").eq(index).attr('id','today');
		if($(".date").eq(index).text()==now.getDate())
			$(".date").eq(index).addClass('selected');
		if(nowY<today.getFullYear())
			$(".date").eq(index).addClass('disabled');
		if(nowY==today.getFullYear() && nowM<today.getMonth())
			$(".date").eq(index).addClass('disabled');
		if(nowY==today.getFullYear() && nowM==today.getMonth() && $(".date").eq(index).text()<today.getDate())
			$(".date").eq(index).addClass('disabled');
		$(userList).each(function(i,t){
			if(nowY==t['pt_date'].split("-")[0] && nowM==t['pt_date'].split("-")[1]-1 && $(".date").eq(index).text()==t['pt_date'].split("-")[2]){
				if(t['request']=="requested") $(".date").eq(index).addClass('requested');
				else $(".date").eq(index).addClass('booked');
			}
		});
	});
	//날짜 선택 시 이벤트
	$(".date").not(".disabled").click(function(){
		$(".date").removeClass('selected');
		$("#reservDate").val("-");
		$(this).addClass('selected');
		now = new Date(nowY,nowM,$(this).text());
		buildTimeTable(bookedList,userList);
	});
}

// 시간표 만들기
function buildTimeTable(bookedList,userList){
	nowY = now.getFullYear();
	nowM = now.getMonth();
	nowD = now.getDate();
	
	$("#timeTable>tbody td").remove();
	$("#timeTable>tbody>tr").remove();
	
	$("#tableHead").text(nowY+"년 "+(nowM+1)+"월 "+nowD+"일");
	$("#timeTable>tbody").append("<tr>");
	for(i=9;i<21;i++){
		if(i==13 || i==17) $("#timeTable tbody:last").append("</tr><tr>");
		$("#timeTable>tbody>tr:last").append('<td class="time" date="'+dateFm(now)+'" id="'+i+'">'+i+':00</td>');
	}
	$("#timeTable>tbody:last").append("</tr>");

	//이미 예약된 시간, 현재시각 기준 1시간후까지 비활성화
	rightNow = dateFm(new Date());
	rightNowH = new Date().getHours();
	$(".time").each(function(index,item){
		$(bookedList).each(function(i,t) {
			if($(item).attr("date")==t['pt_date'] && $(item).attr("id")==t['pt_time'])
				$(item).addClass("disabled");
		});
		$(userList).each(function(i,t){
			if($(item).attr("date")==t['pt_date'] && $(item).attr("id")==t['pt_time']){
				$(".time").addClass("disabled");
				if(t['request']=="requested") $(item).addClass("requested");
				else $(item).addClass("booked");
			}
		});
		if($(item).attr("date")==rightNow)
			if(parseInt($(item).attr("id"))<=parseInt(rightNow)+1)
				$(item).addClass("disabled");
	});
	// 시간 선택 시 이벤트
	$(".time").not(".disabled").click(function(){
		$(".time").removeClass("selected");
		$(this).addClass('selected');
		$("#reservDate").val($(this).attr("date")+"_"+$(this).attr("id"));
	});
}
</script>
</body>
</html>