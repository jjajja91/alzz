<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 페이지</title>
<link rel="stylesheet" type="text/css" href="resources/css/common.css" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
   crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&family=Open+Sans:wght@300;400;700&display=swap" rel="stylesheet">
<style>

body * {font-family: 'Open Sans', 'Noto Sans KR', sans-serif;}

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

.id-form{
  width: 360px;
  background: #fff;
  height: 580px;
  padding: 40px 40px;
  border-radius: 10px;
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%,-50%);
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

.id-form a{
	text-decoration: none;
	color: #335492;
}

.id-form h1{
  text-align: center;
  margin-bottom: 60px;
}

.txtb{
  border-bottom: 2px solid #adadad;
  position: relative;
  margin: 0 0 30px 0;
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

.idbtn{
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

.idbtn:hover{
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
	<div class="id-form">
		<img src="/resources/img/로고.png" id="alzLogo">
		<!-- id와 이메일을 입력하면 컨트롤러로 맵핑 -->
		<div>
			<div class="txtb" id="container">
				<br>
				<br>
				<input type="text" id="nickname" name="nickname" required>
          		<span data-placeholder="닉네임"></span>
				<br>
			</div>
			<div class="txtb" id="container">
				<br>
				<br>
				<input type="text" id="email" name="email" required>
          		<span data-placeholder="이메일"></span>
				<br>
			</div>
			<input type="submit" class="idbtn" id="sendEmailCode" value="인증번호발송">
			<input type="hidden" id="dice">
				
			<div class="txtb" id="container">
				<br>
				<br> 
				<input type="text" id="inputCode" name="inputCode" required>
          		<span data-placeholder="인증번호 입력"></span>
				<br>
			</div>
			<input type="submit" class="idbtn" id=inputEmailCode value="입력">
				
			<form id="modifyPasswordForm" action="/modifyPwd" method="POST">
			</form>
		</div>
	</div>
	<script>
		$(document).ready(function(){
			$sendEmailCodeBtn = $("#sendEmailCode");
			$emailInput = $("#email");
			$nicknameInput = $("#nickname")
			$dice = $("#dice");
			$container = $("#container");
			$inputCode = $("#inputCode");
			$inputEmailCode = $("#inputEmailCode");
			$modifyPasswordForm = $("#modifyPasswordForm");
			
			$sendEmailCodeBtn.click(function(e){
				e.preventDefault();
				var user = {
					email: $emailInput.val(),
					nickname: $nicknameInput.val()
				};
				
				checkUser(user).
				then(function(response){
					if(response==true){
						return sendEmail($emailInput.val());				
					} else {
						alert("해당하는 유저가 없습니다. 소셜회원은 해당 서비스에서 찾아주세요");
						return false;
					}
				})
				.then(function(response){
					console.log(response);
					if(response==false){
						return false;
					}
					alert("메일로 인증번호를 발송했습니다.");
					$dice.val(response);
					$inputEmailCode.click(function(e){
						e.preventDefault();
						if($inputCode.val()==$dice.val()){
							alert("인증에 성공하셨습니다.");
							$emailClone = $emailInput.clone();
							$emailClone.prop("type", "hidden");
							$container.remove();
							var str = "";
							str += "<div class='id-form'>";
							str += "<img src='/resources/img/로고.png' id='alzLogo'>";
							str += "<div class='txtb' id='container'>";
							str += "<br><br><input type='password' id='password' name='password' required>";
							str += "<span data-placeholder='수정할 비밀번호'></span><br></div>";
							str += "<div class='txtb' id='container'>";
							str += "<br><br><input type='password' id='passwordChk' required>";
							str += "<span data-placeholder='비밀번호 확인'></span><br></div>";
							str += "<input type='submit' class='idbtn' id='submitBtn' value='변경하기'></div>";
							$modifyPasswordForm.html(str);
							$modifyPasswordForm.append($emailClone);
							$submitBtn = $("#submitBtn");
							$password = $("#password");
							$passwordChk = $("#passwordChk");
							$submitBtn.click(function(e){
								e.preventDefault();
								if($password.val()==$passwordChk.val()){
									$modifyPasswordForm.submit();
								} else {
									alert("비밀번호 확인이 일치하지 않습니다.");
									$passwordChk.focus();
								}
							});
						} else {
							alert("일치하지 않은 코드입니다");
						}
					})
				})
				.catch(function(error){
					console.log(error);
				});
			});
			
			function checkUser(user) {
				return $.ajax({
					type : "POST",
					url : "/users/checkUser",
					data : JSON.stringify(user),
					contentType : "application/json"
				});
			}
			
			function sendEmail(email) {
				return $.ajax({
					type : "POST",
					url : "/users/emailCode",
					data : email,
					contentType : "application/text"
				});
			};
			
		});
	</script>
</body>
</html>
