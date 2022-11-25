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
		<input type="hidden" id="selectedData" name="selectedData" value="-">
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
//컨트롤러로 받은 리스트 저장
bookedList = ${bookeds};
reqedList = ${reqeds};

//달력, 시간표 출력
var now= new Date();
var today= new Date();

//실행부
refresh(bookedList,reqedList);

// 버튼 이벤트
// 저번달, 다음달 버튼
$("#prevM").click(function(){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	now = new Date(now.getFullYear(),now.getMonth()-1,now.getDate());
	buildCal(bookedList,reqedList);
});
$("#nextM").click(function(){
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	now= new Date(now.getFullYear(),now.getMonth()+1,now.getDate());
	buildCal(bookedList,reqedList);
});
//예약취소 버튼
$('#cancel').click(function(){
	let data = $("#selectedData").val();
	if(data=="-" || data.substring(0,2)!="pt"){
		alert("취소할 일정을 선택해주세요.");
		return;
	}
	pt_no = data.substring(2);
	$.ajax({
		type: 'DELETE',
		url: '/pufe/pt/cancel?pt_no='+pt_no,
		beforeSend: function(xhr,opts){if(!confirm("일정을 취소하시겠습니까?")) xhr.abort();},
		success: function(result){
			alert('일정이 취소되었습니다.');
			bookedList=result[0];
			reqedList=result[1];
			refresh(bookedList,reqedList);
		},
		error: function(){alert('취소에 실패했습니다.')}
	});
});
//예약변경 버튼
$('#modifyReservation').click(function(){
	data = $("#selectedData").val();
	if(data=="-") {
		alert("변경할 날짜를 선택해주세요.");
		return;
	}
	ul = $("#requestList");
	ul.children().remove();
	if(data.substring(0,2)!="pt"){
		ul.append("<div id='modifyDiv'>"+
				"<input class='button' type='button' id='disable' value='비활성화'>"+
				"<input class='button' type='button' id='getBack' value='돌아가기'>");
		$('#modifyDiv').attr("date",data);
	} else{
		ul.append("<div id='modifyDiv'>"+
				"<input class='text' type='date' name='pt_date' required>"+
				"<input class='text' type='number' name='pt_time' placeholder='변경할 시간 입력' min='9' max='20' required>"+
				"<input class='button' type='button' id='modify' value='변경하기'>"+
				"<input class='button' type='button' id='getBack' value='돌아가기'>");
		$('input[name=pt_date]').val(dateFm(now).split("_")[0]);
		$('#modifyDiv').attr("pt_no",data.substring(2));
	}
	// 돌아가기 버튼
	$('#getBack').click(function(){
		requestList(reqedList);
	});
	//ajax 통신
	//일정 변경
	$("#modify").click(function(){
		let pt_no = $("#modifyDiv").attr("pt_no");
		let pt_date = $("input[name=pt_date]").val();
		let pt_time = $("input[name=pt_time]").val();
		$.ajax({
			type:'PATCH',
			url: '/pufe/pt/modify',
			headers: {"content-type":"application/json"},
			data: JSON.stringify({pt_no:pt_no, pt_date:pt_date, pt_time:pt_time}),
			beforeSend: function(xhr,opts){if(!confirm("일정을 변경하시겠습니까?")) xhr.abort();},
			success: function(result){
				alert("일정이 변경되었습니다.");
				bookedList=result[0];
				reqedList=result[1];
				refresh(bookedList,reqedList);
			},
			error: function(){alert("변경에 실패했습니다.");}
		});
	});
	//일정 비활성화
	$("#disable").click(function(){
		let date = $("#modifyDiv").attr("date");
		let pt_date = date.split("_")[0];
		let pt_time = date.split("_")[1];
		$.ajax({
			type:'POST',
			url: '/pufe/pt/disable',
			headers: {"content-type":"application/json"},
			data: JSON.stringify({pt_date:pt_date, pt_time:pt_time}),
			beforeSend: function(xhr,opts){if(!confirm("휴무를 등록하시겠습니까?")) xhr.abort();},
			success: function(result){
				alert("휴무가 등록되었습니다.");
				bookedList=result[0];
				reqedList=result[1];
				refresh(bookedList,reqedList);
			},
			error: function(){alert("등록에 실패했습니다.");}
		});
	});
});
//예약 확정 버튼
$("#confirm").click(function(){
	pt_no = $("#selectedData").val().substring(2);
	$.ajax({
		type:'PATCH',
		url: '/pufe/pt/confirm?pt_no='+pt_no,
		beforeSend: function(xhr,opts){if(!confirm("확정하시겠습니까?")) xhr.abort();},
		success:function(result){
			bookedList=result[0];
			reqedList=result[1];
			refresh(bookedList,reqedList);
		},
		error: function(){alert("확정에 실패했습니다.");}
	});
});

