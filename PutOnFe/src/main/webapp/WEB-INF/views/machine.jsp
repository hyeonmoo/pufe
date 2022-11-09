
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.net.URLDecoder" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>



<!DOCTYPE html>
<html lang="en">

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
   <link rel="stylesheet" href="${path }/resources/css/navMenu.css">

    <style>
        .container {
            text-align: center;
            margin-top: 20px;
            display: grid;
            margin-left: 10%;
            margin-right: 10%;


        }

        box {
            margin: 50px;
        }

        .a {
            grid-row: 1/1;
            grid-column: 1/1;
            position: relative;
        }

        .b {
            grid-row: 1/1;
            grid-column: 2/2;
        }

        .c {
            grid-row: 1/1;
            grid-column: 3/3;
        }

        .d {
            grid-row: 1/1;
            grid-column: 4/4;
        }

        .e {
            grid-row: 2/2;
            grid-column: 1/1;
            position: relative;
        }

        .f {
            grid-row: 2/2;
            grid-column: 2/2;
            position: relative;
        }

        .product_img {
            position: relative;


        }

        .product_img>img {
            width: 200px;
            height: 200px;
            z-index: 5;
            border: 3px solid #121212;


        }

        li {
            list-style: none;
        }

        .product_con>li {

            font-size: 80%;

        }

        .caption {
            position: absolute;
            box-sizing: border-box;

            top: 0px;
            width: 100%;
            height: 100%;
            padding: 15%;
            line-height: 150%;
            background: rgba(0, 0, 0, 0.6);
            color: white;
            text-align: center;

            display: none;

        }



        button {
            background-color: #121212;
            border-radius: 20%;
            width: 70px;
            cursor: pointer;
            margin: 5px;
        }

        button>p {
            color: white;

        }
        .title{
    margin-top: 100px;
    font-size: 30px;
    text-align: center;
}
    </style>

</head>

