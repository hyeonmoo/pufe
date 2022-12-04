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
    <title>철좀들어-일정관리</title>
    <link rel="stylesheet" href="${path }/resources/css/menu_trainer2.css">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<h1 id="menuTitle">PT 일정관리</h1>
<div class="container">
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
	<div class="reservations">
		<input type="hidden" id="sendData" name="sendData" value="-">
		<h1><span>일정</span><span id="dateTitle"></span><span>요청</span></h1>
		<div class="uls">
			<ul id="reservationList"></ul>
			<ul id="requestList"></ul>
		</div>
		<div class="buttons">
			<button type="button" id="cancel">예약취소</button>
			<button type="button" id="modifyReservation">예약변경</button>
			<button type="button" id="confirm">예약확정</button>
		</div>
	</div>
</div>
<script>
//통신으로 받은 리스트를 전역에서 쓰기 위해 선언
var listMap = null;

//달력, 시간표 출력
var now= new Date();
var today= new Date();

//실행부
listup();

// 버튼 이벤트
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
// 날짜 클릭 시
$(document).on("click",".date",function(){
	$(".date").removeClass('selected');
	$(this).addClass('selected');
	$("#sendData").val("-");
	now=new Date(nowY,nowM,$(this).find('p:first').text());
	listupBooked(listMap.bookedList);
	listupReqed(listMap.reqedList);
});
//시간 선택 시 이벤트
$(document).on("click",".time",function(){
	$(".time").removeClass("selected");
	$(this).addClass("selected");
	$("#sendData").val($(this).attr("aria-label"));
});
//예약변경 버튼
$(document).on("click","#modifyReservation",function(){
	data = $("#sendData").val();
	if(data=="-") {
		alert("변경할 날짜를 선택해주세요.");
		return;
	}
	ul = $("#requestList");
	ul.children().remove();
	if(data.substring(0,2)!="pt"){
		ul.append("<div id='modifyDiv'>"+
				"<input class='button' type='button' id='disable' value='휴무등록'>"+
				"<input class='button' type='button' id='getBack' value='돌아가기'>");
		$('#modifyDiv').attr("date",data);
	} else{
		ul.append("<div id='modifyDiv'>"+
				"<input class='text' type='date' name='pt_date' required>"+
				"<input class='text' type='number' name='pt_time' placeholder='변경할 시간 입력' min='9' max='20' required>"+
				"<input class='button' type='button' id='modify' value='변경하기'>"+
				"<input class='button' type='button' id='getBack' value='돌아가기'>");
		$('input[name=pt_date]').val(formatDate(now));
		$('#modifyDiv').attr("pt_no",data.substring(2));
	}
});
// ajax 통신
//예약취소 버튼
$(document).on("click","#cancel",function(){
	let data = $("#sendData").val();
	if(data.substring(0,2)!="pt"){
		alert("취소할 일정을 선택해주세요.");
		return;
	}
	pt_no = data.substring(2);
	$.ajax({
		type: 'DELETE',
		url: 'pt/cancel?pt_no='+pt_no,
		beforeSend: function(){return confirm("일정을 취소하시겠습니까?");},
		success: function(msg){
			alert(msg);
			listup();
		},
		error: function(e){alert(e.responseText);}
	});
});
//일정 변경
$(document).on("click","#modify",function(){
	let pt_no = $("#modifyDiv").attr("pt_no");
	let pt_date = $("input[name=pt_date]").val();
	let pt_time = $("input[name=pt_time]").val();
	$.ajax({
		type:'PATCH',
		url: 'pt/modify',
		headers: {"content-type":"application/json"},
		data: JSON.stringify({pt_no:pt_no, pt_date:pt_date, pt_time:pt_time}),
		beforeSend: function(){return confirm("일정을 변경하시겠습니까?");},
		success: function(msg){
			alert(msg);
			listup();
		},
		error: function(e){alert(e.responseText);}
	});
});
//일정 비활성화
$(document).on("click","#disable",function(){
	let date = $("#modifyDiv").attr("date");
	let pt_date = date.split("_")[0];
	let pt_time = date.split("_")[1];
	$.ajax({
		type:'POST',
		url: 'pt/disable',
		headers: {"content-type":"application/json"},
		data: JSON.stringify({pt_date:pt_date, pt_time:pt_time}),
		beforeSend: function(){return confirm("휴무를 등록하시겠습니까?");},
		success: function(msg){
			alert(msg);
			listup();
		},
		error: function(e){alert(e.responseText);}
	});
});
//예약 확정 버튼
$(document).on("click","#confirm",function(){
	let data = $("#sendData").val();
	if(data.substring(0,2)!="pt"){
		alert("일정을 선택해주세요.");
		return;
	}
	pt_no = $("#sendData").val().substring(2);
	$.ajax({
		type:'PATCH',
		url: 'pt/confirm?pt_no='+pt_no,
		beforeSend: function(xhr,opts){return confirm("예약을 확정하시겠습니까?");},
		success:function(msg){
			alert(msg);
			listup();
		},
		error: function(e){alert(e.responseText);}
	});
});
// 돌아가기 버튼
$(document).on("click","#getBack",function(){
	listupReqed(listMap.reqedList);
});