// 함수 선언부
// 일정표 출력
function refresh(bookedList,reqedList){	
	$("#calendar>tbody td").remove();
	$("#calendar>tbody tr").remove();
	buildCal(bookedList,reqedList);
	reservationList(bookedList);
	requestList(reqedList);
}
//날짜형식 데이터 포맷
function dateFm(date){
	year= date.getFullYear();
	month= date.getMonth()+1;
	day= date.getDate();
	hour= date.getHours();
	
	if(month<10) month="0"+month;
	if(day<10) day="0"+day;
	
	return [year,month,day].join("-")+"_"+hour;
}
//달력 출력
function buildCal(bookedList,reqedList){	
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
		nowDate=nowY+"-"+(nowM+1)+"-"+i;
		$("#calendar>tbody>tr:last").append(tdHtml(i,dailyCnt(bookedList,nowDate),dailyCnt(reqedList,nowDate)));
	}
	if($("#calendar>tbody>tr>td").length%7!=0)
		for(i=1;i<=$("#calendar>tbody>tr>td").length%7;i++)
			$("#calendar>tbody>tr:last").append("<td class='disabled'></td>");
	$("#calendar>tbody:last").append("</tr>");
	
	// 각 날짜에 맞는 속성 부여하기(선택불가, 선택된 날짜)
	$(".date").each(function(index){
		if(nowY==today.getFullYear() && nowM==today.getMonth() && $(".date").eq(index).find("p:first").text()==today.getDate())
			$(".date").eq(index).attr('id','today');
		if($(".date").eq(index).find("p:first").text()==now.getDate())
			$(".date").eq(index).addClass('selected');
	});
	// 날짜 클릭 시
	$(".date").click(function(){
		$(".date").removeClass('selected');
		$(this).addClass('selected');
		$("#selectedData").val("-");
		now=new Date(nowY,nowM,$(this).find('p:first').text());
		reservationList(bookedList);
		requestList(reqedList);
	});
}
//예약된 시간표 출력
function reservationList(bookedList){
	nowDate=dateFm(now).split('_')[0];
	ul = $("#reservationList");
	
	ul.children().remove();
	$("#dateTitle").text(nowDate);
	for(i=9;i<21;i++) ul.append(liHtml(nowDate,i,null));
	ul.find(".time").each(function(index,item){
		//예약된 일정이 있을 시
		$(bookedList).each(function(i,booked){
			if(nowDate==booked['pt_date'] && index==booked['pt_time']-9)
				$(item).replaceWith(liHtml(nowDate,index+9,booked));
		});
	});
	//시간 선택 시 이벤트
	ul.find(".time").click(function(){
		$(".time").removeClass("selected");
		$(this).addClass("selected");
		$("#selectedData").val($(this).attr("id"));
	});
}
//해당 날짜의 요청된 예약 출력
function requestList(reqedList){
	nowDate=dateFm(now).split('_')[0];
	ul = $("#requestList");
	
	ul.children().remove();
	$(reqedList).each(function(index,reqed){
		if(nowDate==reqed['pt_date'])
			ul.append(liHtml(nowDate,reqed['pt_time'],reqed));
	});
	//시간 선택 시 이벤트
	ul.find(".time").click(function(){
		$(".time").removeClass("selected");
		$(this).addClass("selected");
		$("#selectedData").val($(this).attr("id"));
	});
}
//달력의 td 생성함수
function tdHtml(index,book,req){
	return '<td class="date"><p>'+index+'</p><p><span class="books">'+book+'</span> <span class="requests">'+req+'</span></p></td>';
}
//시간표 li 생성함수
function liHtml(date,index,array){
	if(array==null) return '<li class="time" id="'+date+'_'+index+'"><span>'+index+':00</span><span>-</span></li>';
	pt_no = array['pt_no'];
	time = array['pt_time'];
	name = array['user_name'];
	tel = array['user_tel'];
	if(name=='null') return '<li class="time" id="pt'+pt_no+'"><span>'+index+':00</span><span>휴무</span></li>';
	return '<li class="time" id="pt'+pt_no+'"><span>'+index+':00</span><span><font>No.'+pt_no+'</font>'+name+' 님<font>'+tel+'</font></span></li>';
}
//해당 날짜의 예약 수 출력함수
function dailyCnt(arr,date){
	let cnt=0;
	month = date.split('-')[1];
	day = date.split('-')[2];
	if(month<10) month="0"+month;
	if(day<10) day="0"+day;
	date=date.split('-')[0]+"-"+month+"-"+day;
	$(arr).each(function(i,t){
		if(t['pt_date']==date){
			if(t['user_name']==null || t['user_name']=='null') return;
			else cnt++;
		}
	});
	return cnt;
}
</script>
</body>
</html>