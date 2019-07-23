<%@page import="mainpage.model.MainPage"%>
<%@page import="mainpage.model.MainPageList"%>
<%@page import="mainpage.service.GetMainPageListService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("utf-8");
%>

<%

	//여기 나중에 수정
	String id = (String)session.getAttribute("userID");
	//나중에 로그인중에만 글쓰기 가능하게

	int pageNumber = 1;
	
	//핵심처리할 서비스 객체
	GetMainPageListService service = GetMainPageListService.getInstance();
	//응답 데이터의 결과
	MainPageList dataList = service.getMainPageList(pageNumber++, 9);
	pageNumber++;
	int mainPageTotal = dataList.getMainpageTotalCount();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css"/>
<title>뿔레?!</title>
<style>
	.mainATag{
		text-decoration: none;
		display: inline-block;
	    font-size: 12px;
	    color:#130f40;
	    font-weight: bold;
	    margin-bottom: 5px;
	    vertical-align: middle;
	}
	.mainATag2{
		text-decoration: none;
		display: inline-block;
	    font-size: 12px;
	    color:#aaa69d;
	    font-weight: bold;
	    vertical-align: middle;
	}

	#mainList {
	    width: 960px;
	    margin: 0 auto;
	}
	#list {
	    float: left;
	    width: 100%;
	    height: auto;
	    margin: auto 0px;
	    
	}
	
	.thumbnail{
	    width: 130px;
	    height: 110px;
	    margin: 0;
	}
	
	ul {
	    list-style: none;
	    margin: 0px;
	    padding: 0px;
	}
	.posts {
	    float: left;
	    width: 100%;
	    height: auto;
	    border-bottom: 1px solid #e4e4e4;
	    font-size: 12px;
	}
	.stPosts{
		float: left;
	    padding: 12px 10px;
	    min-height: 90px;
	    width: 960px;
	}
	
	.posts-user{

	    font-weight: bold;
    	color: #494949;
    	margin-bottom: 15px;
    }
	.posts-text {
	    float: left;
	    width: 760px;
	    text-align: left;
	}
	.date{
		width: 760px;
		float: left;
	}
	.posts-title {
	    float: left;
	    width: 640px;
	    color: #00cdcd;
	    font-weight: bold;
	    
	}
	.posts-content {
	    overflow: hidden;
	    float: left;
	    width: 640px;
	    color: #000;
	    height: 35px;
	    margin-bottom: 5px;
	}
	.posts-photo {
	    overflow: hidden;
	    float: right;
	    width: 130px;
	
	}
	.posts-edit {
		margin-left:5px;
		display: inline-block;
	    width: auto;
	    height: auto;
	    color: #999;
	    font-size: 12px;
	}
	
	#top {
	    float: left;
	    width: 960px;
	    height: auto;
	    text-align: center;
	    margin: auto 0px;
	}
	#loading{
	 	float: left;
	    width: 960px;
	    height: auto;
	    text-align: center;
	    margin: auto 0px;
	}
	#loadimg{
		width:50px;
	    height: 50px;
	    margin-top:20px;
	    margin-bottom: 20px;
	}
	
</style>
</head>



<body>


<!----------------- 네비게이션  시작-------------------->
	<jsp:include page ="/WEB-INF/nav/nav.jsp"/>
	<script>
		$(document).ready(function(){
			$('#BBL').addClass('active');
			$('#drop2').prepend('<li><a href="writeBBL.jsp">글쓰기</a></li>');
		});
	</script>
<!----------------- 네비게이션  끝------------------------>




	<div id="mainList">
		
		<ul id="list">
		</ul>
		
		<div id="loading">
		</div>
		
	</div>
	

</body>

<script>
	var first=true;
	var pageNumber = 3;
	var check = true;
	var maxPage = <%= mainPageTotal/3+1 %>;
	var id = '<%=id%>';
	function getList(){
		check = false;
		$('#loading').append("<img src='../img/loading.gif' id='loadimg'>");
        	$.ajax({ 
        		url : 'BBLContents.jsp', 
        		type : 'GET', 
        		data :{ pageNum : ++pageNumber } ,
        		dataType : "html",
        		contentType : "html", 
        		success : function(data){
        			setTimeout(function(){
        				$('#list').append(data);
        				$('#loadimg').remove();
        				check = true;
        			},1000); 
        		},
    		});
	}
	
	function getSearch(){
		check = false;
		$('#loading').append("<img src='../img/loading.gif' id='loadimg'>");
        	$.ajax({ 
        		url : 'BBLSearch.jsp', 
        		type : 'GET', 
        		data :{ pageNum : ++pageNumber } ,
        		dataType : "html",
        		contentType : "html", 
        		success : function(data){
        			setTimeout(function(){
        				$('#list').append(data);
        				$('#loadimg').remove();
        				check = true;
        			},1000); 
        		},
    		});
	}
	
	
	$(document).ready(function(){
		
			$('#write').click(function(e){
				e.preventDefault();
				if(id=="null"){
					alert("권한이 없습니다.\n로그인 후 이용가능합니다.");
				}else{
					location.href = "writeBBL.jsp";
				}
			});
			
			$.ajax({ 
	        	url : 'BBLContents.jsp', 
	        	type : 'GET', 
	        	data :{ pageNum : 1} ,
	        	dataType : "html",
	        	contentType : "html", 
	        	success : function(data){
	        		$('#list').html(data);
	        		$('#list').prepend('<li class="posts"></li>');
	        	}	        	
			});
			
			$('#searchbar').keyup(function(){
				$.ajax({ 
		        	url : 'BBLSearch.jsp', 
		        	type : 'GET', 
		        	data :{ pageNum : 1, word : $('#searchbar').val()} ,
		        	dataType : "html",
		        	contentType : "html", 
		        	success : function(data){
		        		$('#list').html(data);
		        		$('#list').prepend('<li class="posts"></li>');
		        		pageNumber = 4;
		        		maxPage=num/3+1;
		        		first=false;
		        	},
		    	});
				
			});
			
		
			$(window).scroll(function(){
	            let $window = $(this);
	            let scrollTop = $window.scrollTop();
	            let windowHeight = $window.height();
	            let documentHeight = $(document).height();
	            
	            //console.log("documentHeight:" + documentHeight + " | scrollTop:" + scrollTop + " | windowHeight: " + windowHeight );
	            
	            // scrollbar의 thumb가 바닥 전 30px까지 도달 하면 리스트를 가져온다.
	            if( scrollTop + windowHeight + 30 > documentHeight ){
		            if(check && maxPage>pageNumber){
		            	if(first){
		            		getList();
		            	}else{
		            		getSearch();
		            	}
		            	
		            	
		            }
	            }

			});
			
			$('.mainATag2').click(function(){
				if($('#authCheck').val()!="<%=id%>"){
						alert("권한이 없습니다.");
						return false;
				}
			});
		
		
	});
	
</script>

</html>