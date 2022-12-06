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
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<%@ include file="navMenu.jsp"%>
<div class="container">
	<form action="" id="form">
		<h4>${mode=="write"? "글쓰기": ""}</h4>
		<hr>
		<input type="hidden" id="rec_num" name="rec_num" readonly value=${recommend.rec_num }>
		<input type="text" id="rec_title" name="rec_title" placeholder="제목을 입력해주세요." value="${recommend.rec_title }" ${mode=="write"?'':'readonly="readonly"' }><br>
		<textarea name="rec_content" id="rec_content" placeholder="내용을 입력하세요." cols="30" rows="10" ${mode=="write"?'':'readonly="readonly"' }>${recommend.rec_content }</textarea>
		<div class="button">
			<c:if test='${user.user_type=="A"||user.user_type=="T" }'>
				<input type="${mode=='write'?'button':'hidden' }" id="writeBt" value="등록">
			</c:if>
				<input type="${mode=='read'?'button':'hidden' }" name="modifyBt" id="modifyBt" value="수정"> 
				<input type="${mode=='read'?'button':'hidden' }" name="removeBt" id="removeBt" value="삭제">
			<input type="button" id="listBt" value="목록">
		</div>
		<hr>
		<%@ include file="rec_comment.jsp"%>
	</form>	
</div>
<script>
if("${msg}"!="") alert("${msg}");
if("${recommend.user_email}"!="${sessionScope.email}"){
	var modifyBt = document.getElementsByName("modifyBt")[0];
	modifyBt.setAttribute('type', 'hidden');
	if("${user.user_type}"!="A"||"${user.user_type}"!="T"){
		var removeBt = document.getElementsByName("removeBt")[0];
		removeBt.setAttribute('type', 'hidden');
	}
};
$("#listBt").on('click',function(){
	window.location="<c:url value='/recommend'/>${searchCondition.queryString}";
});

$("#removeBt").on('click',function(){
	if(!confirm("게시물을 삭제하겠습니까?")) return;
	let form=document.getElementById('form');
	form.action="<c:url value='/recommend/remove'/>${searchCondition.queryString}";
	form.method="post";
	form.submit();
});
$("#writeBt").on('click',function(){
	if($('#rec_title').val().length==0){
		alert("제목을 입력하세요");
		return false;
	}
	if(!confirm("게시물을 등록하시겠습니까?")) return;
	let form = document.getElementById('form');
	form.action="<c:url value='/recommend/write'/>";
	form.method="post";
	form.submit();
});
$("#modifyBt").on('click',function(){
	if(!confirm("게시물을 수정하시겠습니까?")) return;
	let form = document.getElementById('form');
	let title = document.getElementById('rec_title');
	let content = document.getElementById('rec_content');
	let isReadOnly = title.readOnly;
	console.log(isReadOnly)
	if(isReadOnly){
		title.readOnly=false;
		content.readOnly=false;
		document.getElementById('modifyBt').value="등록";
		return;
	}
	form.action="<c:url value='/recommend/modify'/>${searchCondition.queryString}";
	form.method="post";
	form.submit();
});
</script>
</body>
</html>