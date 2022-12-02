<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>철좀들어-추천정보</title>
<link rel="stylesheet" href="${path }/resources/css/board_recommend.css">
</head>
<body>
	<%@ include file="navMenu.jsp"%>

	<form action=""  id="form"  >
		<h4>${mode=="write"? "머신 등록": ""}</h4>
		<div class="a"></div>
		<input type="text" id="mch_num" name="mch_num" 
			value=${machine.mch_num } ${mode=="write"?'':'readonly="readonly"' }>
			<input type="text" id="mch_name" name="mch_name" 
			value=${machine.mch_name } ${mode=="write"?'':'readonly="readonly"' }>
			<input type="text" id="mch_img" name="mch_img"
			placeholder="이미지를 입력하세요." value=${machine.mch_img }
			${mode=="write"?'':'readonly="readonly"' }><br>
			<input type="text" id="mch_serial" name="mch_serial"
			placeholder="기구 시리얼 넘버를 입력하세요." value=${machine.mch_serial }
			${mode=="write"?'':'readonly="readonly"' }><br>
			<input type="date" id="mch_date" name="mch_date"
			placeholder="기구 입고 날짜를 입력하세요." value=${machine.mch_date }
			${mode=="write"?'':'readonly="readonly"' }><br>
			<input type="text" id="mch_info" name="mch_info"
			placeholder="기구 정보를 입력하세요." value=${machine.mch_info }
			${mode=="write"?'':'readonly="readonly"' }><br>
			<input type="text" id="mch_detail" name="mch_detail"
			placeholder="기구 세부사항을 입력하세요." value=${machine.mch_detail }
			${mode=="write"?'':'readonly="readonly"' }><br>
			
		<div class="button">

			<input type="${mode=='write'?'button':'hidden' }" class="btn " id="writeBt" value="등록"> 
			<input type="${mode=='read'?'button':'hidden' }" class="btn " id="modifyBt" value="수정"> 
			<input type="${mode=='read'?'button':'hidden' }" class="btn " id="removeBt" value="삭제"> 
			<input type="${mode=='read'?'button':'hidden' }" class="btn " id="listBt" value="목록">
		</div>
	
	</form>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
	document.getElementById("listBt").addEventListener('click',e=>{
		window.location="<c:url value='/test'/>${searchCondition.queryString}";
	});
	
	document.getElementById("removeBt").addEventListener('click',e=>{
		if(!confirm("게시물을 삭제하겠습니까?")) return;
		let form=document.getElementById('form');
		form.action="<c:url value='/test/remove'/>${searchCondition.queryString}";
		form.method="post";
		form.submit();
	});
	
	document.getElementById("writeBt").addEventListener('click',e=>{
		alert($('#mch_name').val())
		if($('#mch_name').val().length==0){
			alert("제목을 입력하세요");
			return false;
		}
		if(!confirm("게시물을 등록하시겠습니까?")) return;
		

		let form = document.getElementById('form');
		form.action="<c:url value='/test/write'/>";
		form.method="post";
		form.submit();
	});
	
	document.getElementById("modifyBt").addEventListener('click',e=>{
		if(!confirm("게시물을 수정하시겠습니까?")) return;
		let form = document.getElementById('form');
		let name = document.getElementById('mch_name');
		let img = document.getElementById('mch_img');
		let serial = document.getElementById('mch_serial');
		let info = document.getElementById('mch_info');
		let detail = document.getElementById('mch_detail');
		let date = document.getElementById('mch_date');
		
		let isReadOnly = name.readOnly;
	
		console.log(isReadOnly)
		if(isReadOnly){
			name.readOnly=false;
			img.readOnly=false;
			serial.readOnly=false;
			info.readOnly=false;
			detail.readOnly=false;
			date.readOnly=false;
			
		
			document.getElementById('modifyBt').value="등록";
			return;
		}
		form.action="<c:url value='/test/modify'/>${searchCondition.queryString}";
		form.method="post";
		form.submit();
	});
	
	let msg = "${msg}";
	if(msg=="write_error") alert("게시글 등록에 실패했습니다. 다시 작성해주세요.");
	


	
</script>
</body>
</html>



