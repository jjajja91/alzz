<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="sendSms">
<!-- 	<form method="post" action="sendSms" id="smsForm"> -->
		<ul>
			<li>보낼사람 : <input type="text" name="from" placeholder="전화번호 입력 ( '-' 포함 )" /></li>
			<li>내용 : <textarea name="text" placeholder="보낼 내용 입력 "></textarea></li>
			<li>
				<!-- <input type="button" onclick="sendSMS('sendSms')"value="전송하기" /> -->
				<input type="submit" value="문자 보내기" class="btn btn-warning">
			</li>
		</ul>
	</form>

	<!-- <script>
		function sendSMS(pageName) {
			console.log("문자를 전송합니다.");
			$("#smsForm").attr("action", pageName);
			$("#smsForm").submit();
		}
	</script> -->
</body>
</html>