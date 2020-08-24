<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="width: 40rem; border-radius: 20px;">
		<span style="color: green; font-weight: bold;">입력한 이메일로 받은 인증번호를 입력하세요.</span><br> 
		<span style="color: red; font-weight: bold;">(인증번호가맞아야 비밀번호를 변경하실 수 있습니다.)</span><br><br><br><br>
		<div style="text-align: center;">
			<form action="/find_password_change${dice},${email}" method="post">
				<span style="color: black; font-weight: bold;">인증번호</span><br><br> 
				<input type="number" name="find_password_change" placeholder="인증번호를 입력하세요." class="form-control"><br><br>
				<button type="submit" name="submit" class="form-control btn btn-primary">인증번호 전송</button>
			</form>
		</div>
	</div>
</body>
</html>