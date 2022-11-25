<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><script src="http://code.jquery.com/jquery-latest.js"></script> 
<meta charset="UTF-8">
<title>Insert title here</title>
<style>


</style>

</head>

<body>
	
		<h2 style="margin:10px">댓글</h2>
		<div class="send">
			<input class="form-control" type="text" name="com_text" id="com_text">
			<button class="btn btn-default" id="sendBtn" type="button">등록</button>
			
		</div>
		
		<div id="commentList" style="margin-bottom: 100px;"></div>
	
	
	<script>
	

	let rec_num = ${param.rec_num};
	
	let mode = false;
	
	let showList= function(rec_num){
		console.log(rec_num);
		let com_text = $('input[name=com_text]').val("");
		
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '/pufe/comments?rec_num='+rec_num,  // 요청 URI
            success : function(result){
				$("#commentList").html(toHtml(result));
				
            },
            error: function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()
        
      
	}
	
	// 문서가 로드가 되었을 때 실행되는 함수 - main함수와 동일한 역할로 생각
	$(document).ready(function(){
		showList(rec_num);
	    $("#sendBtn").click(function(){
		    	let com_text = $('input[name=com_text]').val();
		    	if(com_text.trim()==''){
		    		alert("입력해주세요");
		    		return;
		    	}
		        $.ajax({
		            type:'POST',       // 요청 메서드
		            url: '/pufe/comments/?rec_num='+rec_num,  // 요청 URI
		            headers: {"content-type" : "application/json"}, // 보내는 데이터 타입명시
		            data : JSON.stringify({rec_num:rec_num, com_text:com_text}), // 전달 데이터
		            success : function(result){ // 요청이 성공일 때 실행되는 이벤트
		            	alert(result);
		            	showList(rec_num);
		            },
		            error: function(){ alert("로그인을 해주세요.") } // 에러가 발생했을 때 실행되는 이벤트
		        }); // $.ajax()
	    });
	    
		var isAjaxing = false;
	    
		// 각 버튼의 수정 버튼이 눌렀을 경우 
   
	

	     
	    //삭제 버튼은 동적으로 생성되는 버튼이므로 이벤트를 추가하기에 적합하지 않음
	    //$("#delBtn").click(function(){
		//	showList(bno);
	    //});
	    $("#commentList").on("click", ".delBtn" , (function(){
        	let rec_com_num = $(this).parent().attr('data-rec_com_num');	    	
	        $.ajax({

	            type:'DELETE',       // 요청 메서드
	            url: '/pufe/comments/'+rec_com_num+'?rec_num='+rec_num,  // 요청 URI
	            success : function(result){
	            	alert(result);
	            	showList(rec_num);
	            },
	            error: function(){ alert("로그인을 해주세요.") } // 에러가 발생했을 때, 호출될 함수
	        }); // $.ajax()
	       // alert("the request is sent")
    	}));	

	});
	
	
	let toHtml = function(comments){
		let tmp ="<ul class=clist>"
		
		comments.forEach(function(comment){
			tmp += '<li data-rec_com_num='+comment.rec_com_num
			tmp += ' data-rec_num='+comment.rec_num+'>'
			tmp += ' <span class="commenter"> '+comment.user_name+'</span><br>'
			tmp += '  <span class="comment"> '+comment.com_text+'</span>'
			if(comment.user_email== "${sessionScope.email}"){
				tmp += '<br><button class="btn delBtn">삭제</button>'
				
			}
			tmp += '</li>'
		})
		return tmp +'</ul>';
	}
	</script>
	
	
</body>

</html>