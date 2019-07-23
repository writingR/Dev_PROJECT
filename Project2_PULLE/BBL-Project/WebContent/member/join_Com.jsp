<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<title>사업자 가입페이지</title>
</head>
<style>
  ul{
	list-style: none;
  }
  label {
	width: 60px;
	display: inline-block;
	font-family: 'Nanum Gothic Coding', monospace;
  }
</style>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Monoton&display=swap" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="../js/bootstrap.js"></script>
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
		String company_ID = null;
		if (session.getAttribute("userID") != null || session.getAttribute("company_ID") != null){
			userID = (String)session.getAttribute("userID");
			company_ID = (String)session.getAttribute("company_ID");
		}
	%>
	
 	</br>
 	<script>
	 $(document).ready(function() {

		$('#btn').click(function() {
		//$('#uId').focusout(function() {	
			$('#idchkMsg').html("");
			$.ajax({
				url : 'idcheck.jsp',
				type : 'post',
				data : {
					company_ID : $('#company_ID').val(),
				},
				success : function(data) {
					//alert(data);

					if (data == 'Y') {
						alert("사용가능한 아이디입니다.")
						//$('body').append('<span style="color:blue;">NICE ID.</span>')
						$('#idchkMsg').html('멋진 아이디에요!');
						$('#idchkMsg').css('color','green');
					} else {
						alert("사용할 수 없는 아이디입니다.")
						//$('body').append('<span style="color:red;">INVALID ID.</span>')
						$('#idchkMsg').html('사용하실 수 없습니다.');
						$('#idchkMsg').css('color','red');
					}
					//$('body').append(data);
				}
			});
		
		});
		
		//$('#btn').click(function() {
		$('#company_Pw').focusout(function() {	
				$('#idchkMsg1').html("");
				$.ajax({
					url : 'idcheck.jsp',
					type : 'post',
					data : {
						company_Pw : $('#company_Pw').val(),
					},
					success : function(data) {
						//alert(data);

						if (data == 'Y') {
							/* alert("사용가능한 비밀번호입니다.") */
							//$('body').append('<span style="color:blue;">NICE ID.</span>')
							$('#idchkMsg1').html('적절한 비밀번호입니다.');
							$('#idchkMsg1').css('color','green');
						} else {
							/* alert("사용할 수 없습니다.") */
							//$('body').append('<span style="color:red;">INVALID ID.</span>')
							$('#idchkMsg1').html('사용불가합니다. 다시입력해주세요.');
							$('#idchkMsg1').css('color','red');
						}
						//$('body').append(data);
					}
				});
			
			});
		
		$('#company_rPw').focusout(function() {	
			$('#idchkMsg2').html("");
			$.ajax({
				url : 'idcheck.jsp',
				type : 'post',
				data : {
					company_rPw : $('#company_rPw').val(),
					company_Pw2 : $('#company_Pw2').val(),
				},
				success : function(data) {
					//alert(data);

					if (data == 'Y') {
						/* alert("비밀번호 체크가 완료되었습니다.") */
						//$('body').append('<span style="color:blue;">NICE ID.</span>')
						$('#idchkMsg2').html('비밀번호가 일치합니다.');
						$('#idchkMsg2').css('color','green');
					} else {
						/* alert("비밀번호가 다릅니다.") */
						//$('body').append('<span style="color:red;">INVALID ID.</span>')
						$('#idchkMsg2').html('비밀번호가 다릅니다.확인해주세요.');
						$('#idchkMsg2').css('color','red');
					}
					//$('body').append(data);
				}
			});
		
		});	
		
		$('#company_Name').focusout(function() {	
			$('#idchkMsg3').html("");
			$.ajax({
				url : 'idcheck.jsp',
				type : 'post',
				data : {
					company_rPw : $('#company_Name').val(),
				},
				success : function(data) {
					//alert(data);

					if (data == 'Y') {
						/* alert("실명확인이 완료되었습니다.") */
						//$('body').append('<span style="color:blue;">NICE ID.</span>')
						$('#idchkMsg3').html('본인이 맞습니다.');
						$('#idchkMsg3').css('color','green');
					} else {
						/* alert("본인 인증에 실패하셨습니다.") */
						//$('body').append('<span style="color:red;">INVALID ID.</span>')
						$('#idchkMsg3').html('본인 인증에 실패하셨습니다.');
						$('#idchkMsg3').css('color','red');
					}
					//$('body').append(data);
				}
			});
		
		});
		
		$('#company_Email').focusout(function() {	
			$('#idchkMsg4').html("");
			$.ajax({
				url : 'idcheck.jsp',
				type : 'post',
				data : {
					company_rPw : $('#company_Email').val(),
				},
				success : function(data) {
					//alert(data);

					if (data == 'Y') {
						/* alert("메일 인증이 완료되었습니다.") */
						//$('body').append('<span style="color:blue;">NICE ID.</span>')
						$('#idchkMsg4').html('사용 가능한 이메일 입니다.');
						$('#idchkMsg4').css('color','green');
					} else {
						/* alert("메일 인증에 실패했습니다.") */
						//$('body').append('<span style="color:red;">INVALID ID.</span>')
						$('#idchkMsg4').html('사용 불가한 이메일입니다.');
						$('#idchkMsg4').css('color','red');
					}
					//$('body').append(data);
				}
			});
		
		});
		
		$('#company_Num').focusout(function() {	
			$('#idchkMsg5').html("");
			$.ajax({
				url : 'idcheck.jsp',
				type : 'post',
				data : {
					company_rPw : $('#company_Num').val(),
				},
				success : function(data) {
					//alert(data);

					if (data == 'Y') {
						/* alert("메일 인증이 완료되었습니다.") */
						//$('body').append('<span style="color:blue;">NICE ID.</span>')
						$('#idchkMsg5').html('사용 가능한 사업자번호입니다.');
						$('#idchkMsg5').css('color','green');
					} else {
						/* alert("메일 인증에 실패했습니다.") */
						//$('body').append('<span style="color:red;">INVALID ID.</span>')
						$('#idchkMsg5').html('사용 불가한 사업자번호입니다.');
						$('#idchkMsg5').css('color','red');
					}
					//$('body').append(data);
				}
			});
		
		});


	  });
		
	</script>
 	
 	<div class="container">
		<span style ="color: black; font-size: 60px; margin-left: 330px; font-family: 'Sunflower', sans-serif;">사업자가입</span>
		<form action="joinProcess_com.jsp" method="post">
		   <fieldset style = "margin-left: 200px; margin-top: -20px;">
			  <!-- 	<legend style ="color: black; font-size: 60px; margin-left: 70px; font-family: 'Sunflower', sans-serif;">회원가입</legend> -->		  
			  	<ul>
					<li text-align="center"><label for="company_ID">아이디</label> </li>
   	 				<li> <input type="text" id="company_ID" name="company_ID" placeholder="아이디를 입력해주세요." style="width:350px;padding:3px">
   	 				<button class="btn btn-primary" type="button" id="btn">중복체크</button></li>
   	 				<span id="idchkMsg"></span>
             	</ul>			
				<ul>
   					<li><label for="company_Pw">비밀번호</label></li>
   					<li> <input type = "password"  id="company_Pw" name="company_Pw" placeholder="비밀번호를 입력해주세요." maxlength="50" style="width:440px; padding:3px;"></li>
   					<span id="idchkMsg1"></span>
  				</ul>
				<ul>
   					<li><label for="company_rPw">비밀번호</label></li>
  					<li> <input type = "password"  id="company_rPw" name="company_rPw" placeholder="비밀번호를 확인합니다. 다시 입력해주세요."  maxlength="50" style="width:440px; padding:3px;"> </li>
  					<span id="idchkMsg2"></span>
 				</ul>
  				<ul>
  					 <li><label for="company_Name">이름</label></li>
   					 <li> <input type = "text"  id="company_Name" name="company_Name" placeholder="이름을 입력해주세요."  maxlength="50" style="width:440px; padding:3px;"> </li>
   					 <span id="idchkMsg3"></span>
 				</ul>
				<ul>
   					 <li><label for="company_Email">이메일</label></li>
  					 <li><input type = "text" id="company_Email" name="company_Email" placeholder="이메일을 입력해주세요."  maxlength="50" style="width:440px; padding:3px;"></li>
  					 <span id="idchkMsg4"></span>
  				</ul>
  				<ul>
   					 <li><label for="company_Num">사업자</label></li>
  					 <li><input type = "text" id="company_Num" name="company_Num" placeholder="사업자번호를 입력해주세요."  maxlength="50" style="width:440px; padding:3px;"></li>
  					 <span id="idchkMsg5"></span>
  				</ul>
				<ul>
  				   <li><label for="company_Memo">비고</label></li>
   				   <li><textarea cols = "60" rows = "10" id="company_Memo" name="company_Memo" placeholder="멋진 자기소개를 입력해보세요!" ></textarea></li>
  				</ul>
  				<ul>
  				   <li colspan="2">
  				   <input type = "submit" value = "가입하기" style ="margin-left:18px; padding: 12px; width:220px; margin:5px; margin-top: -40px;"><input type = "reset" value="다시 입력" style ="padding:12px;width:210px">
  				   </li>
  				</ul>
			</fieldset>
		</form>
		

	</div>



</body>
</html>