<body>
 <%@ include file="navMenu.jsp" %>
    <div class="title">
        시설</div>
    <div class="container">
        
        <box class="a" id="btn_toggle01">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>

            <ul>
                <li class="product_img"><img src="img/machine/machine1.jpg">
                    <div class="caption" id="Toggle">
                        손잡이 각도 2개 적용<br>
                        원터치 좌석 조정<br>
                        목재 케이스 크기: 1520x1200x660mm<br>
                        플레이트로 종량 조절<br>
                    </div>

                </li>
                <li class="product_tit"><br>J500-01 플레이트 좌석 로운 머신</li>
                <ul class="product_con">
                    <br>
                    <li>메인 튜브 크기: 100x50x3.0mm 평 타원 튜브</li>
                    <li>조립 크기: 1243x1490x1255mm</li>
                    <li>N.W: 124kg</li>
                </ul>

            </ul>



        </box>

        <box class="b" id="btn_toggle02">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>
            <ul>
                <li class="product_img"><img src="img/machine/machine2.jpg">
                    <div class="caption" id="Toggle">
                        한 팔 아령 로우 가능<br>
                        바벨 로우 가능<br>
                        허리 각도에 따른 부위별 운동<br>
                        목재 케이스 크기: 1600x1500x600mm<br>
                    </div>

                </li>
                <li class="product_tit"><br>J500-02 플레이트 낮은 로우 머신</li>
                <ul class="product_con">
                    <br>
                    <li>메인 튜브 크기: 100x50x3.0mm 평 타원 튜브</li>
                    <li>조립 크기: 1310x1453x1440mm</li>
                    <li>N.W: 186kg</li>
                </ul>

            </ul>
        </box>
        <box class="c" id="btn_toggle03">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>
            <ul>
                <li class="product_img"><img src="img/machine/machine3.jpg">
                    <div class="caption" id="Toggle">
                        넓적다리 운동<br>
                        사두근과 하체 운동<br>
                        원터치 의자 조절<br>
                        목재 케이스 크기: 1420x870x680mm<br>
                    </div>

                </li>
                <li class="product_tit"><br>J500-03 플레이트 레그익스 머신</li>
                <ul class="product_con">
                    <br>
                    <li>메인 튜브 크기: 100x50x3.0mm 평 타원 튜브</li>
                    <li>조립 크기: 1432x1438x1024mm</li>
                    <li>N.W: 138kg</li>
                </ul>

            </ul>

        </box>
        <box class="d" id="btn_toggle04">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>
            <ul>
                <li class="product_img"><img src="img/machine/machine4.jpg">
                    <div class="caption" id="Toggle">
                        플레이트로 종량 조절<br>
                        광배근 하부 운동<br>
                        원터치 좌석 조정<br>
                        목재 케이스 크기: 1800x850x400mm<br>
                    </div>

                </li>
                <li class="product_tit"><br>J500-04 플레이트 와이드 풀다운</li>
                <ul class="product_con">
                    <br>
                    <li>메인 튜브 크기: 100x50x3.0mm 평 타원 튜브</li>
                    <li>조립 크기: 1250x1900x2010mm</li>
                    <li>N.W: 171kg</li>
                </ul>

            </ul>

        </box>

        <box class="e" id="btn_toggle05">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>
            <ul>
                <li class="product_img"><img src="img/machine/machine5.jpg">
                    <div class="caption" id="Toggle">
                        플레이트로 종량 조절<br>

                        원터치 좌석 조정<br>
                        목재 케이스 크기: 1800x870x460mm<br>
                    </div>

                </li>
                <li class="product_tit"><br>J500-05 플레이트 어깨 프레스 머신</li>
                <ul class="product_con">
                    <br>
                    <li>메인 튜브 크기: 100x50x3.0mm 평 타원 튜브</li>
                    <li>조립 크기: 1700x1300x460mm</li>
                    <li>N.W: 238kg</li>
                </ul>

            </ul>

        </box>


        <box class="f" id="btn_toggle06">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>
            <ul>
                <li class="product_img"><img src="img/machine/machine6.jpg">
                    <div class="caption" id="Toggle">
                        웨이트 플레이트로 조절용<br>
                        전체 흉부 운동<br>
                        원터치 좌석 조절<br>
                        목재 케이스 크기: 1500x1000x460mm<br>
                    </div>

                </li>
                <li class="product_tit"><br>J500-06 플레이트 지상 콤보 인클라인</li>
                <ul class="product_con">
                    <br>
                    <li>메인 튜브 크기: 100x50x3.0mm 평 타원 튜브</li>
                    <li>조립 크기: 1709x1856x1289mm</li>
                    <li>N.W: 185.5kg</li>
                </ul>

            </ul>

        </box>

        <box class="g" id="btn_toggle07">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>
            <ul>
                <li class="product_img"><img src="img/machine/machine7.jpg">
                    <div class="caption" id="Toggle">
                        메인 튜브 크기: 100x50x3.0mm 평 타원 튜브<br>
                        8*100kg 강철 중량 세트<br>

                    </div>

                </li>
                <li class="product_tit"><br>J500-07 플레이트 멀티 스테이션 짐 기구</li>
                <ul class="product_con">
                    <br>
                    <li>기능: 페크 플라이, 좌식 로윙 머신,</li>
                    <li>누운 다리 컬, 보조 딥, 래트 풀다운,레그익스</li>
                    <li> 케이블 크로스 오버, 친업, 멀티 포지션 풀</li>
                </ul>

            </ul>

        </box>
        <box class="h" id="btn_toggle08">
            <div class="detail">
                <button>
                    <p>세부사항</p>
                </button>
            </div>
            <ul>
                <li class="product_img"><img src="img/machine/machine8.jpg">
                    <div class="caption" id="Toggle">
                        웨이트 플레이트로 조절<br>
                        이두박근 운동<br>
                        최대 이두고근 운동 효과, 별다리 운동<br>
                        목조 케이스 크기: 1420x1020x500mm<br>
                    </div>

                </li>
                <li class="product_tit"><br>J500-08 플레이트 닐링 다리 컬</li>
                <ul class="product_con">
                    <br>
                    <li>메인 튜브 크기: 100x50x3.0mm 평 타원 튜브</li>
                    <li>조립 크기: 990x1245x1287mm</li>
                    <li>N.W: 123.5kg</li>
                </ul>

            </ul>

        </box>


    </div>

    <script>
        for (i = 1; i <= 8; i++) {
            $('#btn_toggle0' + i).click(function () {
                $(this).find('#Toggle').toggle();
            });
        }
    </script>
</body>

</html>