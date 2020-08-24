<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pagecontext.request.contextPath}/resources/css/common.css" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Open+Sans:wght@300;400;700&display=swap" rel="stylesheet">
<style>

body * {font-family: 'Open Sans', 'Noto Sans KR', sans-serif;}

#kakaoLogin {
	cursor: pointer;
}

#naverLogin {
	margin-left: 20px;
	margin-right: 20px;
	cursor: pointer;
}

#googleLogin {
	cursor: pointer;
}

#alzLogo{
	margin-left: 70px;
	width: 150px;
}

*{
  margin: 0;
  padding: 0;
  text-decoration: none;
  box-sizing: border-box;
}

body{
  min-height: 100vh;
  background-color: #eee;
}

.login-form{
  width: 360px;
  background: #fff;
  height: 580px;
  padding: 80px 40px;
  border-radius: 10px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

.login-form a{
	text-decoration: none;
	color: #335492;
}

.login-form h1{
  text-align: center;
  margin-bottom: 60px;
}

.txtb{
  border-bottom: 2px solid #adadad;
  position: relative;
  margin: 30px 0;
}

.txtb input{
  font-size: 15px;
  color: #333;
  border: none;
  width: 100%;
  outline: none;
  background: none;
  padding: 0 5px;
  height: 40px;
}

.txtb span::before{
  content: attr(data-placeholder);
  position: absolute;
  top: 45%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  z-index: -1;
  transition: .5s;
}

.txtb span::after{
  content: '';
  position: absolute;
  width: 0%;
  left:0px;
  top:40px;
  height: 2px;
  background-color: #335492;
  transition: .5s;
}

.focus + span::before{
  top: -5px;
}
.focus + span::after{
  width: 100%;
}

.logbtn{
  display: block;
  width: 100%;
  height: 50px;
  border: none;
  background: linear-gradient(120deg,#335492,#264785,#335492);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15); 
}

.logbtn:hover{
  background-position: right;
}

.bottom-text{
  margin-top: 20px;
  text-align: center;
  font-size: 13px;
}

.bottom-text img{
  border-radius: 50%;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15); 
}


</style>
</head>
<body>
	
	<form action="/login" method="post" class="login-form">
        <img src="/resources/img/로고.png" id="alzLogo">

        <div class="txtb">
          <input type="text" name="username" autocomplete="off">
          <span data-placeholder="이메일"></span>
        </div>

        <div class="txtb">
          <input type="password" name="password" autocomplete="off" onkeypress="if (event.keyCode==13) login()">
          <span data-placeholder="비밀번호"></span>
        </div>

        <input type="submit" class="logbtn" value="로그인">

        <div class="bottom-text">
          	계정이 없으신가요? <a href="/join">회원가입</a><br>
          	<br>
			<a href="/find_id_form">아이디 찾기</a>
			<a href="/findPwd">비밀번호 찾기</a><br>
			<br>
			<a id="kakaoLogin">
			<img src="resources/img/카카오로그인.png">
			</a>
			<a id="naverLogin">
			<img src="resources/img/네버로그인.png"></a>
			<a id="googleLogin">
			<img src="resources/img/구글로그인.png"></a><br>
			<br>
			<a href="/">메인 페이지 이동</a>
        </div>

      </form>

      <script type="text/javascript">


      </script>

	<hr>

	<script>
	
		$(document).ready(function(){
			
			let $kakaoLogin = $("#kakaoLogin");
			let $naverLogin = $("#naverLogin");
			let $googleLogin = $("#googleLogin");
			
		    $(".txtb input").on("focus",function(){
		      $(this).addClass("focus");
		    });

		    $(".txtb input").on("blur",function(){
		      if($(this).val() == "")
		      $(this).removeClass("focus");
		    });
			
			// 카카오 로그인 이벤트
			$kakaoLogin.click(function(e){
				e.preventDefault();
				$.ajax({
					url : "/kakao/request",
					method : "get",
					dataType : "json",
					headers : {
						"Accept" : "application/json", 
						"Content-Type" : "application/json"
					}, 
					success : function( JSONData ) {
						self.location = JSONData.url;
					}
				});
			});
			
			$naverLogin.click(function(e){
				e.preventDefault();
				$.ajax({
					url : "/naver/request",
					method : "get",
					dataType : "json",
					headers : {
						"Accept" : "application/json", 
						"Content-Type" : "application/json"
					}, 
					success : function( JSONData ) {
						self.location = JSONData.url;
					}
				});
			});
			
			$googleLogin.click(function(e){
				e.preventDefault();
				console.log("클릭");
				$.ajax({
					url : "/google/request",
					method : "get",
					dataType : "json",
					headers : {
						"Accept" : "application/json", 
						"Content-Type" : "application/json"
					}, 
					success : function( JSONData ) {
						console.log(JSONData);
						self.location = JSONData.url;
					},
					fail : function(error) {
						console.log(error);
					}
				});
			});
			
		});	
	
	</script>
</body>
</html>