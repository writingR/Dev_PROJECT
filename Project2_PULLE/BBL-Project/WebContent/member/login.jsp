<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
<style>
 	img#kakao-login-btn{
		margin-top: 3px;
		margin-left: 3px;
	} 
</style>
<body>
	
	<!----------------- 네비게이션  시작-------------------->
		<jsp:include page ="/WEB-INF/nav/nav.jsp"/>
		<script>
			$(document).ready(function(){
				$('#home').addClass('active');
			});
		</script>
	<!----------------- 네비게이션  끝------------------------>
	
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
	%>
	
 	</br>
 	</br>
 	<div class="container">
		<div class=col-lg-4></div>
		<div class=col-lg-4>
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="loginProcess.jsp">
					<h3 style="text-align:center;font-family: 'Sunflower', sans-serif;">회원 로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디"
							   name="user_ID" maxlength="20">
					</div>		
					<div class="form-group">   
						<input type="password" class="form-control" placeholder="비밀번호"
							   name="user_Pw" maxlength="20">
					</div>		   	   
						<input type="submit" class="btn btn-defalut form-control" value="로그인">
						<input type="reset" class="btn btn-defalut form-control" value="취소" style="margin:5px; margin-left:-1px;">
						<a id="kakao-login-btn"></a>
						<a href="http://developers.kakao.com/logout"></a>
						<a href="https://nid.naver.com/nidlogin.login?mode=form&url=https%3A%2F%2Fwww.naver.com"><img src="../img/naverc.png" style="width:230px;height:50px;padding:8px;"></a>
						<input type="checkbox" style="margin-top:10px"> 로그인 상태유지
						<img src="../img/line1.png" style="width:350px;margin-left:-60px;margin-top:-30px;opacity:0.3;">
						<p style="text-align: center; font-size: 12px;margin-top: -40px; opacity: 0.8">이용약관 | <span style="font-weight: 900;">개인정보처리방침 </span>| 책임의 한계와 | 법적고지 | 회원정보 | 고객센터</p>
				</form>
			</div>
		</div>	
		<div class=col-lg-4></div>
	</div>


</body>



<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<script type='text/javascript'>

  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('a877efa95d50234a67facd1a9b75a349');
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton(
    		//설정 시작
    		{
			      container: '#kakao-login-btn',
			      size:'medium',
			      success: function(authObj) {
			        alert(JSON.stringify(authObj));
			        
				        Kakao.API.request({
				            url: '/v2/user/me',
				            success: function(res) {
				            	
				              alert(JSON.stringify(res));
				              /* alert(res.kakao_account.gender); */
				            },
				            fail: function(error) {
				              alert(JSON.stringify(error));
				            }
				          });
			      },
			      fail: function(err) {
			         alert(JSON.stringify(err));
			      }
			    }
    		//설정 끝
    	
    );
    
    $(document).ready(function(){

    	Kakao.Auth.loginForm(
        		{
    			      success: function(authObj) {
    			        alert(JSON.stringify(authObj));
    			        
    				        Kakao.API.request({
    				            url: '/v2/user/me',
    				            success: function(res) {
    				            	
    				              alert(JSON.stringify(res));
    				              alert(res.kakao_account.gender);
    				            },
    				            fail: function(error) {
    				              alert(JSON.stringify(error));
    				            }
    				          });
    			      },
    			      fail: function(err) {
    			         alert(JSON.stringify(err));
    			      }
    			    }
        		//설정 끝
        	
        );
    });
    
    
    
    $('#logoutb').click(function(){
		Kakao.Auth.logout();
	});
  //]]>
  
</script>

</html>