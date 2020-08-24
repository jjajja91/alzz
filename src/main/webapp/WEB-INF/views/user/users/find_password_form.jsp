<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 페이지</title>
</head>
<body>

<!-- 비밀번호 찾기 페이지 -->
<!-- 에러메시지를 전달받는 함수 -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script>
	$(function() {
		var responseMessage = "${message}";
		if (responseMessage != "") {
			alert(responseMessage)
		}
	})
</script>
	<div style="width: 50rem; border-radius: 20px;">
		<!-- id와 이메일을 입력하면 컨트롤러로 맵핑 -->
			<div id="container">
				<span style="color: green; font-weight: bold;">비밀번호 찾기</span><br><br> 
				
				<span style="color: black; font-weight: bold;">닉네임</span><br><br> 
				<input type="text" name="nickname" placeholder="닉네임을 입력하세요." class="form-control"><br><br> 
				
				<span style="color: black; font-weight: bold;">이메일</span><br><br> 
				<input type="text" id= "email" name="email" placeholder="이메일을 입력하세요." class="form-control"><br><br>
				
				<button type="submit" id="sendEmailCode" name="submit" class="form-control btn btn-primary">인증번호발송</button><br><br>
				<input type="hidden" id="dice">
				
				<br> <span style="color: red; font-weight: bold;">인증번호 입력</span><br><br>
				<input type="text" id="inputCode" placeholder="인증번호를 입력하세요." class="form-control"><br><br>
				<input type="button" id="inputEmailCode" value="입력">
			</div>
				<form id="modifyPasswordForm" action="/modifyPwd" method="POST">
				</form>
	</div>
	
	<script>
		$(document).ready(function(){
			$sendEmailCodeBtn = $("#sendEmailCode");
			$emailInput = $("#email");
			$dice = $("#dice");
			$container = $("#container");
			$inputCode = $("#inputCode");
			$inputEmailCode = $("#inputEmailCode");
			$modifyPasswordForm = $("#modifyPasswordForm");
			
			$sendEmailCodeBtn.click(function(e){
				e.preventDefault();
				sendEmail($emailInput.val())
				.then(function(response){
					console.log(response);
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
							str += "<span style='color: black; font-weight: bold;'>수정할 비밀번호</span><br><br>";
							str += "<input type='password' id='password' name='password'><br><br><br>";
							str += "<span style='color: black; font-weight: bold;'>비밀번호 확인</span><br><br>";
							str += "<input type='password' id='passwordChk'><br><br>";
							str += "<button type='submit' id='submitBtn'>변경하기</button>";
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
