
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.net.URLDecoder"%>
<c:set var="path" value="${pageContext.request.contextPath}" />


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <style>
      .slide{
      position:absolute;
      width:150px;
      height:150px; margin-top :50px;
      margin_left:20px;
      }
        .img {
            
            width: 150px;
            height: 150px;
            position: absolute;
           

        }

        #slide {
            position: absolute;
        }

        #slide>img {
            width: 150px;
            height: 150px;
        }

        button {
            position: absolute;
            height: 150px;
            top: 0;
            border: none;
            padding: 20px;
            color: white;
            background: transparent;
            font-size: 50px;
        }

        #prev {
            left: 0;
        }

        #next {
            right: 0;
        }

  
     


     

        #prev:hover {
            color: black;
        }

        #next:hover {
            color: black;
        }

   
     

  
    </style>


</head>

<body>
     <div class="slide">
        <div class="img">
            <div id="slide">
               <img src="${path }/resources/img/anchovy.png">
               <img src="${path }/resources/img/logo_nav.png">
                <img src="${path }/resources/img/logo_main.png">
                <button id="prev">&lang;</button>
                <button id="next">&rang;</button>
            </div>
      </div>

</div>

       



   



    <script>
        let prev_button = document.getElementById("prev");
        let next_button = document.getElementById("next");
        let imgs = document.querySelectorAll('#slide img');
        let img_num = 0;
        showing(img_num);

        function showing(n) {
            for (let i = 0; i < imgs.length; i++) {
                imgs[i].style.display = "none";
            }
            imgs[n].style.display = "block";
        }
        prev_button.onclick = function () {
            img_num--;
            if (img_num < 0) img_num = imgs.length - 1;
            showing(img_num);
        }
        next_button.onclick = function () {
            img_num++;
            if (img_num > imgs.length - 1) img_num = 0;
            showing(img_num);
        }


    </script>
</body>

</html>