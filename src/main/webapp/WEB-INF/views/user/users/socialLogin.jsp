
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- <link rel="stylesheet" href="${pagecontext.request.contextPath}/resources/css/common.css" /> --%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<style>
#kakaoLogin {
	cursor: pointer;
}
</style>
</head>
<body>

	<h3>로그인</h3>

	<form action="/login" method="post">
		<table>
			<tr>
				<td>EMAIL</td>
				<td><input type="text" name="username" value="${email}"></td>
			</tr>

			<tr>
				<td>PW</td>
				<td><input type="password" name="password" autocomplete="off"
					placeholder="password" value="${id}">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">Log In</button> <a href="/find_id_form">아디찾기</a><br>
				</td>
			</tr>
		</table>
	</form>

	<hr>

	<a href="/">메인 페이지 이동</a>
	<script>
	
		$(document).ready(function(){
			let formObj = $("form");
			formObj.submit();
		});	
	
	</script>
</body>
</html>