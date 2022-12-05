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
<link rel="stylesheet" href="${path }/resources/css/machineRead.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<%@ include file="navMenu.jsp"%>

	<form action="" id="form" enctype="multipart/form-data">
		<div class="container">
			<h1>시설 관리</h1>
			<table>
				<tr>
					<th>번호</th>
					<th>기구이름</th>
				</tr>
				<tr>
					<td><input style="border: 0 solid black;" type="text" id="mch_num" name="mch_num" value="${machine.mch_num }" readonly></td>
					<td><input type="text" id="mch_name" name="mch_name" value="${machine.mch_name }" readonly></td>
				</tr>
				<tr>
					<th>시리얼번호</th>
					<th>입고날짜</th>
				</tr>
				<tr>
					<td><input type="text" id="mch_serial" name="mch_serial" value="${machine.mch_serial}" readonly></td>
					<td><input type="date" id="mch_date" name="mch_date" value="${machine.mch_date}" readonly></td>
				</tr>
				<tr>
					<th>기구정보</th>
					<th>세부정보</th>
				</tr>
				<tr>
					<td><textarea rows="7" cols="35" id="mch_info" name="mch_info" readonly>${machine.mch_info }</textarea></td>
					<td><textarea rows="7" cols="35" id="mch_detail" readonly> ${machine.mch_detail }</textarea></td>
				</tr>
				<tr>
					<th colspan="2">기구사진</th>
				</tr>
				<tr>
					<td colspan="2">
						<c:if test='${machine.mch_img!=null }'>
							<img style="width: 200px; height: 200px" class="img_show" src="${path+='/uploadImgs/'+=machine.mch_img}">
						</c:if>
						<c:if test='${machine.mch_img==null }'>
							<p style="width:100%;text-align:center;font-size:0.8em">등록된 사진이 없습니다.</p>
						</c:if>
					</td>
				</tr>
			</table>
			<div class="button">
				<input type="${mode=='read'?'button':'hidden' }" id="modifyBt" value="수정">
				<input type="${mode=='read'?'button':'hidden' }" id="removeBt" value="삭제">
				<input type="${mode=='read'?'button':'hidden' }" id="listBt" value="목록">
			</div>
		</div>
	</form>
<script>
if("${msg}"!="") alert("${msg}");
$("#listBt").click(function(){
	location.replace("<c:url value='/menu2'/>${searchCondition.queryString}");
});

$("#removeBt").click(function(){
	if(!confirm("게시물을 삭제하겠습니까?")) return;
	let form=document.getElementById('form');
	form.action="<c:url value='/facility/remove'/>${searchCondition.queryString}";
	form.method="post";
	form.submit();
});
$("#modifyBt").click(function(){
	let mch_num=$('#mch_num').val();
	window.location="<c:url value='/facility/write'/>?mch_num="+mch_num+"&mode=modify";
});
</script>
</body>
</html>



