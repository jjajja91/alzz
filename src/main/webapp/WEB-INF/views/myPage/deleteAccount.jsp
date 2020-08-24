<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<%@include file="../includes/myPageNav.jsp"%>
<style>
.container {
	margin-top: 350px;
	min-height: 100%;
	position: relative;
	text-align: center;
}

p, label, input, button {
	font-size: 24px;
	margin: 10px 5px;
	vertical-align: middle;
	text-align: center;
	padding: 6px 12px;
	cursor: pointer;
}

input {
	width: 350px;
}

button {
	background-color: #335492;
	color: #ffffff;
	border-radius: 5px 5px;
	border: 1px solid #dddddd;
	font-size: 20px;
	padding: 6px 12px;
	cursor: pointer;
}
</style>


<body>
	<div class="container">
		<c:if test="${param.verify eq 'no'}">
			<input type="hidden" name="verify"
				value='<c:out value="${param.verify}"/>'>
			<p>탈퇴에 실패했습니다.</p>
			<p>비밀번호를 다시 입력해 주세요.</p>
		</c:if>
		<form role="form" action="/myPage/deleteAcc" method="post">
			<div>
				<label for="password">비밀번호</label> <input type="password"
					name="password" autocomplete="off" placeholder="password">
			</div>
			<div>
				<label for="description">탈퇴사유</label> <input type="text"
					id="description" name="description">
			</div>
			<div>
				<button class="del" type=submit>탈퇴하기</button>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".del").click(function(e) {

				var delConfirm = confirm('정말로 탈퇴하시겠습니까?');

				if (delConfirm) {
				} else {
					e.preventDefault();
					self.location = "/myPage/boardList";
					return;
				}

			});

		});
	</script>
</body>
</html>