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
<div class="container">
	<form action="" id="form">
		<h4>${mode=="write"? "글쓰기": ""}</h4>
		<div class="a"></div>
		<input type="hidden" id="rec_num" name="rec_num" readonly
			value=${recommend.rec_num }> <input type="text"
			id="rec_title" name="rec_title" placeholder="제목을 입력해주세요."
			value=${recommend.rec_title }
			${mode=="write"?'':'readonly="readonly"' }><br>
		<textarea name="rec_content" id="rec_content" placeholder="내용을 입력하세요."
			cols="30" rows="10" ${mode=="write"?'':'readonly="readonly"' }>${recommend.rec_content }</textarea>
		<div class="button">

			<input type="${mode=='write'?'button':'hidden' }" class="btn " id="writeBt" value="등록"> 
			<input type="${mode=='read'?'button':'hidden' }" class="btn " id="modifyBt" value="수정"> 
			<input type="${mode=='read'?'button':'hidden' }" class="btn " id="removeBt" value="삭제"> 
			<input type="${mode=='read'?'button':'hidden' }" class="btn " id="listBt" value="목록">
			
			
		</div>
		<div class="a"></div>
		
		<%@ include file="rec_comment.jsp"%>
		
		
	</form>
	
	
	
	
	</div>
	
	
	
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
	document.getElementById("listBt").addEventListener('click',e=>{
		window.location="<c:url value='/recommend'/>${searchCondition.queryString}";
	});
	
	document.getElementById("removeBt").addEventListener('click',e=>{
		if(!confirm("게시물을 삭제하겠습니까?")) return;
		let form=document.getElementById('form');
		form.action="<c:url value='/recommend/remove'/>${searchCondition.queryString}";
		form.method="post";
		form.submit();
	});
	
	document.getElementById("writeBt").addEventListener('click',e=>{
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
	
	document.getElementById("modifyBt").addEventListener('click',e=>{
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
	
	let msg = "${msg}";
	if(msg=="write_error") alert("게시글 등록에 실패했습니다. 다시 작성해주세요.");
	


	
</script>
</body>
</html>