// 함수 선언부
// 일정표 출력
function listup(){	
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	$.ajax({
		type:'get',
		url:'pt',
		success:function(result){
			listMap=result;
			buildCal(listMap);
			listupBooked(listMap.bookedList);
			listupReqed(listMap.reqedList);
		},
		error: function(){alert("페이지 로드에 실패했습니다.");}
	});
}
//달력 출력
function buildCal(listMap){
	bookedList=listMap.bookedList;
	reqedList=listMap.reqedList;
	
	nowY= now.getFullYear();
	nowM= now.getMonth();
	
	firstDay= new Date(nowY,nowM,1).getDay();
	lastDate= new Date(nowY,nowM+1,0).getDate();
	
	if((nowY%4===0 && nowY%100!==0)|| nowY%400===0) lastDate[1]=29;
	
	$("#nowM").text(nowY+"년 "+(nowM+1)+"월");
	$("#calendar>tbody").append("<tr>");
	for(i=0;i<firstDay;i++) $("#calendar>tbody>tr:last").append("<td class='disabled'></td>");
	for(i=1;i<=lastDate;i++){
		nowDate=new Date(nowY,nowM,i);
		plusDate= nowDate.getDay();
		if(plusDate==0) $("#calendar>tbody:last").append("</tr><tr>");
		$("#calendar>tbody>tr:last").append(tdHtml(i,dailyCnt(bookedList,nowDate),dailyCnt(reqedList,nowDate)));
	}
	if($("#calendar>tbody>tr>td").length%7!=0)
		for(i=1;i<=$("#calendar>tbody>tr>td").length%7;i++)
			$("#calendar>tbody>tr:last").append("<td class='disabled'></td>");
	$("#calendar>tbody:last").append("</tr>");
	
	// 각 날짜에 맞는 속성 부여하기(선택불가, 선택된 날짜)
	$(".date").each(function(index,date){
		if(formatDate(today)==formatDate(new Date(nowY,nowM,$(date).find("p:first").text())))
			$(date).attr('id','today');
		if(formatDate(now)==formatDate(new Date(nowY,nowM,$(date).find("p:first").text())))
			$(date).addClass("selected");
	});
}
//예약된 시간표 출력
function listupBooked(bookedList){
	nowDate=formatDate(now);
	ul = $("#reservationList");
	
	ul.children().remove();
	$("#dateTitle").text(nowDate);
	for(i=9;i<21;i++) ul.append(liHtml(nowDate,i,null));
	ul.find(".time").each(function(index,item){
		//예약된 일정이 있을 시
		$(bookedList).each(function(i,booked){
			if(nowDate==booked.pt_date && index==(booked.pt_time-9))
				$(item).replaceWith(liHtml(nowDate,index+9,booked));
		});
	});
}
//해당 날짜의 요청된 예약 출력
function listupReqed(reqedList){
	nowDate=formatDate(now);
	ul = $("#requestList");
	
	ul.children().remove();
	$(reqedList).each(function(index,reqed){
		if(nowDate==reqed.pt_date)
			ul.append(liHtml(nowDate,reqed.pt_time,reqed));
	});
}
//달력의 td 생성함수
function tdHtml(index,bookCnt,reqCnt){
	return '<td class="date"><p>'+index+'</p><p><span class="books">'+bookCnt+'</span> <span class="requests">'+reqCnt+'</span></p></td>';
}
//시간표 li 생성함수
function liHtml(formattedDate,index,item){
	if(item==null) return '<li class="time" aria-label="'+formattedDate+'_'+index+'"><span>'+twoDigits(index)+':00</span><span>-</span></li>';
	pt_no = item.pt_no;
	time = item.pt_time;
	if(item.user_email==null)
		return '<li class="time" aria-label="pt'+pt_no+'"><span>'+twoDigits(index)+':00</span><span>휴무</span></li>';
	else {
		name = item.user_name;
		tel = item.user_tel.substring(7);
		return '<li class="time" aria-label="pt'+pt_no+'"><span>'+twoDigits(index)+':00</span><span><font>No.'+pt_no+'</font>'+name+' 님<font>'+tel+'</font></span></li>';
	}
}
//날짜형식 데이터 포맷
function formatDate(date){
	year= date.getFullYear();
	month= date.getMonth()+1;
	day= date.getDate();
	return [year,twoDigits(month),twoDigits(day)].join("-");
}
//한자릿수 숫자 앞에 0붙이기
function twoDigits(num){
	if(num<10) num="0"+num;
	return num;
}
//해당 날짜의 예약 수 출력함수
function dailyCnt(list,date){
	let cnt=0;
	date=formatDate(date);
	$(list).each(function(index,item){
		if(item.pt_date==date && item.user_name!=null) cnt++;
	});
	return cnt;
}
</script>
</body>
</html>