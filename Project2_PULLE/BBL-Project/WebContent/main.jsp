<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="js/bootstrap.js"></script>
<title>뿔레 사이트</title>
<style>

</style>
</head>
<body>

<!----------------- 네비게이션  시작-------------------->
	<jsp:include page ="/WEB-INF/nav/nav.jsp"/>
	<script>
		$(document).ready(function(){
			$('#home').addClass('active');
		});
	</script>
<!----------------- 네비게이션  끝------------------------>
	
	<div style="margin-left: 200px;">
	<span style="margin-top:130px;margin-left:200px;font-family: 'Monoton', cursive;font-size:80px;">welcome  to  the  Pulle!</span>
	<div class="mainContents" style="position: relative;">        
        <img src="img/main5.jpg" style="width:1200px;height:800px; margin-top:28px;margin-left:160px;">
        <span><h1 style="display: inline-block; font-family: 'Black Han Sans', sans-serif; margin-left:320px; font-size:140px;">어디서 뭘먹지?</h1></span>
        <!-- <div class="content_text" style="position: absolute; top: 10px; left: 10px;">
       	 
           <h1 style="color: black;margin-left: 100px;margin-top: 30px;font-family: 'Orbitron', sans-serif;font-size: 60px;">WELCOME TO:</h1>
           <p class="sub_text1" style="color: gray;margin-left: 300px;margin-top:30px;">나만 알고싶은 맛 지도 </p> -->
    </div>
	</div>
	
	<!-- <div class="row">
  		<div class="col-sm-6 col-md-4">
    		<div class="thumbnail">
      		  <div class="caption">
      		  <h3>뽈레?!게시판</h3>
      		  <img src="img/main3.jpg" style="width:500px;">
        	  	<p>...</p>
        	  	<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
      	     </div>
           </div>
        </div>
        <div class="col-sm-6 col-md-4">
    		<div class="thumbnail">
    		  <img src="..." alt="...">
      		  <div class="caption">
        	  	<h3>TMI 게시판</h3>
        	  	<p>...</p>
        	  	<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
      	     </div>
           </div>
        </div>
        <div class="col-sm-6 col-md-4">
    		<div class="thumbnail">
    		  <img src="..." alt="...">
      		  <div class="caption">
        	  	<h3>광고 게시판</h3>
        	  	<p>...</p>
        	  	<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
      	     </div>
           </div>
        </div>
    </div> -->

	
	<footer style="width:100%;height:120px;background-color:#3d3d3d;">
        <br>
        <p style="color:white;opacity:0.6;margin-left:600px;"><span style="font-weight:450;margin-top: ;">이용약관 | 개인정보처리방침 | 책임의 한계와</span> | 법적고지 | 회원정보 | 고객센터 </span></p>
        <p style="color:white;margin-left:600px;font-size:15px;">COMPANY BY PULLE / THANK YOU!</p>
        <img src="img/naver.png" style="width:80px; margin-left:880px;margin-top:-36px;">
        <img src="img/google.png" style="width:80px;margin-top:-36px;">
        <img src="img/insta.png" style="width:80px; margin-left:-10px; margin-top:-40px;">
        <img src="img/tw.png" style="width:25px; margin-left:-10px; margin-top:-40px;">
     </footer>
 
</body>



</html>


