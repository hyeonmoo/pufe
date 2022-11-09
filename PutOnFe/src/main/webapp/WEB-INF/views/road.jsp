<<<<<<< HEAD

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.net.URLDecoder" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>헬스 추천 정보</title>
     <link rel="stylesheet" href="${path }/resources/css/navMenu.css">
    <style>
        .container{

height: 600px;
            width: 600px;
            margin: auto;
        }
.address_box01{
    border-top: 3px solid black;
    border-bottom: 1px solid black;
    margin-top: 50px;
    padding: 20px;
}
.mapbox{
   border: 5px solid black;
    width: 529px;
    height: 462px;
    margin: auto;
    margin-top: 30px;
    
}
iframe{
    width: 520px;
    height: 452px;
    
}
.title{
    margin-top: 100px;
    font-size: 30px;
    text-align: center;
}




.map_location {
display:grid;
width: 600px;
margin: auto;
text-align: center;
margin-top: 20px;
  }
  .bus{
grid-column: 1/2;
border-right: 1px  solid black;
  }
  .parking{
    grid-column:2/2 ;
    grid-row: ;
  }
    </style>
</head>
<body>
<%@ include file="navMenu.jsp" %>
<div class="container">
    <div class="title">
    오시는 길</div>
    <div class="mapbox">
    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d25614.16550288469!2d127.454348!3d36.631906!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0xb4494fd3ce5ed248!2z7Lap67aB64yA7ZWZ6rWQ7ZuE66y4!5e0!3m2!1sko!2skr!4v1665720239636!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
</div>
<div class="address_box01">


    충청북도 청주시 서원구 복대로 17번길 57<br>
    TEL : 043-272-0001 / FAX 043-264-2888<br>
    주차가능

</div>

<div class="map_location">
    
      
    <div class="bus"><div class="info" style="font-size: 140%;"> 교통정보</div>
    <div style="font-size: 80%;"> <br>
    [버스]<br>
      - 가산디지털단지역 하차<br>
      금천03, 공항버스6004, 지선5537<br>
      마을 금천01-1, 마을 금천05<br>
      일반 21<br>
      <br>
      - 국민연금관리공단 앞 하차<br>
      금천 07<br>
      <br>
      [지하철]<br>
      가산디지털단지역 4번출구 도보 1분
    </div>
  </div> 
  
    
    <div class="parking"><div class="info"style="font-size: 140%;"> 주차정보</div>
    <div style="font-size: 80%;"><br>
    리더스타워 본 건물 <br>
      운영시간 24시간 / 30분-60분 무료<br>
      (pm6시 이후 2시간 무료, 1시간 할인) </div>
  
 </div>
</div>

</body>

</html>