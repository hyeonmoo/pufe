<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>철좀들어-추천정보</title>
<link rel="stylesheet" href="${path }/resources/css/machineRegist.css">
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
				<input required type="text" id="mch_name" name="mch_name" value="${machine.mch_name}">
			</td>
		</tr>
		<tr>
			<th>모델명/품번</th>
			<th>입고날짜</th>
		</tr>
		<tr>
			<td><input required type="text" id="mch_serial" name="mch_serial" maxlength=9 placeholder="모델명/품번" value="${machine.mch_serial}"></td>
			<td><input required type="date" id="mch_date" name="mch_date"></td>
		</tr>
		<tr>
			<th>기구정보</th>
			<th>세부정보</th>
		</tr>
		<tr>
			<td><textarea required rows="7" cols="35" id="mch_info" name="mch_info" placeholder="기구 정보를 입력하세요.">${machine.mch_info}</textarea></td>
			<td><textarea required rows="7" cols="35" id="mch_detail" name="mch_detail" placeholder="기구 세부사항을 입력하세요.">${machine.mch_detail }</textarea></td>
		</tr>
		<tr>
			<th colspan="2">기구사진</th>
		</tr>
		<tr>
			<td colspan="2">
				<input type="file" name="uploadFile" id="uploadFile"/>
				<label for="fileName" id="showFileName"></label>
				<input type="hidden" id="fileName" name="fileName" value="${path+='/uploadImgs'+=machine.mch_img}">
				<input type='hidden' name="imgMode" id="imgMode" value=0>
			</td>
		</tr>
	</table>
	<div class="button">
		<input type="${mode=='write'?'button':'hidden' }" class="btn" id="writeBt" name="writeBt" value="등록">
		<input type="${mode=='write'?'hidden':'button' }" class="btn" id="modifyBt" name="modifyBt" value="수정">
		<input type="button" class="btn" id="listBt" value="목록">
	</div>
</div>
</form>
<script>
if("${msg}"!="") alert("${msg}");
$('#showFileName').text($("#fileName").val().split("_")[1]);
$('#uploadFile').on('change', function() {
	$('#showFileName').text($(this).val());
});
var today=new Date();
var mch_date="${machine.mch_date}"
$("#mch_date").val(mch_date);
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
$("#listBt").on('click',function(){
	location.replace("<c:url value='/menu2'/>${searchCondition.queryString}");
});
$('#writeBt').on("click", function(){
	if(!confirm("게시물을 등록하시겠습니까?")) return;
	let formData = new FormData();
	let inputFiles = $("input[name='uploadFile']")[0].files;
	if(inputFiles.length!=0){
		if(!checkExtension(inputFiles[0].name, inputFiles[0].size)) return;
		formData.append("uploadFile", inputFiles[0]);
	}
	
	let form = document.getElementById("form");
	form.action="<c:url value='/facility/write'/>";
	form.method="post";
	form.submit();
});

$('#modifyBt').click(function(){
	let formData = new FormData();
	let inputFiles = $("input[name='uploadFile']")[0].files;
	let fileName = $("#showFileName").text();
	if(inputFiles.length==0&&fileName.length==0){
		$('#imgMode').val("empty");
	} else if(inputFiles.length==0&&fileName.lengh!=0){
		$('#imgMode').val("original");
	} else{
		$('#imgMode').val("change");
		if(!checkExtension(inputFiles[0].name, inputFiles[0].size)) return;
		formData.append("uploadFile", inputFiles[0]);
	}
	modify();
});
function modify(){
	var form = document.getElementById('form');
	form.action="<c:url value='/facility/modify'/>${searchCondition.queryString}"; 
	form.method="post";
	form.submit();
}
</script>
</body>
</html>



