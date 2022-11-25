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
<link rel="stylesheet" href="${path }/resources/css/board_machines_regist.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<%@ include file="navMenu.jsp"%>
<form action="" id="form" enctype="multipart/form-data">
<div class="container">
	<h1>${mode=="write"? "기구 등록": "기구정보 수정"}</h1>
	<table>
		<tr>
			<th colspan="2">기구이름</th>
		</tr>
		<tr>
			<td colspan="2">
				<input type="hidden" id="mch_num" name="mch_num" value=${machine.mch_num }>
				<input required type="text" id="mch_name" name="mch_name" value="${machine.mch_name}" ${mode=="write"?'':'readonly'}>
			</td>
		</tr>
		<tr>
			<th>시리얼번호</th>
			<th>입고날짜</th>
		</tr>
		<tr>
			<td><input required type="text" id="mch_serial" name="mch_serial" placeholder="시리얼 넘버를 입력하세요." value="${machine.mch_serial}" ${mode=="write"?'':'readonly'}></td>
			<td><input required type="date" id="mch_date" name="mch_date" placeholder="기구 입고 날짜를 입력하세요." value="${machine.mch_date}" ${mode=="write"?'':'readonly' }></td>
		</tr>
		<tr>
			<th>기구정보</th>
			<th>세부정보</th>
		</tr>
		<tr>
			<td><textarea required rows="7" cols="35" id="mch_info" name="mch_info" placeholder="기구 정보를 입력하세요." ${mode=="write"?'':'readonly' }>${machine.mch_info}</textarea></td>
			<td><textarea required rows="7" cols="35" id="mch_detail" name="mch_detail" placeholder="기구 세부사항을 입력하세요." ${mode=="write"?'':'readonly="readonly"' }> ${machine.mch_detail }</textarea></td>
		</tr>
		<tr>
			<th colspan="2">기구사진</th>
		</tr>
		<tr>
			<td colspan="2">
				<input type="file" name="uploadFile" id="uploadFile"/>
				<label for="fileName" id="showFileName"></label>
				<input type="hidden" id="fileName" name="fileName" value="${machine.mch_img }">
				<input type='hidden' name="del" id="del" value=0>
			</td>
		</tr>
	</table>
	<div class="button">
		<input type="${mode=='write'?'button':'hidden' }" class="btn" id="writeBt" name="writeBt" value="등록">
		<input type="${mode=='write'?'button':'hidden' }" class="btn" id="modifyBt" name="modifyBt" value="수정">
		<input type="${mode=='write'?'button':'hidden' }" class="btn" id="listBt" value="목록">
	</div>
</div>
</form>
<script>
$('#showFileName').text($("#fileName").val().split("_")[1]);
$('#uploadFile').on('change', function() {
	$('#showFileName').text($(this).val());
});

function checkExtension(fileName, fileSize){
	let regex = new RegExp("(.*)\.(exe|sh|zip|alz)$");
	let maxSize =5242880;
	
	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
	if(regex.test(fileName)){
		alert("해당 확장자를 가진 파일은 업로드할 수 없습니다.");
		return false;
	}
	return true;
}

$('#writeBt').click(function(){
	if(!confirm("게시물을 등록하시겠습니까?")) return;
	
	let formData = new FormData();
	let files = $("#uploadFile")[0].files;
	
	if(!checkExtension(files.name, files.size)) return;
	formData.append("uploadFile", files);
	
	var form = document.getElementById('form');
	form.action="<c:url value='/facility/write'/>";
	form.method="post";
	form.submit();
});

$('#modifyBt').click(function(){
	if(!confirm("수정하시겠습니까?")) return;
	
	let formData = new FormData(); 
	let files = $("#uploadFile")[0].files;
	let fileName = $("#fileName").val();
	
	if(files.length==0&&fileName.lengh!=0) $('#del').val(1);
	else{
		if(!checkExtension(files.name, files.size)) return;
		formData.append("uploadFile", files);
	}
	var form = document.getElementById('form');
	form.action="<c:url value='/facility/modify'/>${searchCondition.queryString}"; 
	form.method="post";
	form.submit();
});

document.getElementById("listBt").addEventListener('click',e=>{
	window.location="<c:url value='/facility'/>${searchCondition.queryString}";
});
	
let msg = "${msg}";
if(msg=="write_error") alert("게시글 등록에 실패했습니다. 다시 작성해주세요.");

let query = window.location.search; 
let param = new URLSearchParams(query);
if(param.get("mode")=='modi'){
	var writeBt = document.getElementsByName("writeBt")[0];
	writeBt.setAttribute('type', 'hidden');
}
if(param.get("mode")=='write'){
	var modifyBt = document.getElementsByName("modifyBt")[0];
	modifyBt.setAttribute('type', 'hidden');
}
</script>
</body>
</html>



