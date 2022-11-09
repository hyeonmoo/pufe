
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.net.URLDecoder" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>

 <link rel="stylesheet" href="${path }/resources/css/navMenu.css">
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
#form {
	margin-top: 100px;
	width: 700px;
	margin-left: auto;
	margin-right: auto;
}

#content {
	margin-top: 10px;
	border: 0.2px solid rgb(199, 194, 194);
	width: 680px;
	height: 500px;
}

#content:focus {
	outline: none;
}

#title {
	border: 0.2px solid rgb(199, 194, 194);
	width: 680px;
	height: 40px;
}

#title:focus {
	outline: none;
}

.button {
	margin-top: 10px;
	display: flex;
	justify-content: end;
	width: 680px;
}

.a {
	border-bottom: 3px solid black;
	margin-bottom: 10px;
	margin-top: 10px;
	width: 680px;
}

.btn {
	border-radius: 10px;
	background-color: #121212;
	color: white;
	font-size: 11px;
	padding: 5px;
}

textarea {
	padding: 20px;
}

input {
	padding: 0 0 0 10px;
}
</style>
</head>
<body>
<%@ include file="navMenu.jsp" %>


	<form action="" id="form"  onsubmit="return formCheck(this)">
		<h4>게시물 ${mode=="new"? "글쓰기": "읽기"}</h4>

		<div class="a"></div>


		<input type="hidden" name="bno" value="${boardDto.bno }"> <input
			type="text" id="title" name="title" value="${boardDto.title }"
			${mode=="write"? '':'readonly="readonly" ' }
			placeholder="제목을 입력해 주세요."> <br>
		<textarea name="content" id="content" cols="30" rows="10"
			${mode=="write"? '':'readonly="readonly" ' } placeholder="내용을 입력하세요.">${boardDto.content }</textarea>
		<div class="button">

			<input type=${mode=='read'?'button':'hidden'} id="modifyBtn"
				class="btn" value="수정"> <input
				type=${mode=='read'?'button':'hidden'} id="removeBtn" class="btn"
				value="삭제"> <input type=${mode=='read'?'button':'hidden'}
				id="listBtn" class="btn" value="목록"> 
				<input type=${mode=='write'?'button':'hidden'} id="writeBtn" class="btn"
				value="등록">
		</div>

		<script>
document.getElementById('listBtn').addEventListener('click',e=>{window.location="<c:url value='/board/list'/>${searchCondition.queryString}"});



document.getElementById('removeBtn').addEventListener('click',e=>{
if(!confirm("삭제?")) return;
var form = document.getElementById('form');
form.action="<c:url value='/board/remove'/>${searchCondition.queryString}";
form.method="post";
form.submit();

})



document.getElementById('writeBtn').addEventListener('click',e=>{
	var form = document.getElementById('form');
	
	form.action="<c:url value='/board/write'/>";
	form.method="post";
	form.submit();
})



let msg="${msg}"
if(msg=="write_error") alert("작성 실패");



document.getElementById('modifyBtn').addEventListener('click',e=>{
	let form= document.getElementById('form');
	let title =document.getElementById('title');
	let content =document.getElementById('content');
	let mode =document.getElementById('mode');
	let isReadOnly=title.readOnly;
	console.log(isReadOnly)
	if(isReadOnly){
		title.readOnly=false;
		content.readOnly=false;
		document.getElementById('modifyBtn').value="등록";
		
		return;
	}
	form.action="<c:url value='/board/modify'/>${searchCondition.queryString}";
	form.method="post";
	form.submit();
});

function formCheck(frm){
	var msg='';
	if(frm.title.value.length==0){
		setMessage('id를 입력해 주세요.',frm.title);
		return false;
	}
	if(frm.content.value.length==0){
		setMessage('pwd를 입력해 주세요.',frm.content);
		return false;
	}
	
	return true;
}


</script>


	</form>

</body>
</html>