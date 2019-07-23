<%@page import="mainpage.model.MainPage"%>
<%@page import="mainpage.service.GetContentService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int mainpageId = Integer.parseInt(request.getParameter("mainpageId"));
	
	GetContentService service = GetContentService.getInstance();
	
	MainPage mainpage = service.getMainPage(mainpageId);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뿔레</title>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css"/>
<link rel="stylesheet" href="../css/bootstrap.min.css"/>
<style>
	#wrap{
		width: 980px;
		margin: 0 auto;
		border: 1px solid #aaa69d;
		border-radius: 5px;
		margin-bottom: 20px;
	}
	img{
		width: 400px;
		heigth: 300px;
	}
	#jumbo{
		padding: 30px;
		height: 100%;
		overflow: hidden;
	}
	#photo{
		margin: 50px 0;
		text-align: left;
		float: left;
		width: 400px;
		heigth: 300px;
		overflow: hidden;
	}
	#title{
		float: right;
		width: 400px;
		heigth: 300px;
		margin-top: 80px;
	}
	#content{
		width: 100%;
		float: left;
	}
	#id{
		margin-top: 20px;
	}
	#date{
		margin-top: 20px;
	}

	
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>

<!----------------- 네비게이션  시작-------------------->
	<jsp:include page ="/WEB-INF/nav/nav.jsp"/>
	<script>
		$(document).ready(function(){
			$('#BBL').addClass('active');
		});
	</script>
<!----------------- 네비게이션  끝------------------------>

<div id="wrap">
	<div id="jumbo">
		<div id="photo">
	  	<img src="../mainpage_photo/<% if(mainpage.getMainpage_Photo()!=null){out.print(mainpage.getMainpage_Photo());}else{out.print("noImg.jpg");}%>">
	  </div>
	  <div id="title">
		  <h1 class="display-3"><%= mainpage.getMainpage_Title() %></h1>
		  <p class="lead" id="id"><%= mainpage.getUser_ID() %></p>
		  <p class="my-4" id="date"><%= mainpage.getMainpage_Date() %></p>
		  <hr class="my-4">
	  </div>
	  <div id="content">
		  <p class="my-4"><% if(mainpage.getMainpage_Content()!=null){out.print(mainpage.getMainpage_Content());} %></p> 
		  
		  <div id="map" style="width:100%;height:350px;margin-top: 5px;margin-bottom: 5px;"></div>
		  
		  <p class="my-4" id="addr"></p>
	  </div>
	</div>
</div>
</body>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93d6848c2c9e991b89e5f3b7da7a2402&libraries=services"></script>
<script>
	
	
<% if(mainpage.getMainpage_Loc()!=null){ %>
		var address;
		var Lat = <%= mainpage.getMainpage_Loc().split(",")[0] %>;
		var Lng = <%= mainpage.getMainpage_Loc().split(",")[1] %>;
		
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(Lat, Lng), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(Lat, Lng); 
		
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
		
		var geocoder = new kakao.maps.services.Geocoder();

		var coord = new kakao.maps.LatLng(Lat, Lng);
		var callback = function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		       address = result[0].address.address_name;
		       $('#addr').html(address);
		    }
		};
		
		geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
	  
		

		
	
<%}%>
</script>
</html>