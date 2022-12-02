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
</head>
<body>
	<%@ include file="navMenu.jsp"%>

	<form action="" id="form" enctype="multipart/form-data">

		<div class="container">
			<h1>${mode=="write"? "머신 등록": ""}</h1>
			<table>
				<tr>
					<th colspan="2">기구이름</th>
				</tr>
				<tr>
					<input type="hidden" id="mch_num" name="mch_num"
						value=${machine.mch_num }>
					<td colspan="2"><input type="text" id="mch_name"
									name="mch_name" value=${machine.mch_name }
									${mode=="write"?'':'readonly="readonly"' }></td>
				</tr>
				<tr>
					<th>시리얼번호</th>
					<th>입고날짜</th>
				</tr>
				<tr>
					<td><input type="text" id="mch_serial" name="mch_serial"
						placeholder="시리얼 넘버를 입력하세요." value=${machine.mch_serial }
						${mode=="write"?'':'readonly="readonly"' }></td>
					<td><input type="date" id="mch_date" name="mch_date"
						placeholder="기구 입고 날짜를 입력하세요." value=${machine.mch_date }
						${mode=="write"?'':'readonly="readonly"' }></td>
				</tr>
				<tr>
					<th>기구정보</th>
					<th>세부정보</th>
				</tr>
			<tr>
					<td><textarea rows="7" cols="35" id="mch_info" name="mch_info"
							placeholder="기구 정보를 입력하세요."
							${mode=="write"?'':'readonly="readonly"' }>${machine.mch_info }</textarea></td>
					<td><textarea rows="7" cols="35" id="mch_detail"
							name="mch_detail" placeholder="기구 세부사항을 입력하세요."
							${mode=="write"?'':'readonly="readonly"' }> ${machine.mch_detail }</textarea></td>
				</tr>
				<tr>
					<th colspan="2">기구사진</th>
				</tr>
				<tr>
					<td colspan="2"><input type="file" name="uploadFile" id="uploadFile" multiple />
	<label for="fileName" id="fileName">${machine.mch_img }</label>
	<input type="hidden" name="fileName" value="${machine.mch_img }">
	<input type='hidden' name="del" id="del" value=0>
					</td>
				</tr>
			</table>
			<div class="button">

				<input type="${mode=='write'?'button':'hidden' }" class="btn "
					id="writeBt" name="writeBt" value="등록">
					 <input
					type="${mode=='write'?'button':'hidden' }" class="btn "
					id="modifyBt" name="modifyBt" value="수정"> <input
					type="${mode=='write'?'button':'hidden' }" class="btn " id="listBt"
					value="목록">
			</div>
		</div>
	</form>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
	let ch=true;
	document.getElementById("listBt").addEventListener('click',e=>{
		window.location="<c:url value='/facility'/>${searchCondition.queryString}";
	});
	
	$(document).ready(function(){
	    $('#uploadFile').on('change', function() {
	        $('#fileName').text($(this).val());
	    });

		// 정규표현식 : 예).com 끝나는 문장 등의 조건이 복잡한 문장을 컴퓨터에게 이해시키기 위한 구문
		let regex = new RegExp("(.*)\.(exe|sh|zip|alz)$");
							// 파일이름 .  exe|sh|zip|alz 인 경우를 체크함
		let maxSize =5242880; // 5Mb
		
		function checkExtension(fileName, fileSize){
			// 파일크기 초과시 종료시킴
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				ch=false;
				return false;// return이 있어서 아래쪽 구문은 실행 안됨
			}
			// regex에 표현해둔 정규식과 일치하는지 여부를 체크, 일치하면 true, 아니면 false
			if(regex.test(fileName)){
				alert("해당 확장자를 가진 파일은 업로드할 수 없습니다.");
				ch=false;
				return false;
			}
			return true;
		}
		
		$('#writeBt').on("click", function(e){
		
			let formData = new FormData(); 
			
			
			let inputFile = $("input[name='uploadFile']"); 
			
			
			let files = inputFile[0].files;// 실제 file 데이터
			
			// 파일 데이터를 폼에 집어넣기
			for(let i = 0; i < files.length; i++){
				console.log(i)
				if(!checkExtension(files[i].name, files[i].size)){
					return false;// 조건에 맞지않은 파일 포함시 onclick 이벤트 함수자체를 종료시켜버림
				}

				// 파일 데이터를 가져와서 key, value로 저장
				formData.append("uploadFile", files[i]);
				
				//console.log로는 단순한 객체가 아니라 전송을 위한 특수객체이므로 확인이 어려움
				//다음과 같이 for문으로 확인해야 함
				for (let key of formData.keys()) {
					  console.log(key, ":",formData.get(key));
				}
			}
			
		});

	
	document.getElementById("writeBt").addEventListener('click',e=>{
		
		if($('#mch_name').val().length==0||$('#mch_serial').val().length==0||$('#mch_date').val().length==0||
				$('#mch_info').val().length==0||$('#mch_detail').val().length==0)
		{
			alert("내용을 모두 입력하세요");
			return false;
		}
		
		if(!ch) return;
		if(!confirm("게시물을 등록하시겠습니까?")) return;
		

		let form = document.getElementById('form');
		form.action="<c:url value='/facility/write'/>";
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
		form.action="<c:url value='/facility/modify'/>${searchCondition.queryString}";
		form.method="post";
		form.submit();
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
	
	// uploadBtn onclick	
	$('#modifyBt').click(function(){
		
		console.log($('#del').val())

		
		let formData = new FormData(); 
		console.log(formData);
		
		let inputFile = $("input[name='uploadFile']"); 
		console.log(inputFile)
		
		let files = inputFile[0].files;// 실제 file 데이터
		console.log(files);
		let fileName = $("#fileName").text()
		if(files.length==0&&fileName.length==0){
			$('#del').val(3);
			alert("파일이 없습니다.")
			modi();
			return;
		}
		else if(files.length==0&&fileName.lengh!=0){
			$('#del').val(1);
			modi();
			return;
		}
		// 파일 데이터를 폼에 집어넣기
		for(let i = 0; i < files.length; i++){
			console.log(i)
			if(!checkExtension(files[i].name, files[i].size)){
				return false;// 조건에 맞지않은 파일 포함시 onclick 이벤트 함수자체를 종료시켜버림
			}
			console.log("파일 길이")
			console.log(files[i].name.length)
			formData.append("uploadFile", files[i]);
			
		}	
		modi();
	});
	function modi(){
		 // 2. 수정 상태이면 수정된 내용을 서버로 전송
		 
		var form = document.getElementById('form');
		console.log(form)
		form.action="<c:url value='/facility/modify'/>${searchCondition.queryString}"; 
		form.method="post";
		form.submit();
	}
	
	

	
				
				
				
					
				});
</script>
</body>
</html>



