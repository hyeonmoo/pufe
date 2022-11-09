
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.net.URLDecoder"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
<link rel="stylesheet" href="${path }/resources/css/navMenu.css">	
<meta charset="EUC-KR">
<title>Insert title here</title>

<style>
.recommend_boarder {
	border-top: 3px solid black;
	margin-top: 100px;
	width: 1000px;
	margin-left: auto;
	margin-right: auto;
}

.line {
	background-color: #121212;
	border: 1px solid #121212;
	border-radius: 29px;
}

.a {
	background-color: #121212;
	color: white;
	text-align: center;
}

#writeBtn {
	background-color: #121212;
	color: white;
	padding: 5px;
	border-radius: 10px;
	font-size: 11px
}

.table1 {
	margin-top: 20px;
}

.search-container {
	margin: auto;
	width: 400px;
	text-align: center;
}
</style>
</head>
<body>
	<%@ include file="navMenu.jsp"%>





	<div class=recommend_boarder style="text-align: center">



		<table class="table table-hover table-condensed table1">
			<tr class="line">
				<th class="a" style="width: 50px;">번호</th>
				<th class="a" style="width: 300px;">제목</th>
				<th class="a" style="width: 100px;">아이디</th>
				<th class="a" style="width: 100px;">등록일</th>
				<th class="a" style="width: 100px;">조회수</th>
			</tr>

			<c:forEach var="board" items="${list }">
				<tr>
					<td>${board.bno }</td>
					<td><a style="color: black;"
						href="<c:url value='/board/read${searchCondition.queryString}&bno=${board.bno}'/>">${board.title}</a></td>
					<td>${board.id }</td>
					<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd" />
					<fmt:formatDate var="reg_date" value="${board.reg_date}"
						pattern="yyyy-MM-dd" />
					<c:choose>
						<c:when test="${ today<=reg_date}">
							<td class="regdate"><fmt:formatDate
									value="${board.reg_date}" pattern="HH:mm" type="time" /></td>
						</c:when>
						<c:otherwise>
							<td class="regdate"><fmt:formatDate
									value="${board.reg_date}" pattern="yyyy-MM-dd" type="date" /></td>
						</c:otherwise>
					</c:choose>
					<td>${board.view_cnt }</td>
				</tr>
			</c:forEach>
		</table>
		<br>
		<button type="button" id="writeBtn"
			onclick="location.href='<c:url value="/board/write"/>'">글쓰기</button>
		<div>
			<ul class="pagination">
				<li><c:if test="${ph.showPrev }">
						<a href="<c:url value='/board/list${ph.sc.getQueryString(ph.beginPage-1) } ' />">&laquo;</a>
					</c:if></li>
				<li><c:forEach var="i" begin="${ph.beginPage }"
						end="${ph.endPage }">
						<a href="<c:url value='/board/list${ph.sc.getQueryString(i) }'/>">${i }</a>
					</c:forEach></li>
				<li><c:if test="${ph.showNext }">
						<a
							href="<c:url value='/board/list${ph.sc.getQueryString(ph.endPage+1) }'/>">&raquo;</a>
					</c:if></li>
			</ul>
		</div>
	</div>

	<div class="search-container">
		<form action="<c:url value="/board/list"/>" class="search-form"
			method="get">
			<select class="search-option" name="option">
				<option value="A"
					${ph.sc.option=='A' || ph.sc.option=='' ? "selected" :"" }>제목+내용</option>
				<option value="T" ${ph.sc.option=='T' ?  "selected" :"" }>제목만</option>
				<option value="W" ${ph.sc.option=='W' ?  "selected" :"" }>작성자</option>




			</select> <input type="text" name="keyword" class="search-input" type="text"
				value="${ph.sc.keyword }" placeholder="검색어 입력"> <input
				type="submit" class="btn btn-default" value="검색">

		</form>


	</div>



	<script>
		let msg = "${msg}"
		if (msg == "del")
			alert("삭제성공");
		if (msg == "error")
			alert("삭제실패");
		if (msg == "write_ok")
			alert("등록성공");
	
	</script>
</body>
</html>