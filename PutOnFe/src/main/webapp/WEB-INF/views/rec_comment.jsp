<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<script src="http://code.jquery.com/jquery-latest.js"></script>
<div class="commentArea">
	<h2>댓글작성</h2>
	<div class="commentWrite">
		<input type="text" name="com_text" maxlength=60 placeholder="60자 이내로 작성" autocomplete="off">
		<button id="sendBtn">등록</button>
	</div>
	<h2>댓글목록</h2>
	<ul id="commentList"></ul>
</div>
<script>
let rec_num = ${param.rec_num};
let mode = false;
let showList= function(rec_num){
	let com_text = $('input[name=com_text]').val("");
	
	$.ajax({
		type:'GET',
		url: '/pufe/comments?rec_num='+rec_num,
		success : function(result){
		$("#commentList").html(toHtml(result));
		},
		error: function(){ alert("error")}
	}); 
}
$(document).ready(function(){
	showList(rec_num);
    $("#sendBtn").click(function(){
		let com_text = $('input[name=com_text]').val();
		if(com_text.trim()==''){
			alert("내용을 입력해주세요");
			return;
		}
		$.ajax({
			type:'POST',
			url: '/pufe/comments/?rec_num='+rec_num,
			headers: {"content-type" : "application/json"},
			data : JSON.stringify({rec_num:rec_num, com_text:com_text}),
			success : function(result){
				showList(rec_num);
			},
			error: function(){ alert("로그인을 해주세요.") }
		});
	});
	$("#commentList").on("click",".delBtn", (function(){
		let comment_no = $(this).parent().attr('data-comment_no');	    	
		$.ajax({
			type:'DELETE',
			url: '/pufe/comments/'+comment_no+'?rec_num='+rec_num,
			success : function(result){
				alert(result);
				showList(rec_num);
			},
			error: function(){ alert("로그인을 해주세요.") }
		});
	}));
});

let toHtml = function(comments){
	let tmp = "";
	comments.forEach(function(comment){
		tmp += '<li data-comment_no='+comment.rec_com_num+' data-board_no='+comment.rec_num+'>';
		tmp += '<span class="commenter">'+comment.user_name+'</span>';
		tmp += '<span class="comment">'+comment.com_text+'</span>';
		if(comment.user_email=="${sessionScope.email}"||"${user.user_type}"=="A"||"${user.user_type}"=="T")
			tmp += '<a class="delBtn">삭제</a>';
		tmp += '</li>';
	});
	return tmp;
}
</script>