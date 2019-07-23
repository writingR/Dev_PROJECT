<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>뿔레!?</title>
</head>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css"/>


<style>
	#wrap{
		width: 980px;
		margin: 0 auto;
		border: 1px solid #aaa69d;
		border-radius: 5px;
		margin-bottom: 20px;
		padding: 20px;
		text-align: center;
	}
	
	.where {
	  display: block;
	  margin: 25px 15px;
	  font-size: 11px;
	  color: #000;
	  text-decoration: none;
	  font-family: verdana;
	  font-style: italic;
	} 
	
	.filebox input[type="file"] {
	    position: absolute;
	    width: 1px;
	    height: 1px;
	    padding: 0;
	    margin: -1px;
	    overflow: hidden;
	    clip:rect(0,0,0,0);
	    border: 0;
	}
	
	.filebox label {
	    display: inline-block;
	    padding: .5em .75em;
	    color: #999;
	    font-size: inherit;
	    line-height: normal;
	    vertical-align: middle;
	    background-color: #fdfdfd;
	    cursor: pointer;
	    border: 1px solid #ebebeb;
	    border-bottom-color: #e2e2e2;
	    border-radius: .25em;
	}
	
	/* named upload */
	.filebox .upload-name {
	    display: inline-block;
	    padding: .5em .75em;
	    font-size: inherit;
	    font-family: inherit;
	    line-height: normal;
	    vertical-align: middle;
	    background-color: #f5f5f5;
	  border: 1px solid #ebebeb;
	  border-bottom-color: #e2e2e2;
	  border-radius: .25em;
	  -webkit-appearance: none;
	  -moz-appearance: none;
	  appearance: none;
	}
	
	.filebox.bs3-primary label {
	  color: #fff;
	    background-color: #337ab7;
	    border-color: #2e6da4;
	}
	
	#comment{
		resize: none;
	}
	#comment2{
		padding:3px 0;
		margin: 20px 0px 10px ;

	}
	#filebar{
		text-align: left;
		margin-bottom: 10px;
	}
	#upload-label{
		margin: 0;
	}
	#uploadbar{
		margin-bottom: 2.5px;
	}
	#addressbar{
		margin-bottom: 20px;
	}
	#submit-button{
		width: 100%;
		overflow: hidden;
	}
	#write{
		float: left;
	}
	#back{
		float: right;
	}
	#alertbar{
		padding: 5px;
		margin-top: 5px;
	}
	.displayalert{
		display: none;
	}

</style>

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
		<form action="writeBBLProcess.jsp" method="post" enctype="multipart/form-data">
			
			<div class="input-group" id="titlebar">
			    <span class="input-group-addon">타이틀</span>
			    <input id="msg" type="text" class="form-control" name="mainpage_Title" placeholder="제목을 입력해 주세요.">
			</div>
			
			<div class="alert alert-danger displayalert" id="alertbar">
			    <strong>경고!</strong> 타이틀은 필수 입력 사항 입니다.
			</div>
			
			<div class="form-group">
				
				<div class="well well-sm" id="comment2">
					내용
				</div>

			    <textarea class="form-control" rows="20" id="comment" name="mainpage_Content" placeholder="내용을 입력해 주세요."></textarea>
			</div>
						
			<div class="filebox bs3-primary" id="filebar">
            	<input class="upload-name" value="파일선택" disabled="disabled" id="uploadbar">
				<label for="ex_filename" id="upload-label">업로드</label> 
				<input type="file" id="ex_filename" class="upload-hidden" name="mainpage_Photo" accept=".gif, .jpg, .png"> 
           	</div>

			<!-- 주소 검색 시작 -->
			<div class="input-group">
			    <input type="text" class="form-control" placeholder="주소를 검색하세요." id="searchMap">
			    <div class="input-group-btn">
			    	<button class="btn btn-default" type="button" id="searchClick">
			        	<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>

			<div id="map" style="width:100%;height:350px;margin-top: 5px;margin-bottom: 5px;"></div>
			
			<div class="input-group" id="addressbar">
			    <span class="input-group-addon">주소</span>
			    <input id="msg2" type="text" class="form-control" name="mainpage_Loc" placeholder="마커를 클릭해 주세요." readonly>
			</div>
			<!-- 주소 검색 끝 -->
			
			<div id="submit-button">
				<input type="submit" id="write"  class="btn btn-primary" value="작성하기">
				<input type="button" id="back" class="btn btn-danger" value="취소">
			</div>
		</form>
	</div>
	

</body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93d6848c2c9e991b89e5f3b7da7a2402&libraries=services"></script>
<script>
	$(document).ready(function(){
		
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(); 

		$('#searchClick').click(function(){
			ps.keywordSearch($('#searchMap').val(), placesSearchCB); 
		});
		// 키워드로 장소를 검색합니다

		// 키워드 검색 완료 시 호출되는 콜백함수 입니다
		function placesSearchCB (data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        var bounds = new kakao.maps.LatLngBounds();

		        for (var i=0; i<data.length; i++) {
		            displayMarker(data[i]);    
		            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
		        }       

		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		        map.setBounds(bounds);
		    } 
		}

		// 지도에 마커를 표시하는 함수입니다
		function displayMarker(place) {
		    
		    // 마커를 생성하고 지도에 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: new kakao.maps.LatLng(place.y, place.x) 
		    });

		    // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		    	// 클릭한 위도, 경도 정보를 가져옵니다 
		        var latlng = marker.getPosition();
		        
		        var message = latlng.getLat() + ',';
		        message += latlng.getLng();
		        
		        $('#msg2').val(message);
		        
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
		        infowindow.open(map, marker);
		    });
		}
		
	  var fileTarget = $('.filebox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            var filename = $(this)[0].files[0].name;
	        } else {
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        }

	        $(this).siblings('.upload-name').val(filename);
	     });
	    
	    $('#back').click(function(){
	    	location.href="BBL.jsp";
	    });
	    
	    $('#msg').focusout(function(){
	    	$('#msg').css('border-color','#ccc');
	    	$('#alertbar').css('display','none')
	    });
	    
	    $(document).submit(function(e){
	    	if($('#msg').val()==''){
	    		$('#msg').css('border-color','#e74c3c');
	    		$('#alertbar').css('display','block')
	    		return false;
	    	}
	    });
	    
	}); 

</script>
</html>