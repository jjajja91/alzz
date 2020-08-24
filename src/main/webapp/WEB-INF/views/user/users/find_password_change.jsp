<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="width: 50rem; border-radius: 20px;">
		<span style="color: green; font-weight: bold;">변경할 비밀번호를 입력해주세요.</span> <br> <br>
		<div style="text-align: center;">
			<form action="/find_password_result" method="post">
				<span style="color: black; font-weight: bold;">변경할 비밀번호 입력</span><br><br> 
				<input type="password" name="password" placeholder="비밀번호를 입력하세요." class="form-control"> <br><br>
				<input type="hidden" name="email" value="${email}">
				<button type="submit" name="submit" class="form-control btn btn-primary">비밀번호 변경</button>
			</form>
		</div>
	</div>
</body>
</html>