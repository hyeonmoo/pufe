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
<link rel="stylesheet" href="${path }/resources/css/board_machines_read.css">
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
					<td><input style="border: 0 solid black;" type="text"
						id="mch_num" name="mch_num" value=${machine.mch_num }
						${mode=="write"?'':'readonly="readonly"' }></td>
					<td><input type="text" id="mch_name" name="mch_name"
						value=${machine.mch_name }
						${mode=="write"?'':'readonly="readonly"' }></td>
				</tr>
				<tr>
					<th>시리얼번호</th>
					<th>입고날짜</th>
				</tr>
				<tr>
					<td><input type="text" id="mch_serial" name="mch_serial"
						value=${machine.mch_serial }
						${mode=="write"?'':'readonly="readonly"' }></td>
					<td><input type="date" id="mch_date" name="mch_date"
						value=${machine.mch_date }
						${mode=="write"?'':'readonly="readonly"' }></td>
				</tr>
				<tr>
					<th>기구정보</th>
					<th>세부정보</th>
				</tr>
				<tr>
					<td><textarea rows="7" cols="35" id="mch_info" name="mch_info"
							${mode=="write"?'':'readonly="readonly"' }>${machine.mch_info }</textarea></td>
					<td><textarea rows="7" cols="35" id="mch_detail"
							name="mch_detail" ${mode=="write"?'':'readonly="readonly"' }> ${machine.mch_detail }</textarea></td>
				</tr>
				<tr>
					<th colspan="2">기구사진</th>
				</tr>
				<tr>
					<td colspan="2"><c:if test='${machine.mch_img!=null }'>
							<img style="width: 200px; height: 200px" class="img_show"
								src="../resources/img/${machine.mch_img }">
						</c:if></td>
				</tr>

			</table>
			<div class="button">

				<input type="${mode=='write'?'button':'hidden' }" class="btn "
					id="writeBt" value="등록"> <input
					type="${mode=='read'?'button':'hidden' }" class="btn "
					id="modifyBt" value="수정"> <input
					type="${mode=='read'?'button':'hidden' }" class="btn "
					id="removeBt" value="삭제"> <input
					type="${mode=='read'?'button':'hidden' }" class="btn " id="listBt"
					value="목록">
			</div>
		</div>
	</form>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
	document.getElementById("listBt").addEventListener('click',e=>{
		window.location="<c:url value='/facility'/>${searchCondition.queryString}";
	});
	
	document.getElementById("removeBt").addEventListener('click',e=>{
		if(!confirm("게시물을 삭제하겠습니까?")) return;
		let form=document.getElementById('form');
		form.action="<c:url value='/facility/remove'/>${searchCondition.queryString}";
		form.method="post";
		form.submit();
	});
	

	document.getElementById("modifyBt").addEventListener('click',e=>{
	let mch_num=$('#mch_num').val();
		window.location="<c:url value='/facility/write'/>?mch_num="+mch_num+"&mode=modi";
	});
	
	


	
</script>
</body>
</html>



